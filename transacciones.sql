create database transacciones;

use transacciones;
create table cliente(
id_cliente int primary key ,
Nombre varchar (30) not null,
Saldo int);

insert into cliente values (1,"Juan",100000), (2,"Pedro",50000);
select * from cliente;

DELIMITER //

CREATE PROCEDURE TransferirDinero(IN Juan VARCHAR(30), IN Pedro VARCHAR(30), IN Saldo INT)
BEGIN
    DECLARE saldo1 INT;
    DECLARE saldo2 INT;
    SET @Juan = Juan;
    SET @Pedro = Pedro;
    SET @Saldo = Saldo;
    
    START TRANSACTION;
    
    SELECT Saldo INTO saldo1 FROM cliente WHERE Nombre = @Juan;
    SELECT Saldo INTO saldo2 FROM cliente WHERE Nombre = @Pedro;
    
    IF (saldo1 >= @Saldo) THEN
        UPDATE cliente SET Saldo = saldo1 - @10000 WHERE Nombre = @Juan;
        UPDATE cliente SET Saldo = saldo2 + @10000 WHERE Nombre = @Pedro;
        SELECT 'Transferencia exitosa' AS Resultado;
        COMMIT;
    ELSE
        SELECT 'Fondos insuficientes' AS Resultado;
        ROLLBACK;
    END IF;
END //

DELIMITER ;
