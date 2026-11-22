_________________________________________________
UTS PRAKTIKUM REKAYASA ARSITEKTUR BASIS data
-------------------------------------------------
Database : db_electromart (electromaart)
DBMS     : MySQL / MariaDB (DBngin+DBeaver)
Nama     : Dimas Dwi Saputra
Nim      : 2507048
--------------------------------------------------

(1.OKE KITAA MEMBUAT DATABASEENYA)

DROP DATABASE IF EXISTS db_electromart;
CREATE DATABASE db_electromart;
USE db_electromart;

(2.KITA LANJUT MEMBUAT TABELNYA)

CREATE TABLE produk (
    id_produk   VARCHAR(10) PRIMARY KEY NOT NULL,
    nama_produk VARCHAR(100) NOT NULL,
    kategori    VARCHAR(50)  NOT NULL,
    harga       DECIMAL(12,2) NOT NULL,
    stok        INT NOT NULL DEFAULT 0
);

CREATE TABLE pelanggan (
    id_pelanggan   VARCHAR(10) PRIMARY KEY NOT NULL,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE NOT NULL,
    no_hp          VARCHAR(20) NULL,
    alamat         TEXT NULL
);

CREATE TABLE pegawai (
    id_pegawai   VARCHAR(10) PRIMARY KEY NOT NULL,
    nama_pegawai VARCHAR(100) NOT NULL,
    peran        VARCHAR(30) NOT NULL,
    email        VARCHAR(100) UNIQUE NOT NULL,
    no_hp        VARCHAR(20) NULL
);

CREATE TABLE penjualan (
    id_penjualan VARCHAR(10) PRIMARY KEY NOT NULL,
    tanggal      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_pelanggan VARCHAR(10) NOT NULL,
    id_pegawai   VARCHAR(10) NOT NULL,
    total_harga  DECIMAL(12,2) NOT NULL DEFAULT 0,
    diskon       DECIMAL(12,2) NOT NULL DEFAULT 0,
    total_bayar  DECIMAL(12,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_pegawai)   REFERENCES pegawai(id_pegawai)
);

CREATE TABLE detail_penjualan (
    id_detail    INT AUTO_INCREMENT PRIMARY KEY,
    id_penjualan VARCHAR(10) NOT NULL,
    id_produk    VARCHAR(10) NOT NULL,
    jumlah       INT NOT NULL,
    harga_satuan DECIMAL(12,2) NOT NULL,
    subtotal     DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_produk)    REFERENCES produk(id_produk)
);

(Tabel log_stok (di file asli belum dibuat padahal dipakai INSERT, GRANT, dan trigger)
CREATE TABLE log_stok (
    id_log           INT AUTO_INCREMENT PRIMARY KEY,
    id_produk        VARCHAR(10) NOT NULL,
    jumlah_perubahan INT NOT NULL,
    tipe_transaksi   VARCHAR(10) NOT NULL,
    keterangan       VARCHAR(255) NULL,
    tanggal          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
);

(3.LANJUT KE DATAA AWAL)

INSERT INTO produk (id_produk, nama_produk, kategori, harga, stok) VALUES
('PRD001', 'Laptop Asus ZenBook 14', 'Laptop', 14500000.00, 15),
('PRD002', 'Mouse Wireless Logitech M330', 'Aksesoris', 250000.00, 50),
('PRD003', 'Keyboard Mekanikal Keychron K2', 'Aksesoris', 1200000.00, 3),
('PRD004', 'Monitor LG 27 Inch IPS', 'Monitor', 3200000.00, 8),
('PRD005', 'Smartphone Samsung Galaxy S23', 'Smartphone', 12999000.00, 10),
('PRD006', 'Smart TV Sony 55 Inch 4K', 'TV', 8500000.00, 2),
('PRD007', 'Headphone Sony WH-1000XM5', 'Audio', 4499000.00, 12),
('PRD008', 'Flashdisk SanDisk 64GB', 'Aksesoris', 85000.00, 100),
('PRD009', 'Printer Epson EcoTank L3210', 'Periferal', 2400000.00, 4),
('PRD010', 'Webcam Logitech C920', 'Aksesoris', 950000.00, 25);

INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, email, no_hp, alamat) VALUES
('PLG001', 'Budi Santoso', 'budi.santoso@email.com', '085611223344', 'Jl. Merdeka No. 12, Jakarta'),
('PLG002', 'Siti Aminah', 'siti.aminah@email.com', '085622334455', 'Jl. Mawar No. 5, Bandung'),
('PLG003', 'Rian Hidayat', 'rian.hidayat@email.com', '085633445566', 'Jl. Pemuda No. 88, Surabaya'),
('PLG004', 'Dewi Lestari', 'dewi.lestari@email.com', '085644556677', 'Jl. Diponegoro No. 45, Semarang'),
('PLG005', 'Ahmad Fauzi', 'ahmad.fauzi@email.com', '085655667788', 'Jl. Gajah Mada No. 20, Yogyakarta');

INSERT INTO pegawai (id_pegawai, nama_pegawai, peran, email, no_hp) VALUES
('PGW001', 'Andi Wijaya', 'role_admin', 'andi.admin@electromart.com', '081234567890'),
('PGW002', 'Maya Putri', 'role_penjualan', 'maya.sales@electromart.com', '081234567891'),
('PGW003', 'Eko Prasetyo', 'role_gudang', 'eko.gudang@electromart.com', '081234567892'),
('PGW004', 'Hendra Gunawan', 'role_manajer', 'hendra.manager@electromart.com', '081234567893');

INSERT INTO penjualan (id_penjualan, tanggal, id_pelanggan, id_pegawai, total_harga, diskon, total_bayar) VALUES
('TRX001', '2026-11-01 10:15:00', 'PLG001', 'PGW002', 15000000.00, 1500000.00, 13500000.00),
('TRX002', '2026-11-03 14:30:00', 'PLG002', 'PGW002', 850000.00, 0.00, 850000.00),
('TRX003', '2026-11-05 11:00:00', 'PLG003', 'PGW002', 4400000.00, 440000.00, 3960000.00),
('TRX004', '2026-11-08 16:45:00', 'PLG004', 'PGW002', 12999000.00, 1299900.00, 11699100.00);

INSERT INTO detail_penjualan (id_detail, id_penjualan, id_produk, jumlah, harga_satuan, subtotal) VALUES
(1, 'TRX001', 'PRD001', 1, 14500000.00, 14500000.00),
(2, 'TRX001', 'PRD002', 2, 250000.00, 500000.00),
(3, 'TRX002', 'PRD008', 10, 85000.00, 850000.00),
(4, 'TRX003', 'PRD003', 1, 1200000.00, 1200000.00),
(5, 'TRX003', 'PRD004', 1, 3200000.00, 3200000.00),
(6, 'TRX004', 'PRD005', 1, 12999000.00, 12999000.00);

INSERT INTO log_stok (id_log, id_produk, jumlah_perubahan, tipe_transaksi, keterangan, tanggal) VALUES
(1, 'PRD001', 16, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(2, 'PRD001', -1, 'KELUAR', 'Pengurangan stok dari TRX001', '2026-11-01 10:15:00'),
(3, 'PRD002', 52, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(4, 'PRD002', -2, 'KELUAR', 'Pengurangan stok dari TRX001', '2026-11-01 10:15:00'),
(5, 'PRD008', 110, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(6, 'PRD008', -10, 'KELUAR', 'Pengurangan stok dari TRX002', '2026-11-03 14:30:00'),
(7, 'PRD003', 4, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(8, 'PRD003', -1, 'KELUAR', 'Pengurangan stok dari TRX003', '2026-11-05 11:00:00'),
(9, 'PRD004', 9, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(10, 'PRD004', -1, 'KELUAR', 'Pengurangan stok dari TRX003', '2026-11-05 11:00:00'),
(11, 'PRD005', 11, 'MASUK', 'Stok awal barang masuk dari distributor', '2026-10-25 08:00:00'),
(12, 'PRD005', -1, 'KELUAR', 'Pengurangan stok dari TRX004', '2026-11-08 16:45:00');

(4.INDEXX)

CREATE INDEX idx_produk_kategori ON produk(kategori);
CREATE INDEX idx_penjualan_tanggal ON penjualan(tanggal);
CREATE INDEX idx_composite_pelanggan_tanggal ON penjualan(id_pelanggan, tanggal);

(5.ROLEE & HAK AKSES (DCL)

CREATE ROLE IF NOT EXISTS role_admin;
CREATE ROLE IF NOT EXISTS role_penjualan;
CREATE ROLE IF NOT EXISTS role_gudang;
CREATE ROLE IF NOT EXISTS role_manajer;

SII ADMIN:SEMUA HAK DI database INI 
GRANT ALL PRIVILEGES ON db_electromart.* TO role_admin;

Penjualan
GRANT SELECT ON db_electromart.produk    TO role_penjualan;
GRANT SELECT ON db_electromart.pelanggan TO role_penjualan;
GRANT INSERT, SELECT ON db_electromart.penjualan        TO role_penjualan;
GRANT INSERT, SELECT ON db_electromart.detail_penjualan TO role_penjualan;

Gudang
GRANT SELECT ON db_electromart.produk TO role_gudang;
GRANT UPDATE (stok) ON db_electromart.produk TO role_gudang;
GRANT SELECT, INSERT ON db_electromart.log_stok TO role_gudang;

Manajer
GRANT SELECT ON db_electromart.produk           TO role_manajer;
GRANT SELECT ON db_electromart.penjualan        TO role_manajer;
GRANT SELECT ON db_electromart.detail_penjualan TO role_manajer;

REVOKE INSERT ON db_electromart.log_stok FROM role_gudang;

FLUSH PRIVILEGES;

SELECT id_pelanggan, nama_pelanggan
FROM pelanggan;

(6.TRANSAKSI)

6a. COMMIT: transaksi TRX005 (Laptop + Mouse)
START TRANSACTION;

INSERT INTO penjualan (id_penjualan, tanggal, id_pelanggan, id_pegawai, total_harga, diskon, total_bayar)
VALUES ('TRX005', NOW(), 'PLG001', 'PGW002', 14750000.00, 1475000.00, 13275000.00);

INSERT INTO detail_penjualan (id_penjualan, id_produk, jumlah, harga_satuan, subtotal)
VALUES ('TRX005', 'PRD001', 1, 14500000.00, 14500000.00);

INSERT INTO detail_penjualan (id_penjualan, id_produk, jumlah, harga_satuan, subtotal)
VALUES ('TRX005', 'PRD002', 1, 250000.00, 250000.00);

SELECT * FROM detail_penjualan;

UPDATE produk SET stok = stok - 1 WHERE id_produk = 'PRD001';
UPDATE produk SET stok = stok - 1 WHERE id_produk = 'PRD002';

COMMIT;

START TRANSACTION;

UPDATE produk SET harga = 1000000.00 WHERE id_produk = 'PRD001';
SELECT id_produk, harga FROM produk WHERE id_produk = 'PRD001'; 

ROLLBACK;

SELECT id_produk, harga FROM produk WHERE id_produk = 'PRD001';   -- harga kembali 14.500.000

START TRANSACTION;

INSERT INTO penjualan (id_penjualan, tanggal, id_pelanggan, id_pegawai, total_harga, diskon, total_bayar)
VALUES ('TRX006', NOW(), 'PLG001', 'PGW002', 14500000.00, 1450000.00, 13050000.00);

SAVEPOINT sp_sebelum_detail;

INSERT INTO detail_penjualan (id_penjualan, id_produk, jumlah, harga_satuan, subtotal)
VALUES ('TRX006', 'PRD006', 1, 8500000.00, 8500000.00);

SELECT * FROM detail_penjualan WHERE id_penjualan = 'TRX006';

ROLLBACK TO sp_sebelum_detail;

SELECT * FROM detail_penjualan WHERE id_penjualan = 'TRX006';

INSERT INTO detail_penjualan (id_penjualan, id_produk, jumlah, harga_satuan, subtotal)
VALUES ('TRX006', 'PRD001', 1, 14500000.00, 14500000.00);

UPDATE produk SET stok = stok - 1 WHERE id_produk = 'PRD001';

COMMIT;

(7. STORED PROCEDURE)

DROP PROCEDURE IF EXISTS SP_Tampil_Produk;
DROP PROCEDURE IF EXISTS SP_Tambah_Produk;
DROP PROCEDURE IF EXISTS SP_Ubah_Harga;

DELIMITER //

CREATE PROCEDURE SP_Tampil_Produk()
BEGIN
    SELECT * FROM produk;
END //

CREATE PROCEDURE SP_Tambah_Produk(
    IN p_id VARCHAR(10),
    IN p_nama VARCHAR(100),
    IN p_kategori VARCHAR(50),
    IN p_harga DECIMAL(12,2),
    IN p_stok INT
)
BEGIN
    INSERT INTO produk (id_produk, nama_produk, kategori, harga, stok)
    VALUES (p_id, p_nama, p_kategori, p_harga, p_stok);
END //

CREATE PROCEDURE SP_Ubah_Harga(
    IN p_id VARCHAR(10),
    IN p_harga_baru DECIMAL(12,2)
)
BEGIN
    UPDATE produk SET harga = p_harga_baru WHERE id_produk = p_id;
END //

DELIMITER ;

CALL SP_Tampil_Produk();
CALL SP_Tambah_Produk('PRD011', 'Mousepad Gaming RGB', 'Aksesoris', 150000.00, 30);
CALL SP_Ubah_Harga('PRD011', 175000.00);

DROP PROCEDURE IF EXISTS SP_Ubah_Harga;

SELECT * FROM produk;

(8. FUNCTION)

DROP FUNCTION IF EXISTS hitung_diskon;

DELIMITER //

CREATE FUNCTION hitung_diskon(total_belanja DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_diskon DECIMAL(12,2);
    IF total_belanja >= 1000000 THEN
        SET v_diskon = total_belanja * 0.10;
    ELSE
        SET v_diskon = 0.00;
    END IF;
    RETURN v_diskon;
END //

DELIMITER ;

SELECT hitung_diskon(15000000.00) AS diskon_besar, hitung_diskon(500000.00) AS diskon_kecil;

SELECT * FROM penjualan;

(9. trigger)

DROP TRIGGER IF EXISTS validasi_penjualan;
DROP TRIGGER IF EXISTS update_stok_penjualan;

DELIMITER //

CREATE TRIGGER validasi_penjualan
BEFORE INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    DECLARE stok_sisa INT;
    SELECT stok INTO stok_sisa FROM produk WHERE id_produk = NEW.id_produk;

    IF stok_sisa < NEW.jumlah THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi ditolak: Jumlah pembelian melebihi stok produk yang tersedia!';
    END IF;
END //

CREATE TRIGGER update_stok_penjualan
AFTER INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    UPDATE produk
    SET stok = stok - NEW.jumlah
    WHERE id_produk = NEW.id_produk;

    INSERT INTO log_stok (id_produk, jumlah_perubahan, tipe_transaksi, keterangan)
    VALUES (NEW.id_produk, -NEW.jumlah, 'KELUAR',
            CONCAT('Pengurangan stok otomatis dari detail transaksi ID: ', NEW.id_penjualan));
END //

DELIMITER ;

INSERT INTO penjualan (id_penjualan, tanggal, id_pelanggan, id_pegawai, total_harga, diskon, total_bayar)
VALUES ('TRX007', NOW(), 'PLG002', 'PGW002', 8500000.00, hitung_diskon(8500000.00), 8500000.00 - hitung_diskon(8500000.00));

INSERT INTO detail_penjualan (id_penjualan, id_produk, jumlah, harga_satuan, subtotal)
VALUES ('TRX007', 'PRD006', 1, 8500000.00, 8500000.00);

SELECT id_produk, stok FROM produk WHERE id_produk = 'PRD006';
SELECT * FROM log_stok ORDER BY id_log DESC LIMIT 3;

SELECT * FROM detail_penjualan;

(10. VIEWW)

CREATE OR REPLACE VIEW View_Produk AS
SELECT id_produk, nama_produk, kategori, harga, stok
FROM produk;

CREATE OR REPLACE VIEW View_Transaksi AS
SELECT t.id_penjualan, t.tanggal, p.nama_pelanggan, t.total_bayar
FROM penjualan t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan;

CREATE OR REPLACE VIEW View_Laporan_Penjualan AS
SELECT DATE(t.tanggal) AS tanggal_transaksi,
       COUNT(t.id_penjualan) AS jumlah_transaksi,
       SUM(t.total_bayar) AS total_pendapatan
FROM penjualan t
GROUP BY DATE(t.tanggal);

CREATE OR REPLACE VIEW View_Stok_Rendah AS
SELECT id_produk, nama_produk, kategori, stok
FROM produk
WHERE stok < 5;

SELECT * FROM View_Stok_Rendah;

DROP VIEW IF EXISTS View_Produk;
