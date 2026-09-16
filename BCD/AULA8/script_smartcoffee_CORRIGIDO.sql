CREATE DATABASE SMARTCOFFEE_Laura;

USE SMARTCOFFEE_laura;


CREATE TABLE estoque (
nome varchar(60) not null,
Id_estoque int primary key auto_increment PRIMARY KEY,
quantidade int not null,
preco int not null,
unidade_medida varchar(20),
quantidade_minima int
)

CREATE TABLE Funcionarios (
nome varchar(60) not null,
cargo varchar(60) not null,
Id_funcionarios int primary key auto_increment PRIMARY KEY,
cpf datetime,
salario int,
date_admissao datetime,
Id_estoque int,
FOREIGN KEY(Id_estoque) REFERENCES estoque (Id_estoque)
)

CREATE TABLE Produtos (
quantidade int,
Id_produto int primary key auto_increment PRIMARY KEY,
preco_unitario int,
descricao int,
nome varchar(60) not null,
categoria varchar(60) not null
)

CREATE TABLE Programa_fidelidade (
Id_programa_fidelidade int primary key auto_increment PRIMARY KEY,
produto_consumo varchar(60),
nome_cliente varchar(60) not null,
pontos_acumulados int not null,
beneficios varchar(250),
data_cadastro datetime,
saldo_pontos varchar(250),
data_ultima_atualização date
)

CREATE TABLE delivery (
endereco varchar(60),
Id_delivery int primary key auto_increment PRIMARY KEY,
forma_pagamento varchar(60) not null,
status_entrega varchar(60),
taxa_entrega int,
data_hora_saida date
)

CREATE TABLE pagamentos (
Id_pagamentos  int primary key auto_increment,
nome_cliente varchar(60) not null,
forma_pagamento varchar(25) not null,
data_pagamento datetime,
valor int not null,
status_pagamento datetime
)

CREATE TABLE pedido (
Id_Pedidos  int primary key auto_increment,
nome_cliente varchar(60),
data_hora datetime,
numero_pedido int,
tipo_pedido varchar(60),
valor_total int
)



CREATE TABLE clientes (
Id_cliente int primary key auto_increment PRIMARY KEY,
CPF varchar(15) not null,
endereco varchar(100),
nome varchar(60) not null,
data_nascmento datetime not null,
data_cadastro datetime,
email varchar(25),
telefone varchar(15)
)

CREATE TABLE faz (
Id_cliente int,
Id_pagamentos int,
FOREIGN KEY (Id_pagamentos) REFERENCES clientes (Id_cliente),
FOREIGN KEY(Id_cliente) REFERENCES pagamentos (Id_pagamentos)
)

CREATE TABLE emite (
Id_pagamento int,
Id_delivery int,
FOREIGN KEY(Id_delivery) REFERENCES pagamentos (Id_pagamentos),
FOREIGN KEY(Id_pagamento) REFERENCES delivery (Id_delivery)
)

CREATE TABLE pede (
Id_cliente int,
Id_delivery int,
FOREIGN KEY(Id_delivery) REFERENCES clientes (Id_cliente),
FOREIGN KEY(Id_cliente) REFERENCES delivery (Id_delivery)
)

CREATE TABLE atende (
Id_funcionarios int,
Id_Pedidos int,
FOREIGN KEY(Id_Pedidos) REFERENCES Funcionarios (Id_funcionarios),
FOREIGN KEY (Id_funcionarios) REFERENCES pedido (Id_Pedidos)
)

CREATE TABLE CONTEM (
Id_produto int,
Id_Pedidos int,
FOREIGN KEY(Id_Pedidos) REFERENCES Produtos (Id_produto),
FOREIGN KEY(Id_produto)  REFERENCES pedido (Id_Pedidos)

)