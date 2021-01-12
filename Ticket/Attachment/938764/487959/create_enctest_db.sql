CREATE DATABASE EncTest COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE EncTest
GO

GRANT CONNECT TO guest
GO

CREATE TABLE Product(EAN varchar(13), Title varchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS)
GO

INSERT INTO Product(EAN, Title) VALUES('3880060000010', 'eBookbon: € 10');
SELECT * FROM Product
GO