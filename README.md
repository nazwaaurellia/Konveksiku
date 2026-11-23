# KonveksiKu

> Aplikasi layanan konveksi jahit & bordir berbasis mobile.
> Tugas UTS — Pemrograman Aplikasi Bergerak, Program Studi Sistem Informasi, TA 2026/2027.

## Anggota Kelompok

| No | Nama | NIM | Peran |
|----|------|-----|-------|
| 1  | (isi nama) | (isi NIM) | (mis. Flutter UI) |
| 2  | (isi nama) | (isi NIM) | (mis. Backend API) |
| 3  | (isi nama) | (isi NIM) | (mis. Database & Testing) |

## Aplikasi Asli & Nama Plesetan

| Aplikasi Asli | Nama Plesetan |
|---------------|---------------|
| (isi aplikasi asli) | **KonveksiKu** |

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
| Database | PostgreSQL |

## Struktur Repositori

```
konveksiku/
├── mobile/      # Aplikasi Flutter
├── backend/     # REST API
├── database/    # Skrip SQL / migration
└── docs/        # Arsitektur, ERD, dokumentasi API
```

## Panduan Menjalankan

### 1. Database
```bash
createdb konveksiku
psql -d konveksiku -f database/migrations/001_init.sql
```

### 2. Backend
```bash
cd backend
cp .env.example .env     # sesuaikan konfigurasi DB
npm install
npm run dev              # berjalan di http://localhost:3000
```

### 3. Mobile (Flutter)
```bash
cd mobile
flutter pub get
flutter run
```
> Emulator Android mengakses backend lewat `http://10.0.2.2:3000`.

## Pembagian Tugas
Lihat tabel anggota di atas dan riwayat commit/PR.

## Video Demo
(tautan YouTube diisi setelah video diunggah)
