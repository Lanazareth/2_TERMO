-- Active: 1794917650770@@127.0.0.1@3306@biblioteca_senai_nazareth
drop DATABASE IF EXISTS biblioteca_senai_nazareth;

create DATABASE if not EXISTS biblioteca_senai_nazareth;

use biblioteca_senai_nazareth;
----------------------------------------------------------

-- fase 1 - DDl


create table usuario(
    id_usuario int auto_increment,
    nome varchar(100) not null,
    email VARCHAR(120) not null UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN DEFAULT true,

    constraint pk_id_usuario primary key (id_usuario),
    constraint uq__email UNIQUE (email)
);

create table if not exists livro (
    id_livro INT AUTO_INCREMENT ,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT ,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0),

    constraint pk_livro primary key (id_livro),
    constraint uq_isbn UNIQUE (isbn)
);

create table emprestimo (
    id_emprestimo INT AUTO_INCREMENT ,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,

    CONSTRAINT pk_emprestimo PRIMARY KEY (id_emprestimo),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro)
);

create table categoria (
    id_categoria INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    id_livro INT NOT NULL,

    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categoria_nome UNIQUE (NOME),
    CONSTRAINT FK_categoria_livro  FOREIGN KEY (id_livro) REFERENCES LIVRO (id_livro)
);

ALTER TABLE livro ADD editora VARCHAR(100);

-- fase 2 - dml

INSERT INTO usuario (nome , email, telefone, ativo) VALUES
('laura', 'laurinhadocamarao@gmail.com', '19981215360', TRUE),
('livia', 'liviadabocado09@gmai.com', '12986105680', TRUE),
('lidia', 'lidiaodocomando@gmai.com', '12987655680', FALSE);

INSERT INTO LIVRO (TITULO, AUTOR, ISBN, ANO_PUBLICACAO, QUANTIDADE_DISPONIVEL, EDITORA) VALUES
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', '97831484100', 1943, 5, 'Editora A'),
('Promessas crueis', 'rebecca ross', '978685348386', 2024, 3, 'Editora B'),
('Dom Casmurro', 'Machado de Assis', '978855902778', 1899, 2, 'Editora C');

INSERT INTO categoria (nome, ID_LIVRO) VALUES
('Infantil', 4),
('Romance', 5),
('Clássico', 6);

SELECT * FROM usuario;

UPDATE usuario
set telefone = '098765432110'
where id_usuario = 3;

UPDATE livro 
set quantidade_disponivel = quantidade_disponivel + 2
WHERE ano_publicacao >= 1990;

INSERT INTO usuario (nome, email, telefone, ativo) VALUES
('sebastiao', 'velhodalancha@gmail.com', null, true);

SELECT * FROM usuario;

DELETE FROM usuario
WHERE id_usuario = 1;
-- a chave estrangeira esta restringindo a exclusao do usuario

INSERT INTO emprestimo (data_emprestimo, data_prevista, data_devolucao, status_emprestimo, id_usuario, id_livro)VALUES
(NOW(), '2026-11-17',NULL,'ABERTO',1,5);

-- fase 3 - dql

SELECT titulo, autor, quantidade_disponivel FROM livro;


SELECT titulo, autor,quantidade_disponivel FROM livro
WHERE quantidade_disponivel > 2
ORDER BY quantidade_disponivel DESC;

SELECT titulo, autor FROM livro
WHERE titulo LIKE '%pequeno%';

SELECT titulo, autor, ano_publicacao from livro
WHERE ano_publicacao BETWEEN 1990 AND 2026;

SELECT COUNT(*) AS quantidade, SUM(quantidade_disponivel) AS SOMA,
AVG(quantidade_disponivel) AS MEDIA, MAX(quantidade_disponivel) AS
MAXIMO, MIM(quantidade_disponivel) AS MINIMO FROM livro;

SELECT 
    E.id_locacao,
    U.nome AS nome_usuario,
    L.titulo AS titulo_livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro;
