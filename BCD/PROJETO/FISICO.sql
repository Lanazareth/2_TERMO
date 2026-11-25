

CREATE TABLE Tipo_Exame (
Id_Tipo_Exame int auto_increment primary key PRIMARY KEY,
prazo_validade_dias int,
categoria_exame varchar(50) not null,
valor decimal(10,2),
nome_exame varchar(100) not null,
descricao varchar(255)
)

CREATE TABLE Agendamento (
data_pagamento date not null,
tipo_atendimento varchar(50) not null,
staus_agendamento varchar(30) default ,
Id_Agendamento int auto_increment primary key PRIMARY KEY,
hora_agendamento time not null,
Id_Profissional int auto_increment primary key
)

CREATE TABLE Profissional (
noeme_completo varchar(150) not null,
cpf char(11) not null unique,
registro_proficional varchar(30),
especialidade varchar(100),
telefone varchar(20),
email varchar(120) unique,
Id_Profissional int auto_increment primary key PRIMARY KEY,
Id_Empresa int auto_increment primary key
)

CREATE TABLE Empresa (
Razao_Social varchar(150) not null,
Nome_Emprsea varchar(120),
cnpj char(14) not null unique,
telefone varchar(20),
email varchar(120),
endereco varchar(200),
Id_Empresa int auto_increment primary key PRIMARY KEY
)

CREATE TABLE Atendimento (
data_atendimento datetime not null,
tipo_atendimento varchar(50) not null,
queixa_principal text,
observacoes text,
Id_Atendimento int auto_increment primary key PRIMARY KEY
)

CREATE TABLE Exame_Realizado (
Id_Exame_Realizado int auto_increment primary key PRIMARY KEY,
data_exame datetime not null,
resultado varchar(100),
status_exame enum default,
observacao text,
Id_ASO int auto_increment primary key
)

CREATE TABLE Paciente+ASO (
nome_completo varchar(150) not null,
cpf char(11) not null unique,
data_nascimento date not null,
telefone varchar(20),
email varchar(120) unique,
cargo varchar(100) not null,
setor varchar(100),
Id_Paciente int auto_increment primary key,
observacoes text,
restricoes text,
tipo_aso text,
data_emissao date not null,
Id_ASO int auto_increment primary key,
PRIMARY KEY(Id_Paciente,Id_ASO)
)

CREATE TABLE Realiza (
Id_Agendamento int auto_increment primary key,
Id_Paciente int auto_increment primary key,
FOREIGN KEY(Id_Agendamento) REFERENCES Agendamento (Id_Agendamento),
FOREIGN KEY( REFERENCES Paciente+ASO (Id_Paciente,Id_ASO)
)

CREATE TABLE Refere-se (
Id_Tipo_Exame int auto_increment primary key,
Id_Agendamento int auto_increment primary key,
FOREIGN KEY(Id_Tipo_Exame) REFERENCES Tipo_Exame (Id_Tipo_Exame),
FOREIGN KEY(Id_Agendamento) REFERENCES Agendamento (Id_Agendamento)
)

CREATE TABLE Gera (
Id_Agendamento int auto_increment primary key,
Id_Atendimento int auto_increment primary key,
FOREIGN KEY(Id_Agendamento) REFERENCES Agendamento (Id_Agendamento),
FOREIGN KEY(Id_Atendimento) REFERENCES Atendimento (Id_Atendimento)
)

ALTER TABLE Agendamento ADD FOREIGN KEY(Id_Agendamento) REFERENCES  Agendamento(Id_Agendamento)
ALTER TABLE Profissional ADD FOREIGN KEY(Id_Profissional) REFERENCES  Profissional(Id_Profissional)
ALTER TABLE Exame_Realizado ADD FOREIGN KEY(Id_exame_realizado) REFERENCES  exame_realizado(Id_Exame_Realizado)