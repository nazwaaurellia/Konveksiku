-- KonveksiKu - skema awal (PostgreSQL)

CREATE TABLE users (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  email         VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone         VARCHAR(20),
  role          VARCHAR(10) NOT NULL DEFAULT 'customer' CHECK (role IN ('customer','admin')),
  created_at    TIMESTAMP DEFAULT NOW()
);

CREATE TABLE products (          -- jenis produk: kaos, seragam, jaket, dll
  id         SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  base_price NUMERIC(12,2) NOT NULL
);

CREATE TABLE materials (         -- bahan: cotton combed, drill, dll
  id               SERIAL PRIMARY KEY,
  name             VARCHAR(100) NOT NULL,
  price_multiplier NUMERIC(5,2) NOT NULL DEFAULT 1.00
);

CREATE TABLE orders (
  id                  SERIAL PRIMARY KEY,
  user_id             INT NOT NULL REFERENCES users(id),
  product_id          INT NOT NULL REFERENCES products(id),
  material_id         INT NOT NULL REFERENCES materials(id),
  quantity            INT NOT NULL CHECK (quantity > 0),
  embroidery_notes    TEXT,                    -- detail bordir
  embroidery_stitches INT DEFAULT 0,           -- estimasi jumlah tusukan
  design_url          VARCHAR(255),            -- file desain unggahan
  total_price         NUMERIC(12,2) NOT NULL,  -- hasil penawaran otomatis
  status              VARCHAR(20) NOT NULL DEFAULT 'menunggu_dp'
    CHECK (status IN ('menunggu_dp','pembuatan_pola','pemotongan',
                      'penjahitan','bordir','siap_diambil','selesai','dibatalkan')),
  reorder_of          INT REFERENCES orders(id),   -- pemesanan ulang
  created_at          TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payments (
  id         SERIAL PRIMARY KEY,
  order_id   INT NOT NULL REFERENCES orders(id),
  type       VARCHAR(10) NOT NULL CHECK (type IN ('dp','pelunasan')),
  amount     NUMERIC(12,2) NOT NULL,
  proof_url  VARCHAR(255),
  status     VARCHAR(10) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','paid','rejected')),
  paid_at    TIMESTAMP
);

CREATE TABLE order_status_logs ( -- jejak pelacakan produksi
  id         SERIAL PRIMARY KEY,
  order_id   INT NOT NULL REFERENCES orders(id),
  status     VARCHAR(20) NOT NULL,
  note       TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE notifications (
  id         SERIAL PRIMARY KEY,
  user_id    INT NOT NULL REFERENCES users(id),
  order_id   INT REFERENCES orders(id),
  title      VARCHAR(150) NOT NULL,
  message    TEXT,
  is_read    BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);
