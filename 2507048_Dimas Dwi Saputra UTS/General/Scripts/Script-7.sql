CREATE DATABASE Akademik;
USE Akademik;

CREATE TABLE KRS_1NF (
    NIM VARCHAR(10) NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    KodeMK VARCHAR(10) NOT NULL,
    MataKuliah VARCHAR(100) NOT NULL,
    KodeDosen VARCHAR(10) NOT NULL,
    NamaDosen VARCHAR(100) NOT NULL,
    Nilai CHAR(2),
    PRIMARY KEY (NIM, KodeMK)
);

INSERT INTO KRS_1NF
    (NIM, Nama, KodeMK, 
     MataKuliah, KodeDosen, NamaDosen, Nilai)
VALUES
    ('M010', 'Dini', 'IF201', 'Pemrograman', 'D010', 'Rudi', 'A'),
    ('M010', 'Dini', 'IF202', 'Basis Data', 'D011', 'Maya', 'B'),
    ('M011', 'Eko', 'IF201', 'Pemrograman', 'D010', 'Rudi', 'B'),
    ('M012', 'Fani', 'IF203', 'Jaringan', 'D012', 'Tono', 'A');

SELECT * FROM KRS_1NF;