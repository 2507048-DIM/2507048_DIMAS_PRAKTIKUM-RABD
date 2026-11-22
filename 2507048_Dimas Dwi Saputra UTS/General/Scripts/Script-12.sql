CREATE DATABASE praktikum_produk;

use praktikum_produk;

CREATE TABLE `produk` (
  `ID_Produk` char(3) NOT NULL PRIMARY KEY,
  `Nama_Produk` varchar(50) DEFAULT NULL,
  `Kategori` varchar(30) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `Harga` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `produk` (`ID_Produk`, `Nama_Produk`, `Kategori`, `Stok`, `Harga`) VALUES
('P01', 'Laptop', 'Elektronik', 10, '7500000.00'),
('P02', 'Mouse', 'Aksesori', 25, '150000.00'),
('P03', 'Keyboard', 'Aksesori', 20, '250000.00'),
('P04', 'Printer', 'Elektronik', 8, '1800000.00'),
('P05', 'Speaker', 'Audio', 15, '350000.00'),
('P06', 'Monitor', 'Elektronik', 12, '2200000.00'),
('P07', 'Webcam', 'Aksesori', 18, '400000.00');

select * from produk;

delimiter //
create procedure sp1()
begin
	select * from produk;
end//
delimiter ;

end

DELIMITER $$
CREATE PROCEDURE SP2(
p_idproduk char(3),
p_namaproduk varchar(50),
p_kategori varchar(30),
p_stok int,
p_harga decimal(12,2)
)
begin
	insert into produk
	(id_produk,nama_produk,kategori,stok,harga)
	values
	(p_idproduk,p_namaproduk,p_kategori,p_stok,p_harga);

select * from produk;
end$$
delimiter ;
end

drop procedure sp2;
show procedure status where db = 'praktikum_produk';

call SP2('p0b', 'tablet', 'elektronik', 14, 3200000);

delimiter
create procedure sp3(
     p_hargalama decimal(12,2),
      p_hargabaru decimal(12,2)
)
begin
	update produk
	set harga = p_hargabaru
	where harga = p_hargalama;

select nama_produk,harga from produk;
end$$
delimiter ;

call sp3(150000, 175000);
end
