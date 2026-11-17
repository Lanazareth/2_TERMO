-- Active: 1794917650770@@127.0.0.1@3306@recuperativa_retrogame_nazareth
DROP DATABASE IF recuperativa_retrogame_nazareth;

CREATE DATABASE IF NOT EXISTS recuperativa_retrogame_nazareth;

USE recuperativa_retrogame_nazareth;

CREATE Table plataforma (
    id_plataforma INT AUTO_INCREMENT PRIMARY KEY,
    nome_plataforma VARCHAR(80) NOT NULL UNIQUE

);

CREATE Table categoria(
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    decricao VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT true
);

CREATE TABLE jogo(
    id_jogo INT AUTO_INCREMENT ,
    titulo VARCHAR(150) NOT NULL,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    ano_lancamento INT NOT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0),
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT pk_jogo PRIMARY KEY (id_jogo),
    CONSTRAINT fk_plataforma FOREIGN KEY (id_plataforma) REFERENCES PLATAFORMA(id_plataforma),
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE Table locacao(
    id_locacao INT AUTO_INCREMENT,
    data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_locacao VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_locacao IN('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_cliente INT NOT NULL,
    id_jogo INT NOT NULL,

    CONSTRAINT pk_locacao PRIMARY KEY (id_locacao),
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    CONSTRAINT fk_jogo FOREIGN KEY (id_jogo) REFERENCES JOGO(id_jogo)
);

ALTER TABLE jogo ADD desenvolvedora VARCHAR(100);
--------------------------------------------------------------------------------------

INSERT INTO cliente (nome_cliente, email, telefone, ativo) VALUES
('laura', 'laurinhadocamarao@gmail.com', '19981215360', TRUE),
('livia', 'liviadabocado09@gmai.com', '12986105680', TRUE),
('lidia', 'lidiaodocomando@gmai.com', 'null', FALSE),
('unique', 'uniquebcd@gmai.com', '12987655680', TRUE),
('bruno', 'brunindags@gmail.com', '12098745678',FALSE);

INSERT INTO plataforma ( nome_plataforma) VALUES
('Playstation'),
('X-box'),
('nintendo');

INSERT INTO categoria(decricao) VALUES
('terro'),
('luta'),
('suspense'),
('aventura');

SELECT * FROM plataforma;
SELECT * FROM categoria;
SELECT * FROM locacao;

INSERT INTO jogo(titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria)VALUES
('mortal kombat','ABACjABB', 1992, 5,2,2),
('The King of Fighters 96', 'KOFbbb96', 1996,8,1,2),
('Resident Evil', 'Kjkbbdhv', 1996,110,1,1),
('roblox', '7710bb12', 2006,15,2,4),
('mario bros', '19bb77ln', 1983,9,3,4),
('Resident Evil Requiem', '21bb1077', 2026,18,1,1);

INSERT INTO locacao (data_retirada,data_prevista, data_devolucao, status_locacao, id_cliente,id_jogo)VALUES
(NOW(), '2026-12-10',NULL,'ABERTO',2,4),
(NOW(), '2026-11-27',NULL,'ABERTO',5,2),
(NOW(), '2026-12-31',NULL,'ABERTO',3,6);

SELECT * FROM cliente;

UPDATE cliente
set telefone = '098765432110'
where id_cliente = 5;

UPDATE jogo
set quantidade_disponivel = quantidade_disponivel + 2
WHERE ano_lancamento >= 2000;

SELECT * FROM jogo;

INSERT INTO cliente (nome_cliente, email, telefone, ativo) VALUES
('sebastiao', 'velhodalancha@gmail.com', null, true);

SELECT * FROM cliente;

DELETE FROM cliente
WHERE id_cliente = 2;
-- a chave estrangeira esta restringindo a exclusao do usuario

-------------------------------------------------------------------------------------

SELECT titulo, ano_lancamento, quantidade_disponivel FROM jogo;

SELECT titulo, ano_lancamento ,quantidade_disponivel FROM jogo
WHERE quantidade_disponivel > 2
ORDER BY quantidade_disponivel DESC;


SELECT titulo FROM jogo
WHERE titulo LIKE '%kombat%';

SELECT titulo, ano_lancamento from jogo
WHERE ano_lancamento BETWEEN 1990 AND 2005;


SELECT COUNT(*) AS quantidade, SUM(quantidade_disponivel) AS SOMA,
AVG(quantidade_disponivel) AS MEDIA, MAX(quantidade_disponivel) AS
MAXIMO, MIN(quantidade_disponivel) AS MINIMO FROM jogo;

SELECT 
    E.id_locacao,
    U.nome_cliente AS nome_cliente,
    L.titulo AS titulo,
    E.data_devolucao,
    E.status_locacao
FROM locacao E
INNER JOIN cliente U ON E.id_cliente = U.id_cliente
INNER JOIN jogo L ON E.id_jogo = L.id_jogo;

SELECT 
    E.id_locacao,
    U.nome_cliente AS nome_cliente,
    L.titulo AS titulo,
    E.data_devolucao,
    E.status_locacao
FROM locacao E
INNER JOIN cliente U ON E.id_cliente = U.id_cliente
INNER JOIN jogo L ON E.id_jogo = L.id_jogo
WHERE E.status_locacao = 'ABERTO';

SELECT 
    U.nome_cliente,
    COUNT(E.id_locacao) AS quantidade_emprestimos
FROM cliente U
INNER JOIN locacao E ON U.id_cliente = E.id_cliente
GROUP BY U.id_cliente, U.nome_cliente
ORDER BY quantidade_emprestimos DESC;

-- 20. LEFT JOIN
SELECT 
    U.nome_cliente,
    COUNT(E.id_locacao) AS total_emprestimos
FROM cliente U
LEFT JOIN locacao E ON U.id_cliente = E.id_cliente
GROUP BY U.id_cliente, U.nome_cliente;
------------------------------------------------------------------------------

