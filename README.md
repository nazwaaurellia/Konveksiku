# KonveksiKu

> Aplikasi layanan konveksi jahit & bordir berbasis mobile.
> Tugas UTS — Pemrograman Aplikasi Bergerak, Program Studi Sistem Informasi, TA 2026/2027.

## Identitas Mahasiswa

| Nama | NIM |
|------|-----|
| Nazwa Aurellia Aurellia Ababiluna Putri | 24051214226 |

## Jenis Aplikasi

Aplikasi **orisinal** bernama **KonveksiKu** (bukan plesetan dari aplikasi lain).

## Deskripsi

KonveksiKu memudahkan pelanggan memesan dan memantau pesanan produk konveksi dalam satu platform.

**Fitur utama**
- Pemesanan online dengan unggah desain
- Penawaran harga otomatis (jenis produk, bahan, jumlah, detail bordir)
- Pembayaran DP dan pelunasan
- Pelacakan status produksi: pembuatan pola → pemotongan → penjahitan → bordir → siap diambil
- Notifikasi setiap status pesanan berubah
- Riwayat pesanan & pemesanan ulang

## Tech Stack

| Layer | Teknologi |
|-------|-----------|
| Frontend | Flutter (Dart) |
| Backend | REST API — Node.js + Express |
| Database | MySQL (via Laragon) |

## Struktur Repositori

```
konveksiku/
├── mobile/      # Aplikasi Flutter
├── backend/     # REST API
├── database/    # Skrip SQL / migration
└── docs/        # Arsitektur, ERD, dokumentasi API
```

## Panduan Menjalankan

### 1. Database (MySQL)
Jalankan MySQL dari Laragon (Start All), lalu:
```bash
mysql -u root -e "CREATE DATABASE konveksiku CHARACTER SET utf8mb4"
mysql -u root konveksiku < database/migrations/001_init.sql
```

### 2. Backend
```bash
cd backend
copy .env.example .env     # sesuaikan konfigurasi DB
npm install
npm run dev                # berjalan di http://localhost:3000
```

### 3. Mobile (Flutter)
```bash
cd mobile
flutter pub get
flutter run
```
> Emulator Android mengakses backend lewat `http://10.0.2.2:3000`.

## Video Demo
(tautan YouTube diisi setelah video diunggah)
