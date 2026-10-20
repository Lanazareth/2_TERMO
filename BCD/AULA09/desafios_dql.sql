-- Active: 1788267993342@@127.0.0.1@3306@smartcoffee_dml_nazareth

-- ============================================================
-- PARTE A - AQUECIMENTO
-- ============================================================

-- 1. Liste todos os clientes cadastrados.
SELECT * FROM cliente;

-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
SELECT nome, cidade, email FROM cliente;

-- 3. Liste os nomes das cidades sem repetir valores.
SELECT DISTINCT cidade FROM cliente;

-- 4. Liste todos os produtos em ordem crescente de preço.
SELECT * FROM produto ORDER BY preco ASC;

-- 5. Mostre apenas os 5 produtos mais caros.
SELECT * FROM produto ORDER BY preco DESC LIMIT 5;


-- ============================================================
-- PARTE B - FILTROS
-- ============================================================

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
SELECT * FROM produto WHERE preco BETWEEN 8 AND 15;

-- 7. Liste os clientes das cidades Limeira ou Americana.
SELECT * FROM cliente WHERE cidade IN ('LIMEIRA', 'AMERICANA');

-- 8. Localize os produtos cujo nome contém a palavra “Café”.
-- (Ajustado: corrigido de '%chocolate%' para '%Café%')
SELECT * FROM produto WHERE nome_produto LIKE '%Café%';

-- 9. Liste os clientes que não informaram telefone.
SELECT * FROM cliente WHERE telefone IS NULL;

-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00, do maior para o menor valor.
-- (Ajustado: corrigido de 'PENDENTE' para 'FINALIZADO')
SELECT * FROM pedido 
WHERE status_pedido = 'FINALIZADO' AND valor_total > 20 
ORDER BY valor_total DESC;


-- ============================================================
-- PARTE C - CÁLCULOS E AGRUPAMENTOS
-- ============================================================

-- 11. Informe quantos produtos estão cadastrados.
SELECT COUNT(*) AS total_produtos FROM produto;

-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT 
    MIN(preco) AS menor_preco, 
    MAX(preco) AS maior_preco, 
    AVG(preco) AS preco_medio
FROM produto;

-- 13. Informe quantos clientes existem em cada cidade.
SELECT cidade, COUNT(*) AS total_clientes 
FROM cliente 
GROUP BY cidade;

-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
SELECT cidade, COUNT(*) AS total_clientes
FROM cliente
GROUP BY cidade 
HAVING COUNT(*) >= 2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
SELECT SUM(valor_total) AS faturamento_total 
FROM pedido 
WHERE status_pedido = 'FINALIZADO';


-- ============================================================
-- PARTE D - RELACIONAMENTOS (INNER JOIN & LEFT JOIN)
-- ============================================================

-- 16. Liste cada pedido exibindo id, data, nome do cliente, status e valor total.
SELECT 
    p.id_pedido, 
    p.data_pedido, 
    c.nome AS nome_cliente, 
    p.status_pedido, 
    p.valor_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;

-- 17. Liste cada produto acompanhado do nome de sua categoria.
SELECT 
    p.nome_produto, 
    cat.nome_categoria
FROM produto p
JOIN categoria cat ON p.id_categoria = cat.id_categoria;

-- 18. Gere um relatório dos itens vendidos: pedido, produto, quantidade, preço unitário e subtotal.
SELECT 
    i.id_pedido, 
    pr.nome_produto, 
    i.quantidade, 
    i.preco_unitario, 
    (i.quantidade * i.preco_unitario) AS subtotal
FROM item_pedido i
JOIN produto pr ON i.id_produto = pr.id_produto;

-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.
SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    p.id_pedido, 
    p.status_pedido
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente;

-- 20. Liste apenas os clientes que nunca fizeram pedidos.
SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    c.email
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;


-- ============================================================
-- PARTE E - DESAFIO GERENCIAL
-- ============================================================

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto cada cliente gastou. 
-- Ordene do maior gasto para o menor.
SELECT 
    c.nome AS nome_cliente,
    COUNT(p.id_pedido) AS total_pedidos_finalizados,
    SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;

-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.
SELECT 
    cat.nome_categoria,
    COUNT(p.id_produto) AS quantidade_produtos,
    ROUND(AVG(p.preco), 2) AS preco_medio
FROM categoria cat
LEFT JOIN produto p ON cat.id_categoria = p.id_categoria
GROUP BY cat.id_categoria, cat.nome_categoria;

-- 23. Descubra quais produtos possuem preço superior ao preço médio geral.
SELECT 
    nome_produto, 
    preco
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto)
ORDER BY preco DESC;

-- 24. Classifique os produtos como Econômico, Intermediário ou Premium. 
-- Faixas definidas: Até R$ 10,00 (Econômico) | R$ 10,01 a R$ 20,00 (Intermediário) | Acima de R$ 20,00 (Premium)
SELECT 
    nome_produto,
    preco,
    CASE 
        WHEN preco <= 10.00 THEN 'Econômico'
        WHEN preco <= 20.00 THEN 'Intermediário'
        ELSE 'Premium'
    END AS classificacao_preco
FROM produto
ORDER BY preco ASC;

-- 25. CONSULTA AUTORAL
-- Pergunta de negócio:
-- Quais são os 3 produtos mais vendidos (em quantidade total de itens) e o faturamento gerado por cada um nos pedidos finalizados?
--
-- Por que essa informação é útil?
-- Identifica os produtos "carro-chefe" da cafeteria para otimizar a compra de insumos, evitar desabastecimento de estoque, criar combos promocionais e avaliar quais itens trazem mais receita real.

SELECT 
    pr.nome_produto,
    SUM(i.quantidade) AS total_unidades_vendidas,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS faturamento_gerado
FROM item_pedido i
JOIN produto pr ON i.id_produto = pr.id_produto
JOIN pedido p ON i.id_pedido = p.id_pedido
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY pr.id_produto, pr.nome_produto
ORDER BY total_unidades_vendidas DESC
LIMIT 3;