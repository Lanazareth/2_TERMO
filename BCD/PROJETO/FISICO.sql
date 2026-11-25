DROP DATABASE IF EXISTS clinica_ocupacional_monali;

CREATE DATABASE IF NOT EXISTS clinica_ocupacional_monali;

USE clinica_ocupacional_monali;

CREATE TABLE Empresa (
    Id_Empresa INT AUTO_INCREMENT PRIMARY KEY,
    Razao_Social VARCHAR(150) NOT NULL,
    Nome_Empresa VARCHAR(120),
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(120),
    endereco VARCHAR(200)
);

CREATE TABLE Tipo_Exame (
    Id_Tipo_Exame INT AUTO_INCREMENT PRIMARY KEY,
    nome_exame VARCHAR(100) NOT NULL,
    categoria_exame VARCHAR(50) NOT NULL,
    prazo_validade_dias INT,
    valor DECIMAL(10,2),
    descricao VARCHAR(255)
);

CREATE TABLE Paciente (
    Id_Paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    cargo VARCHAR(100) NOT NULL,
    setor VARCHAR(100),
    observacoes TEXT,
    restricoes TEXT
);

CREATE TABLE Atendimento (
    Id_Atendimento INT AUTO_INCREMENT PRIMARY KEY,
    data_atendimento DATETIME NOT NULL,
    tipo_atendimento VARCHAR(50) NOT NULL,
    queixa_principal TEXT,
    observacoes TEXT
);

CREATE TABLE Profissional (
    Id_Profissional INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    registro_profissional VARCHAR(30),
    especialidade VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    Id_Empresa INT,
    FOREIGN KEY (Id_Empresa) REFERENCES Empresa(Id_Empresa)
);

CREATE TABLE ASO (
    Id_ASO INT AUTO_INCREMENT PRIMARY KEY,
    tipo_aso VARCHAR(50) NOT NULL,
    data_emissao DATE NOT NULL,
    Id_Paciente INT,
    FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente)
);

CREATE TABLE Agendamento (
    Id_Agendamento INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATE NOT NULL,
    hora_agendamento TIME NOT NULL,
    tipo_atendimento VARCHAR(50) NOT NULL,
    status_agendamento VARCHAR(30) DEFAULT 'Pendente',
    Id_Profissional INT,
    FOREIGN KEY (Id_Profissional) REFERENCES Profissional(Id_Profissional)
);

CREATE TABLE Exame_Realizado (
    Id_Exame_Realizado INT AUTO_INCREMENT PRIMARY KEY,
    data_exame DATETIME NOT NULL,
    resultado VARCHAR(100),
    status_exame ENUM('Pendente', 'Realizado', 'Cancelado') DEFAULT 'Pendente',
    observacao TEXT,
    Id_ASO INT,
    FOREIGN KEY (Id_ASO) REFERENCES ASO(Id_ASO)
);

CREATE TABLE Realiza (
    Id_Agendamento INT,
    Id_Paciente INT,
    PRIMARY KEY (Id_Agendamento, Id_Paciente),
    FOREIGN KEY (Id_Agendamento) REFERENCES Agendamento(Id_Agendamento),
    FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente)
);

CREATE TABLE Refere_Se (
    Id_Tipo_Exame INT,
    Id_Agendamento INT,
    PRIMARY KEY (Id_Tipo_Exame, Id_Agendamento),
    FOREIGN KEY (Id_Tipo_Exame) REFERENCES Tipo_Exame(Id_Tipo_Exame),
    FOREIGN KEY (Id_Agendamento) REFERENCES Agendamento(Id_Agendamento)
);

CREATE TABLE Gera (
    Id_Agendamento INT,
    Id_Atendimento INT,
    PRIMARY KEY (Id_Agendamento, Id_Atendimento),
    FOREIGN KEY (Id_Agendamento) REFERENCES Agendamento(Id_Agendamento),
    FOREIGN KEY (Id_Atendimento) REFERENCES Atendimento(Id_Atendimento)
);

INSERT INTO Empresa (Razao_Social, Nome_Empresa, cnpj, telefone, email, endereco) VALUES 
('Saude Ocupacional Ltda', 'MedWork', '12345678000199', '11999998888', 'contato@medwork.com', 'Rua A, 100'),
('Medicina e Segurança do Trabalho Ltda', 'SafeWork', '12345678000200', '11999999999', 'contato@SafeWork.com', 'Rua B, 101'),
('Serviços Médicos Laborais Ltda', 'LaborMed', '12345678000201', '11999991111', 'contato@LaborMed.com', 'Rua C, 102'),
('Gestão em Saúde e Prevenção Ltda', 'PrevCare', '12345678000202', '11999992222', 'contato@PrevCare.com', 'Rua D, 103'),
('Clínica de Medicina do Trabalho Ltda', 'VitalMed', '12345678000203', '11999993333', 'contato@VitalMed.com', 'Rua E, 104'),
('Assessoria em Saúde e Segurança Ltda', 'ProSafe', '12345678000204', '11999994444', 'contato@ProfSafe.com', 'Rua F, 105'),
('Exames Ocupacionais e Clínicos Ltda', 'CheckWork', '12345678000205', '11999995555', 'contato@CheckWork.com', 'Rua G, 106'),
('Medicina Preventiva e Laboral Ltda', 'ActiMed', '12345678000206', '11999996666', 'contato@ActiMed.com', 'Rua H, 107'),
('Saúde Corporativa e Engenharia Ltda', 'CorpHealth', '12345678000207', '11999997777', 'contato@CorpHealth.com', 'Rua I, 108'),
('Centro Médico do Trabalhador Ltda', 'WorkCare', '12345678000208', '11999998888', 'contato@WorCare.com', 'Rua J, 109'),
('Soluções em Medicina Laboral Ltda', 'NexMed', '12345678000209', '11999991010', 'contato@Chec.com', 'Rua K, 110');

INSERT INTO Paciente (nome_completo, cpf, data_nascimento, telefone, email, cargo, setor) VALUES 
('Carlos Silva', '12345678901', '1990-05-15', '11988887777', 'carlos@email.com', 'Analista de Sistemas', 'TI'),
('Monyke Araujo', '12345678902', '2010-02-11', '11988888888', 'monyke@email.com', 'Médico Examinador', 'Medicina do Trabalho'),
('Lidia Eliana', '12345678903', '2009-04-23', '11988881111', 'lidia@email.com', 'Enfermeiro do Trabalho', 'Enfermagem'),
('Laura N', '12345678904', '2010-01-21', '11988882222', 'laura@email.com', 'Técnico em Enfermagem do Trabalho', 'Enfermagem'),
('Livia Vitoria', '12345678905', '2010-05-09', '11988883333', 'livia@email.com', 'Fonoaudiólogo', 'Exames Complementares'),
('José Pereira', '12345678906', '1991-04-25', '11988884444', 'jose@email.com', 'Técnico em Radiologia', 'Exames Complementares'),
('Lorena Nascimento', '12345678907', '2012-02-27', '11988885555', 'lorena@email.com', 'Biomédico', 'Exames Complementares'),
('Rafaela Oliveira', '12345678908', '2000-05-15', '11988886666', 'rafaela@email.com', 'Auxiliar de Coleta Laboratorial', 'Exames Complementares'),
('Jesica Cristina', '12345678909', '1990-07-19', '11988889999', 'jesica@email.com', 'Engenheiro de Segurança do Trabalho', 'Segurança do Trabalho'),
('Clara Souza', '12345678910', '1993-09-23', '11988881010', 'clara@email.com', 'Gerente Administrativo', 'Administrativo');

-- Atualizando dados de um paciente
UPDATE Paciente 
SET telefone = '11977776666' 
WHERE cpf = '12345678901';

-- Excluindo um registro de exame que foi cancelado (exemplo)
DELETE FROM Exame_Realizado 
WHERE status_exame = 'Cancelado';