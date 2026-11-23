-- KonveksiKu - skema awal (MySQL)
SET NAMES utf8mb4;

CREATE TABLE users (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  email         VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone         VARCHAR(20),
  role          ENUM('customer','admin') NOT NULL DEFAULT 'customer',
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products (          -- jenis produk: kaos, seragam, jaket, dll
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  base_price DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE materials (         -- bahan: cotton combed, drill, dll
  id               INT AUTO_INCREMENT PRIMARY KEY,
  name             VARCHAR(100) NOT NULL,
  price_multiplier DECIMAL(5,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB;

CREATE TABLE orders (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  user_id             INT NOT NULL,
  product_id          INT NOT NULL,
  material_id         INT NOT NULL,
  quantity            INT NOT NULL,
  embroidery_notes    TEXT,                     -- detail bordir
  embroidery_stitches INT DEFAULT 0,            -- estimasi jumlah tusukan
  design_url          VARCHAR(255),             -- file desain unggahan
  total_price         DECIMAL(12,2) NOT NULL,   -- hasil penawaran otomatis
  status              ENUM('menunggu_dp','pembuatan_pola','pemotongan',
                           'penjahitan','bordir','siap_diambil','selesai','dibatalkan')
                      NOT NULL DEFAULT 'menunggu_dp',
  reorder_of          INT NULL,                 -- pemesanan ulang
  created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_qty CHECK (quantity > 0),
  FOREIGN KEY (user_id)     REFERENCES users(id),
  FOREIGN KEY (product_id)  REFERENCES products(id),
  FOREIGN KEY (material_id) REFERENCES materials(id),
  FOREIGN KEY (reorder_of)  REFERENCES orders(id)
) ENGINE=InnoDB;

CREATE TABLE payments (
  id        INT AUTO_INCREMENT PRIMARY KEY,
  order_id  INT NOT NULL,
  type      ENUM('dp','pelunasan') NOT NULL,
  amount    DECIMAL(12,2) NOT NULL,
  proof_url VARCHAR(255),
  status    ENUM('pending','paid','rejected') NOT NULL DEFAULT 'pending',
  paid_at   DATETIME NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB;

CREATE TABLE order_status_logs ( -- jejak pelacakan produksi
  id         INT AUTO_INCREMENT PRIMARY KEY,
  order_id   INT NOT NULL,
  status     VARCHAR(20) NOT NULL,
  note       TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB;

CREATE TABLE notifications (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  user_id    INT NOT NULL,
  order_id   INT NULL,
  title      VARCHAR(150) NOT NULL,
  message    TEXT,
  is_read    TINYINT(1) DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id)  REFERENCES users(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB;
