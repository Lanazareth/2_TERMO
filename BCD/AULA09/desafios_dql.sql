-- Active: 1788267993342@@127.0.0.1@3306@smartcoffee_dml_nazareth
-- PARTE A - AQUECIMENTO

-- 1. Liste todos os clientes cadastrados.
-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
-- 3. Liste os nomes das cidades sem repetir valores.
-- 4. Liste todos os produtos em ordem crescente de preço.
-- 5. Mostre apenas os 5 produtos mais caros.

select * from cliente;

select nome, cidade, email from cliente;

select distinct cidade from cliente;

select * from produto order by preco asc;

select * from produto order by preco desc limit 5;


-- PARTE B - FILTROS
-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
-- 7. Liste os clientes das cidades Limeira ou Americana.
-- 8. Localize os produtos cujo nome contém a palavra “Café”.
-- 9. Liste os clientes que não informaram telefone.
-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.

select * from produto where preco between 8 and 15;

select * from cliente where cidade in ('LIMEIRA', 'AMERICANA');

select * from produto where nome_produto like '%chocolate%';

select * from cliente where telefone is null;

select * from pedido where status_pedido = 'PENDENTE' and valor_total > 20 order by valor_total desc;

-- PARTE C - CÁLCULOS E AGRUPAMENTOS
-- 11. Informe quantos produtos estão cadastrados.
-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
-- 13. Informe quantos clientes existem em cada cidade.
-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.

select count(*) from produto;

select min(preco) as menor_preco, 
max(preco) as maior_preco, 
avg(preco) as preco_medio
 from produto;

select cidade, count(*) as total_clientes 
from cliente 
group by cidade;

select cidade, count(*) as total_clientes
 from cliente
  group by cidade having count(*) >= 2;

select sum(valor_total) as faturamento_total from pedido where status_pedido = 'FINALIZADO';
