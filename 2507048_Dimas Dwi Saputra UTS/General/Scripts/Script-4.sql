create database praktikum_transaksi;
use praktikum_transaksi;

create table rekening (
     id int primary key,
     nama varchar(50) not null,
     saldo decimal(12,2) not null,
     constraint chk_saldo_nonnegatif check (saldo >=0)
     ) engine=InnoDB;

insert into rekening (id,nama,saldo) values 
(1, 'budi',500000),
(2, 'siti',250000);

select * from rekening;