-- Active: 1794917650770@@127.0.0.1@3306@clinica_ocupacional_monali
DROP DATABASE IF EXISTS clinica_ocupacional_monali;

create DATABASE if not EXISTS clinica_ocupacional_monali;

use clinica_ocupacional_monali;

CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT,
    razao_social VARCHAR(150) NOT NULL,
    nome_empresa VARCHAR(120),
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(120),
    endereco VARCHAR(200),

    CONSTRAINT pk_empresa PRIMARY KEY (id_empresa)
);

CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT,
    id_empresa INT,
    nome_completo VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    cargo VARCHAR(100) NOT NULL,
    setor VARCHAR(100),

    CONSTRAINT pk_paciente PRIMARY KEY (id_paciente),
    CONSTRAINT fk_paciente_empresa FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE profissional (
    id_profissional INT AUTO_INCREMENT,
    nome_completo VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    registro_profissional VARCHAR(30),
    especialidade VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(120) UNIQUE,

    CONSTRAINT pk_profissional PRIMARY KEY (id_profissional)
);

CREATE TABLE tipo_exame (
    id_tipo_exame INT AUTO_INCREMENT,
    nome_exame VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    valor DECIMAL(10,2),
    prazo_validade_dias INT,

    CONSTRAINT pk_tipo_exame PRIMARY KEY (id_tipo_exame),

    CONSTRAINT uq_nome_exame UNIQUE (nome_exame)
);

CREATE TABLE agendamento (
    id_agendamento INT AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_profissional INT NOT NULL,
    data_agendamento DATE NOT NULL,
    hora_agendamento TIME NOT NULL,
    tipo_atendimento VARCHAR(50) NOT NULL,
    status_agendamento VARCHAR(30) DEFAULT 'Agendado',

    CONSTRAINT pk_agendamento PRIMARY KEY (id_agendamento),
    CONSTRAINT fk_agendamento_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_agendamento_profissional FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional)
);


CREATE TABLE atendimento (
    id_atendimento INT AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_profissional INT NOT NULL,
    id_agendamento INT,
    data_atendimento DATETIME NOT NULL,
    tipo_atendimento VARCHAR(50) NOT NULL,
    queixa_principal TEXT,
    observacoes TEXT,

    CONSTRAINT pk_atendimento PRIMARY KEY (id_atendimento),
    CONSTRAINT fk_atendimento_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_atendimento_profissional FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional),
    CONSTRAINT fk_atendimento_agendamento FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento)
);
