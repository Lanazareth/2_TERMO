-- PARTE A 
--  Cadastre dois novos clientes. 
-- 2. Cadastre uma nova categoria chamada Especiais da Casa. 
-- 3. Cadastre três produtos na nova categoria. 
-- 4. Insira um cliente sem telefone e observe o uso de NULL. 
-- 5. Crie um novo pedido para um dos clientes cadastrados. 
-- 6. Use LAST_INSERT_ID() para inserir pelo menos dois itens no pedido. 

INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, CIDADE, ATIVO) VALUES
('MARIA FERNANDA', 'MARIA@EMAIL','19999999999', 'PIRACICABA', TRUE),
('JOAO PEDRO ', 'JOAO@EMAIL','19988888888', 'RIO CLARO', TRUE);
SET @CLIENTE = LAST_INSERT_ID();
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES
('ESPECIAIS DA CASA', );
SET @CATEGORIA = LAST_INSERT_ID();
INSERT INTO PRODUTO (NOME_PRODUTO, PRECO, ATIVO, ID_CATEGORIA) VALUES
('PIZZA',  20.00, @CATEGORIA, TRUE),
('FETUCCINI', 25.00, @CATEGORIA, TRUE),
('LASANAHA', 30.00, @CATEGORIA, TRUE);

INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, CIDADE, ATIVO) VALUES
('LUCAS SILVA', 'LUCAS@EMAIL', NULL, 'PIRACICABA', TRUE);
SET @CLIENTE = LAST_INSERT_ID();

INSERT INTO PEDIDO (DATA_PEDIDO, STATUS_PEDIDO, VALOR_TOTAL, ID_CLIENTE) VALUES
(NOW(),'PENDENTE', 0.00,@CLIENTE);
SET @PEDIDO = LAST_INSERT_ID();

-- Parte B-UPDATE 
-- 7. Corrija o telefone de um dos clientes criados. 
-- 8. Altere cidade e telefone de outro cliente em um único comando. 
-- 9. Aumente em 8% os preços dos produtos da categoria criada. 
-- 10. Altere o status do novo pedido para PREPARANDO. 
-- 11. Atualize o valor_total do pedido para refletir os itens adicionados. 12. Desative um produto utilizando exclusão lógica. 

UPDATE CLIENTE
SET TELEFONE = '19999945999'
WHERE ID_CLIENTE = 15;


UPDATE CLIENTE
SET TELEFONE = '19999945989',
    CIDADE = 'RIO CLARO'
WHERE ID_CLIENTE = 16;

UPDATE PRODUTO
SET PRECO = PRECO * 1.08
WHERE ID_CATEGORIA = @CATEGORIA;

UPDATE PEDIDO
SET STATUS_PEDIDO = 'PREPARANDO'
WHERE ID_PEDIDO = @PEDIDO;


UPDATE PEDIDO
SET VALOR_TOTAL = (
    SELECT SUM(QUANTIDADE * PRECO_UNITARIO)
    FROM ITEM_PEDIDO
    WHERE ID_PEDIDO = @PEDIDO
)
WHERE ID_PEDIDO = @PEDIDO;

UPDATE NOME_PRODUTO
SET ATIVO = FALSE
WHERE NOME = 'PIZZA' AND ID_CATEGORIA = @CATEGORIA;


-- Parte C-DELETE 
-- 13. Crie um cliente de teste que não possua pedidos e depois exclua-o.
-- 14. Tente excluir um cliente que possui pedidos e registre o que aconteceu.
-- 15. Explique por que a FK protegeu o banco. 
-- 16. Crie uma categoria de teste sem produtos e depois remova-a. 


INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, CIDADE, ATIVO) VALUES
('CLIENTE TESTE', 'TESTE@EMAIL.COM', '19900000000', 'LIMEIRA', TRUE);
SET @CLIENTE_TESTE = LAST_INSERT_ID();

DELETE FROM CLIENTE 
WHERE ID_CLIENTE = @CLIENTE_TESTE;


DELETE FROM CLIENTE 
WHERE ID_CLIENTE = @CLIENTE;

-- 15) Foreign Key  garante a Integridade Referencial do banco de dados. Ela impede a formação de dados "órfãos" — 
-- neste caso, um registro na tabela PEDIDO que apontaria para um ID_CLIENTE inexistente. Para deletar o cliente, 
-- seria necessário antes tratar os registros filhos (excluindo os pedidos associados ou alterando a regra da constraint para ON DELETE CASCADE / ON DELETE SET NULL).

INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES
('CATEGORIA TESTE', 'CATEGORIA TEMPORARIA SEM PRODUTOS');
SET @CATEGORIA_TESTE = LAST_INSERT_ID();

DELETE FROM CATEGORIA 
WHERE ID_CATEGORIA = @CATEGORIA_TESTE;