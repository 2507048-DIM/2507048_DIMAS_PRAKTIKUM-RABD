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

CREATE TABLE Mahasiswa_2NF (
    NIM VARCHAR(10) NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    PRIMARY KEY (NIM)
);
 
CREATE TABLE MataKuliah_2NF (
    KodeMK VARCHAR(10) NOT NULL,
    MataKuliah VARCHAR(100) NOT NULL,
    KodeDosen VARCHAR(10) NOT NULL,
    NamaDosen VARCHAR(100) NOT NULL,
    PRIMARY KEY (KodeMK)
);
 
CREATE TABLE KRS_2NF (
    NIM VARCHAR(10) NOT NULL,
    KodeMK VARCHAR(10) NOT NULL,
    Nilai CHAR(2),
    PRIMARY KEY (NIM, KodeMK),
    FOREIGN KEY (NIM) REFERENCES Mahasiswa_2NF(NIM),
    FOREIGN KEY (KodeMK) REFERENCES MataKuliah_2NF(KodeMK)
);
 
INSERT INTO Mahasiswa_2NF (NIM, Nama)
VALUES
    ('M010', 'Dini'),
    ('M011', 'Eko'),
    ('M012', 'Fani');
 
INSERT INTO MataKuliah_2NF
    (KodeMK, MataKuliah, KodeDosen, NamaDosen)
VALUES
    ('IF201', 'Pemrograman', 'D010', 'Rudi'),
    ('IF202', 'Basis Data', 'D011', 'Maya'),
    ('IF203', 'Jaringan', 'D012', 'Tono');
 
INSERT INTO KRS_2NF (NIM, KodeMK, Nilai)
VALUES
    ('M010', 'IF201', 'A'),
    ('M010', 'IF202', 'B'),
    ('M011', 'IF201', 'B'),
    ('M012', 'IF203', 'A');
 
SELECT * FROM Mahasiswa_2NF;
SELECT * FROM MataKuliah_2NF;
SELECT * FROM KRS_2NF;


