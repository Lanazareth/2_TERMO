-- ============================================================
-- AULA 08 - ATIVIDADE PRÁTICA DE DML
-- Base: smartcoffee_dml
-- ============================================================
USE smartcoffee_dml;

-- ============================================================
-- PARTE A - INSERT
-- ============================================================

-- 1. Cadastre dois novos clientes.
INSERT INTO clientes (nome, email, telefone, cidade, ativo) VALUES
('Maria Fernanda', 'maria@email.com', '19999999999', 'Piracicaba', TRUE),
('João Pedro', 'joao@email.com', '19988888888', 'Rio Claro', TRUE);

-- 2. Cadastre uma nova categoria chamada Especiais da Casa.
INSERT INTO categorias (nome, descricao) VALUES
('Especiais da Casa', 'Bebidas e pratos especiais do cardápio');
SET @categoria_especiais = LAST_INSERT_ID();

-- 3. Cadastre três produtos na nova categoria.
INSERT INTO produtos (nome, preco, ativo, id_categoria) VALUES
('Pizza Artesanal', 20.00, TRUE, @categoria_especiais),
('Fetuccini ao Molho', 25.00, TRUE, @categoria_especiais),
('Lasanha Especial', 30.00, TRUE, @categoria_especiais);

-- 4. Insira um cliente sem telefone e observe o uso de NULL.
INSERT INTO clientes (nome, email, telefone, cidade, ativo) VALUES
('Lucas Silva', 'lucas@email.com', NULL, 'Piracicaba', TRUE);
SET @id_cliente_novo = LAST_INSERT_ID();

-- 5. Crie um novo pedido para um dos clientes cadastrados.
INSERT INTO pedidos (data_pedido, status, valor_total, id_cliente) VALUES
(NOW(), 'PENDENTE', 0.00, @id_cliente_novo);

-- 6. Use LAST_INSERT_ID() para inserir pelo menos dois itens no pedido.
SET @id_pedido_novo = LAST_INSERT_ID();

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(@id_pedido_novo, (SELECT id_produto FROM produtos WHERE nome = 'Pizza Artesanal' LIMIT 1), 1, 20.00),
(@id_pedido_novo, (SELECT id_produto FROM produtos WHERE nome = 'Fetuccini ao Molho' LIMIT 1), 2, 25.00);


-- ============================================================
-- PARTE B - UPDATE
-- ============================================================

-- 7. Corrija o telefone de um dos clientes criados.
-- SELECT de validação:
SELECT id_cliente, nome, telefone FROM clientes WHERE email = 'maria@email.com';

UPDATE clientes
SET telefone = '19999945999'
WHERE email = 'maria@email.com';

-- SELECT final:
SELECT id_cliente, nome, telefone FROM clientes WHERE email = 'maria@email.com';


-- 8. Altere cidade e telefone de outro cliente em um único comando.
-- SELECT de validação:
SELECT id_cliente, nome, cidade, telefone FROM clientes WHERE email = 'joao@email.com';

UPDATE clientes
SET telefone = '19999945989',
    cidade = 'Rio Claro'
WHERE email = 'joao@email.com';

-- SELECT final:
SELECT id_cliente, nome, cidade, telefone FROM clientes WHERE email = 'joao@email.com';


-- 9. Aumente em 8% os preços dos produtos da categoria criada.
-- SELECT de validação:
SELECT id_produto, nome, preco FROM produtos WHERE id_categoria = @categoria_especiais;

UPDATE produtos
SET preco = ROUND(preco * 1.08, 2)
WHERE id_categoria = @categoria_especiais;

-- SELECT final:
SELECT id_produto, nome, preco FROM produtos WHERE id_categoria = @categoria_especiais;


-- 10. Altere o status do novo pedido para PREPARANDO.
-- SELECT de validação:
SELECT id_pedido, status FROM pedidos WHERE id_pedido = @id_pedido_novo;

UPDATE pedidos
SET status = 'PREPARANDO'
WHERE id_pedido = @id_pedido_novo;

-- SELECT final:
SELECT id_pedido, status FROM pedidos WHERE id_pedido = @id_pedido_novo;


-- 11. Atualize o valor_total do pedido para refletir os itens adicionados.
-- SELECT de validação (cálculo prévio):
SELECT id_pedido, SUM(quantidade * preco_unitario) AS total_calculado 
FROM itens_pedido 
WHERE id_pedido = @id_pedido_novo
GROUP BY id_pedido;

UPDATE pedidos p
SET valor_total = (
    SELECT SUM(quantidade * preco_unitario)
    FROM itens_pedido
    WHERE id_pedido = p.id_pedido
)
WHERE id_pedido = @id_pedido_novo;

-- SELECT final:
SELECT id_pedido, valor_total, status FROM pedidos WHERE id_pedido = @id_pedido_novo;


-- 12. Desative um produto utilizando exclusão lógica.
-- SELECT de validação:
SELECT id_produto, nome, ativo FROM produtos WHERE nome = 'Pizza Artesanal' AND id_categoria = @categoria_especiais;

UPDATE produtos
SET ativo = FALSE
WHERE nome = 'Pizza Artesanal' AND id_categoria = @categoria_especiais;

-- SELECT final:
SELECT id_produto, nome, ativo FROM produtos WHERE nome = 'Pizza Artesanal' AND id_categoria = @categoria_especiais;


-- ============================================================
-- PARTE C - DELETE
-- ============================================================

-- 13. Crie um cliente de teste que não possua pedidos e depois exclua-o.
INSERT INTO clientes (nome, email, telefone, cidade, ativo) VALUES
('Cliente Teste', 'teste@email.com', '19900000000', 'Limeira', TRUE);
SET @cliente_teste = LAST_INSERT_ID();

-- SELECT de validação:
SELECT id_cliente, nome FROM clientes WHERE id_cliente = @cliente_teste;

DELETE FROM clientes 
WHERE id_cliente = @cliente_teste;

-- SELECT final:
SELECT id_cliente, nome FROM clientes WHERE id_cliente = @cliente_teste;


-- 14. Tente excluir um cliente que possui pedidos e registre o que aconteceu.
-- SELECT de validação:
SELECT id_cliente, nome FROM clientes WHERE id_cliente = @id_cliente_novo;

-- Comando executado no teste (deve permanecer comentado):
-- DELETE FROM clientes WHERE id_cliente = @id_cliente_novo;

-- Resultado observado:
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 
-- (`smartcoffee_dml`.`pedidos`, CONSTRAINT `fk_pedidos_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`))


-- 15. Explique por que a FK protegeu o banco.
-- Resposta:
-- A Foreign Key (Chave Estrangeira) garante a Integridade Referencial do banco de dados.
-- Ela impede a formação de dados "órfãos" — neste caso, registros na tabela `pedidos` que apontariam 
-- para um `id_cliente` inexistente. Para deletar o cliente, seria necessário primeiro tratar os registros 
-- filhos em `pedidos` ou definir regras como ON DELETE CASCADE na FK.


-- 16. Crie uma categoria de teste sem produtos e depois remova-a.
INSERT INTO categorias (nome, descricao) VALUES
('Categoria Teste', 'Categoria temporária sem produtos');
SET @categoria_teste = LAST_INSERT_ID();

-- SELECT de validação:
SELECT id_categoria, nome FROM categorias WHERE id_categoria = @categoria_teste;

DELETE FROM categorias 
WHERE id_categoria = @categoria_teste;

-- SELECT final:
SELECT id_categoria, nome FROM categorias WHERE id_categoria = @categoria_teste;


-- ============================================================
-- PARTE D - INTEGRIDADE E ERROS CONTROLADOS
-- ============================================================

-- 17. Tente inserir um produto com id_categoria = 9999.
-- INSERT INTO produtos (nome, preco, id_categoria, ativo) VALUES ('Produto Teste FK', 15.00, 9999, TRUE);

-- Qual restrição impediu a operação?
-- Restrição: FOREIGN KEY (Chave Estrangeira - fk_produtos_categorias).
-- Explicação: O ID de categoria 9999 não existe na tabela pai (`categorias`).


-- 18. Tente cadastrar um cliente usando 'ana@email.com'.
-- INSERT INTO clientes (nome, email, telefone, cidade) VALUES ('Ana Dup', 'ana@email.com', '(19) 90000-0000', 'Limeira');

-- Qual restrição impediu a operação?
-- Restrição: UNIQUE CONSTRAINT (Chave Única na coluna `email`).
-- Explicação: O e-mail 'ana@email.com' já está cadastrado no banco de dados e não aceita duplicidade.


-- 19. Tente criar um pedido com id_cliente = 9999.
-- INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) VALUES (9999, NOW(), 'PENDENTE', 10.00);

-- Qual restrição impediu a operação?
-- Restrição: FOREIGN KEY (Chave Estrangeira - fk_pedidos_clientes).
-- Explicação: Não existe registro de cliente cadastrado com o id_cliente = 9999.


-- 20. Escreva em comentários a diferença entre os três erros anteriores.
-- Resposta:
-- As questões 17 e 19 geraram erros de CHAVE ESTRANGEIRA (FOREIGN KEY), pois tentaram vincular
-- um registro filho a um registro pai inexistente (violação da Integridade Referencial entre tabelas).
-- A questão 18 gerou um erro de CHAVE ÚNICA (UNIQUE CONSTRAINT), pois tentou inserir um valor duplicado
-- em uma coluna da própria tabela que exige valores estritamente exclusivos.


-- ============================================================
-- PARTE E - DESAFIO COMPLETO COM TRANSAÇÃO
-- ============================================================

-- 21. Inicie uma transação.
START TRANSACTION;


-- 22. Dentro dela, cadastre um cliente, um pedido e dois itens relacionados.
INSERT INTO clientes (nome, email, telefone, cidade, ativo) 
VALUES ('Fernanda Lima', 'fernanda.lima@email.com', '19955554444', 'Rio Claro', TRUE);

SET @id_cli_trans = LAST_INSERT_ID();

INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) 
VALUES (@id_cli_trans, NOW(), 'PENDENTE', 35.00);

SET @id_ped_trans = LAST_INSERT_ID();

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
    (@id_ped_trans, 1, 1, 15.00),
    (@id_ped_trans, 2, 1, 20.00);


-- 23. Faça uma consulta com JOIN comprovando que os registros existem enquanto a transação está aberta.
SELECT 
    c.nome AS cliente,
    p.id_pedido,
    p.status,
    i.id_produto,
    i.quantidade,
    i.preco_unitario
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE c.id_cliente = @id_cli_trans;


-- 24. Execute ROLLBACK e depois use SELECT para provar que o cadastro foi desfeito.
ROLLBACK;

SELECT * FROM clientes WHERE email = 'fernanda.lima@email.com';
SELECT * FROM pedidos WHERE id_cliente = @id_cli_trans;


-- 25. Repita o processo com novos dados e finalize usando COMMIT. Depois consulte os registros persistidos.
START TRANSACTION;

INSERT INTO clientes (nome, email, telefone, cidade, ativo) 
VALUES ('Carlos Eduardo', 'carlos.eduardo@email.com', '19933332222', 'Americana', TRUE);

SET @id_cli_commit = LAST_INSERT_ID();

INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) 
VALUES (@id_cli_commit, NOW(), 'FINALIZADO', 40.00);

SET @id_ped_commit = LAST_INSERT_ID();

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
    (@id_ped_commit, 1, 2, 20.00);

COMMIT;

SELECT 
    c.nome AS cliente,
    p.id_pedido,
    p.status,
    p.valor_total,
    i.id_produto,
    i.quantidade
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE c.id_cliente = @id_cli_commit;


-- ============================================================
-- DESAFIO EXTRA
-- ============================================================

-- 26. Escolha uma situação realista do SmartCoffee que exija INSERT + UPDATE
--     ou UPDATE + DELETE lógico. Descreva a regra de negócio e implemente.

-- Regra de Negócio:
-- Cenário: "Descontinuação de Categoria e Auditoria de Inativação em Lote"
-- Ao descontinuar uma linha de produtos (ex: 'Sazonais de Inverno'), o sistema deve:
-- 1. Registrar um histórico da ação no log de eventos do sistema (INSERT).
-- 2. Inativar logicamente todos os produtos associados a essa categoria setando `ativo = FALSE` (UPDATE).

INSERT INTO log_sistema (data_evento, usuario, descricao) 
VALUES (NOW(), 'admin_smartcoffee', 'Descontinuação da categoria Sazonais de Inverno e inativação em lote.');

UPDATE produtos p
JOIN categorias c ON p.id_categoria = c.id_categoria
SET p.ativo = FALSE
WHERE c.nome = 'Sazonais de Inverno';

SELECT p.id_produto, p.nome, p.ativo, c.nome AS categoria
FROM produtos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Sazonais de Inverno';