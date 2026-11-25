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
    categoria_exame VARCHAR(50) NOT NULL,
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
CREATE TABLE exame_realizado (
    id_exame_realizado INT AUTO_INCREMENT,
    id_atendimento INT NOT NULL,
    id_tipo_exame INT NOT NULL,
    data_exame DATETIME NOT NULL,
    resultado VARCHAR(100),
    observacao TEXT,
    status_exame ENUM(
        'Solicitado',
        'Em Analise',
        'Concluido',
        'Cancelado'
    ) DEFAULT 'Solicitado',

   CONSTRAINT pk_exame_realizado PRIMARY KEY (id_exame_realizado),
    CONSTRAINT fk_exame_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento),
    CONSTRAINT fk_exame_tipo FOREIGN KEY (id_tipo_exame) REFERENCES tipo_exame(id_tipo_exame)
);


CREATE TABLE aso (
    id_aso INT AUTO_INCREMENT,
    id_atendimento INT NOT NULL,
    data_emissao DATE NOT NULL,
    tipo_aso ENUM(
        'Admissional',
        'Periodico',
        'Demissional',
        'Retorno',
        'Mudanca de Funcao'
    ) NOT NULL,
    resultado ENUM(
        'Apto',
        'Inapto',
        'Apto com Restricao'
    ) NOT NULL,
    restricoes TEXT,
    observacoes TEXT,

    CONSTRAINT pk_aso PRIMARY KEY (id_aso),
    CONSTRAINT fk_aso_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento)
);

INSERT INTO empresa (razao_social, nome_empresa, cnpj, telefone, email, endereco)VALUES
    ('Monali Transportes LTDA', 'Monali Transportes', '12345678000199', '(11) 99999-1111','contato@monali.com', 'Rua Central, 100');


INSERT INTO profissional(nome_completo, cpf, registro_profissional, especialidade, telefone, email)VALUES
    ('Dra. Ana Souza', '11122233344', 'CRM123456','Medicina do Trabalho', '(11) 98888-2222','ana@clinica.com');


INSERT INTO paciente (id_empresa, nome_completo, cpf, data_nascimento, telefone, email, cargo, setor)
VALUES (1, 'Carlos Oliveira', '55566677788', '1995-04-10', '(11) 97777-3333', 'carlos@email.com', 'Auxiliar Administrativo', 'Financeiro');


INSERT INTO tipo_exame (categoria_exame, nome_exame, descricao, valor, prazo_validade_dias) VALUES
('Clínico', 'Exame Clínico Ocupacional', 'Avaliação clínica realizada pelo médico do trabalho', 150.00, 365),
('Complementar', 'Audiometria', 'Avaliação da capacidade auditiva do trabalhador', 80.00, 365),
('Complementar', 'Acuidade Visual', 'Avaliação da capacidade visual', 60.00, 365),
('Complementar', 'Espirometria', 'Avaliação da função pulmonar', 120.00, 365);


INSERT INTO agendamento(id_paciente, id_profissional, data_agendamento, hora_agendamento, tipo_atendimento, status_agendamento)VALUES
(1, 1, '2026-12-01', '08:30:00', 'Admissional', 'Agendado');


SELECT nome_exame, categoria_exame, valor 
FROM tipo_exame 
WHERE categoria_exame = 'Complementar' 
ORDER BY valor DESC;


SELECT 
    a.data_agendamento,
    a.hora_agendamento,
    p.nome_completo AS paciente,
    e.nome_empresa AS empresa,
    pr.nome_completo AS medico,
    a.tipo_atendimento,
    a.status_agendamento
FROM agendamento a
INNER JOIN paciente p ON a.id_paciente = p.id_paciente
INNER JOIN empresa e ON p.id_empresa = e.id_empresa
INNER JOIN profissional pr ON a.id_profissional = pr.id_profissional;


SELECT 
    aso.id_aso,
    aso.data_emissao,
    p.nome_completo AS trabalhador,
    p.cpf,
    p.cargo,
    aso.tipo_aso,
    aso.resultado
FROM aso
INNER JOIN atendimento at ON aso.id_atendimento = at.id_atendimento
INNER JOIN paciente p ON at.id_paciente = p.id_paciente;


SELECT 
    categoria_exame,
    COUNT(*) AS quantidade_exames,
    SUM(valor) AS valor_total_tabela
FROM tipo_exame
GROUP BY categoria_exame;

START TRANSACTION;

UPDATE agendamento 
SET status_agendamento = 'Realizado' 
WHERE id_agendamento = 1;


INSERT INTO atendimento (id_paciente, id_profissional, id_agendamento, data_atendimento, tipo_atendimento, queixa_principal, observacoes)
VALUES (1, 1, 1, '2026-12-01 08:35:00', 'Admissional', 'Sem queixas clínicas', 'Paciente em boas condições gerais.');


INSERT INTO exame_realizado (id_atendimento, id_tipo_exame, data_exame, resultado, status_exame)
VALUES (1, 1, '2026-12-01 08:50:00', 'Normal', 'Concluido');


INSERT INTO aso (id_atendimento, data_emissao, tipo_aso, resultado, observacoes)
VALUES (1, '2026-12-01', 'Admissional', 'Apto', 'Apto para exercer a função de Auxiliar Administrativo.');


COMMIT;


