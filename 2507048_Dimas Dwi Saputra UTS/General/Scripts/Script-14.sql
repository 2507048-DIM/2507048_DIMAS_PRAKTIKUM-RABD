CREATE DATABASE db_distribusi;
USE db_distribusi;

CREATE TABLE barang (
    kode_barang VARCHAR(10) PRIMARY KEY,
    nama_barang VARCHAR(50) NOT NULL,
    kategori    VARCHAR(30) NOT NULL,
    harga       INT NOT NULL,
    stok        INT NOT NULL
);

CREATE TABLE penjualan (
    no_transaksi VARCHAR(10) PRIMARY KEY,
    tanggal      DATE NOT NULL,
    kode_barang  VARCHAR(10) NOT NULL,
    jumlah       INT NOT NULL,
    FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang)
);

INSERT INTO barang VALUES
('BR001','Kertas A4','ATK',65000,120),
('BR002','Tinta Printer','Elektronik',85000,45),
('BR003','Pulpen','ATK',2500,500),
('BR004','Toner Printer','Elektronik',450000,20),
('BR005','Map Arsip','ATK',5000,200),
('BR006','Kalkulator','Elektronik',125000,35),
('BR007','Buku Agenda','ATK',18000,80),
('BR008','Label Pengiriman','Kemasan',12000,150);

INSERT INTO penjualan VALUES
('TR001','2026-10-01','BR001',10),
('TR002','2026-10-02','BR002',5),
('TR003','2026-10-03','BR003',50),
('TR004','2026-10-04','BR005',20),
('TR005','2026-10-05','BR007',15);