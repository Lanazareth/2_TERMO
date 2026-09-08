-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE fornecedor (
ID_fornecedor int auto_increment primary key PRIMARY KEY,
razao_socila varchar(100) not null
)

CREATE TABLE Produto (
ID_produto int auto_increment primary key PRIMARY KEY,
nome_produto varchar(100) not null
)

CREATE TABLE Item_produto (
ID_produto int unique ,
ID_fornecedor int unique,
Qtde int not null,
OBS: text(300),
ID_item int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_produto) REFERENCES Produto (ID_produto)
)

