-- Active: 1788267993342@@127.0.0.1@3306@biblioteca_som2_nazareth

-- =======================================================
-- SOMATIVA 02 - BCD.
-- SISTREMA DE GERENCIAMENTO DE BIBLIOTECA.
-- =======================================================

-- FASE 1 — DDL: CRIAÇÃO E ESTRUTURA

-- 1. Criação do banco
CREATE DATABASE biblioteca_som2_NAZARETH;

use biblioteca_som2_NAZARETH;

-- 2. Tabela USUARIO
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);

-- 3. Tabela LIVRO
CREATE TABLE LIVRO (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0)
);

-- 4. Tabela EMPRESTIMO
CREATE TABLE EMPRESTIMO (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) 
        REFERENCES USUARIO(id_usuario) 
        ON DELETE RESTRICT,
    CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) 
        REFERENCES LIVRO(id_livro) 
        ON DELETE RESTRICT
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);




-- 5. ALTER TABLE
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100);

-- FASE 2: MANIPULAÇÃO DE DADOS

-- 6. INSERT de usuários
INSERT INTO USUARIO (nome, email, telefone) VALUES 
('Ana Silva', 'ana.silva@email.com', '19991112222'),
('Carlos Eduardo', 'carlos.eduardo@email.com', '19992223333'),
('Mariana Costa', 'mariana.costa@email.com', NULL),
('Roberto Alves', 'roberto.alves@email.com', '19994445555');

-- 7. INSERT de livros
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicacao, quantidade_disponivel, editora) VALUES 
('No Fundo e Amor', 'Ali Hazelwood', '978655565759', 2025, 6, 'Arqueiro'),
('Só mais uma comédia romântica', 'Katelyn Doyle', ' 978655565691', 2024, 4, 'Arqueiro'),
('verity', ' Colleen Hoover', '978850111784', 2020, 5, 'Galera Record'),
('Amor teoricamente', 'Ali Hazelwood', '978655565525', 2023, 3, 'Arqueiro'),
('Noiva', 'Ali Hazelwood', '978655565603', 2024, 3, 'Arqueiro'),
('Razão do Amor', 'Ali Hazelwood', '978655565399', 2022, 7,'Arqueiro');

-- 8. INSERT de empréstimos
INSERT INTO EMPRESTIMO (data_prevista, status_emprestimo, id_usuario, id_livro) VALUES 
('2026-11-10', 'ABERTO', 1, 25),
('2026-11-12', 'ABERTO', 2, 30),
('2026-11-15', 'ABERTO', 3, 28);

--9. UPDATE 
SELECT * from usuario;
UPDATE USUARIO 
SET telefone = '19988887777' 
WHERE id_usuario = 1;

-- 10. Atualização em lote
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_publicacao >= 2020;


-- 11. DELETE e teste de integridade
-- a) Criar e excluir um usuário sem empréstimos:
INSERT INTO USUARIO (nome, email, telefone) VALUES ('Usuário Teste', 'teste@email.com', '19900000000');
DELETE FROM USUARIO
WHERE email = 'teste@email.com';

-- b) Tentar excluir um usuário que possui empréstimo :
DELETE FROM USUARIO
WHERE id_usuario = 1;
/*
   EXPLICAÇÃO :
   O comando DELETE falhará com erro de restrição de chave estrangeira (Erro
   Isso ocorre porque definimos a constraint com ON DELETE RESTRICT 
   garantindo a regra RN16, que impede a remoção de usuários que contenham histórico na tabela EMPRESTIMO.
*/


-- FASE 3 — DQL: CONSULTAS E ANÁLISE

-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;

-- 13. WHERE + ORDER BY
SELECT * 
FROM LIVRO 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 14. LIKE
SELECT * 
FROM LIVRO 
WHERE titulo LIKE '%AMOR%';

-- 15. BETWEEN
SELECT * 
FROM LIVRO 
WHERE ano_publicacao BETWEEN 2015 AND 2025;

-- 16. Funções agregadas
SELECT 
    COUNT(*) AS total_titulos,
    SUM(quantidade_disponivel) AS total_exemplares,
    AVG(quantidade_disponivel) AS media_exemplares,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN
SELECT 
    E.id_emprestimo,
    U.nome AS nome_usuario,
    L.titulo AS titulo_livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro;

-- 18. JOIN + WHERE
SELECT 
    E.id_emprestimo,
    U.nome AS nome_usuario,
    L.titulo AS titulo_livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro
WHERE E.status_emprestimo = 'ABERTO';

-- 19. GROUP BY
SELECT 
    U.nome,
    COUNT(E.id_emprestimo) AS quantidade_emprestimos
FROM USUARIO U
INNER JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome
ORDER BY quantidade_emprestimos DESC;

-- 20. LEFT JOIN
SELECT 
    U.nome,
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome;

-- FASE 4 — TCL, TRANSAÇÕES E INTEGRIDADE

-- 21. Transação de empréstimo 
START TRANSACTION;
INSERT INTO EMPRESTIMO (data_prevista, status_emprestimo, id_usuario, id_livro) 
VALUES ('2026-11-20', 'ABERTO', 4, 27);

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel - 1 
WHERE id_livro = 27;

-- Conferência
SELECT * FROM EMPRESTIMO 
WHERE id_usuario = 4 
AND id_livro = 27;
SELECT id_livro, quantidade_disponivel
FROM LIVRO 
WHERE id_livro = 27;

COMMIT;


-- 22. ROLLBACK 
START TRANSACTION;

UPDATE LIVRO 
SET quantidade_disponivel = 99 
WHERE id_livro = 29;

-- Conferência dentro da transação
SELECT id_livro, quantidade_disponivel
FROM LIVRO
WHERE id_livro = 29;

ROLLBACK;

-- Conferência após o ROLLBACK
SELECT id_livro, quantidade_disponivel 
FROM LIVRO
WHERE id_livro = 1;


-- 23. SAVEPOINT
START TRANSACTION;
UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel + 1 
WHERE id_livro = 25;

SAVEPOINT ponto_primeira_alteracao;

UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel + 1
WHERE id_livro = 26;

ROLLBACK TO SAVEPOINT ponto_primeira_alteracao;

COMMIT;
SELECT id_livro, quantidade_disponivel 
FROM LIVRO
WHERE id_livro IN (25, 2);

-- 24. Transação de devolução
START TRANSACTION;
UPDATE EMPRESTIMO 
SET status_emprestimo = 'DEVOLVIDO', 
    data_devolucao = CURDATE() 
WHERE id_emprestimo = 1 AND status_emprestimo = 'ABERTO';

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 1 
WHERE id_livro = 1;

COMMIT;

-- ============================================================================
-- 8. DESAFIO FINAL DE INTEGRIDADE 
/*
25. Análise Técnica dos Mecanismos de Integridade:

1. Cadastrar dois usuários com o mesmo e-mail.
   - Mecanismo: CONSTRAINT 
   - Justificativa: Garante a nível de banco de dados que não existam registros duplicados no campo 'email' (RN02).

2. Cadastrar dois livros com o mesmo ISBN.
   - Mecanismo: CONSTRAINT 
   - Justificativa: O ISBN é um identificador único universal de publicações; a restrição UNIQUE impede duplicidades no cadastro de títulos (RN05).

3. Permitir quantidade disponível negativa.
   - Mecanismo: CONSTRAINT
   - Justificativa: A cláusula `CHECK (quantidade_disponivel >= 0)` valida o valor inserido ou atualizado diretamente na tabela (RN06).

4. Criar empréstimo para usuário inexistente.
   - Mecanismo: INTEGRIDADE REFERENCIAL 
   - Justificativa: Impede que o campo `id_usuario` na tabela `EMPRESTIMO` receba um valor que não existe na chave primária da tabela `USUARIO` (RN08).

5. Excluir livro com histórico de empréstimos.
   - Mecanismo: INTEGRIDADE REFERENCIAL 
   - Justificativa: A cláusula `ON DELETE RESTRICT` bloqueia a remoção de registros na tabela `LIVRO` caso existam registros vinculados na tabela `EMPRESTIMO` (RN17).

6. Gravar empréstimo e falhar na redução do estoque.
   - Mecanismo: TRANSAÇÃO 
   - Justificativa: As operações de inserção em `EMPRESTIMO` e atualização em `LIVRO` devem possuir a propriedade de ACID (Atomicidade), garantindo que ou ambas acontecem com sucesso, ou nenhuma é efetivada.

7. Emprestar livro cuja quantidade disponível seja zero.
   - Mecanismo: REGRA DA APLICAÇÃO 
   - Justificativa: mesmio que possa ser verificad no banco, a validação de disponibilidade de estoque antes de iniciar a transação de empréstimo deve ser tratada prioritariamente na lógica do sistema/aplicação (RN14) antes da tentativa de persistência.
*/

-- ===========================================================
