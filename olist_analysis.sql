-- Conexação Sellers - Customers por estado

USE olist;

-- Criação da relação do numero de vendendores por estado
CREATE TEMPORARY TABLE vendendores_estado
SELECT seller_state,Count(seller_id) AS numero_vendedores FROM sellers
GROUP BY seller_state
ORDER BY count(seller_id) DESC;

-- Criação da relação de compradores por estado
CREATE TEMPORARY TABLE compradores_estado
SELECT customer_state,COUNT(customer_id) as numero_consumidores FROM customers
GROUP BY customer_state
ORDER BY numero_consumidores DESC;

-- Gasto total por estado 
CREATE TEMPORARY TABLE gasto_estado
SELECT customer_state,ROUND(SUM(payment_value),2) as total_gasto_estado FROM payment
JOIN orders on payment.order_id = orders.order_id
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customer_state
ORDER BY total_gasto_estado DESC;

-- Junção das tabelas para facilitar a analise
CREATE TEMPORARY TABLE analise_estado
SELECT seller_state,numero_vendedores,numero_consumidores,total_gasto_estado,ROUND((total_gasto_estado)/(numero_consumidores),2) as gasto_consumidor FROM vendendores_estado
JOIN compradores_estado on vendendores_estado.seller_state = compradores_estado.customer_state
JOIN gasto_estado on vendendores_estado.seller_state = gasto_estado.customer_state;

-- Analise do preço do frete
CREATE TEMPORARY TABLE analise_frete
SELECT customer_state,seller_state,price,freight_value FROM items
JOIN orders on items.order_id = orders.order_id
JOIN customers on orders.customer_id = customers.customer_id
JOIN sellers on sellers.seller_id = items.seller_id;

-- % media de frete para compras feitas em todo o país 16%
SELECT (sum(freight_value)/sum(price))*100 FROM analise_frete;

-- Analise sem dicriminalização por região de entregas acima da media de frete
SELECT COUNT(price) as numero_pedidos,ROUND(sum(price),2) as total_pedidos,ROUND(sum(freight_value),2) as total_frete, ROUND(((sum(freight_value)/sum(price))*100),0) as pct_of_price FROM analise_frete
HAVING pct_of_price > 16;

-- Discriminando por região do comprador
SELECT 
    customer_state,
    COUNT(price) AS numero_pedidos,
    ROUND(SUM(price), 2) AS total_pedidos,
    ROUND(SUM(freight_value), 2) AS total_frete,
    ROUND(SUM(price) * 0.16, 2) AS frete_esperado,
    ROUND((SUM(freight_value)-SUM(price) * 0.16),2) AS diferença_frete,
    ROUND(((SUM(freight_value) / SUM(price)) * 100),
            0) AS pct_of_price
FROM
    analise_frete
GROUP BY customer_state
HAVING pct_of_price > 16
ORDER BY diferença_frete DESC;

-- Discriminando por região do vendedor
SELECT 
    seller_state,
    COUNT(price) AS numero_pedidos,
    ROUND(SUM(price), 2) AS total_pedidos,
    ROUND(SUM(freight_value), 2) AS total_frete,
    ROUND(SUM(price) * 0.16, 2) AS frete_esperado,
    ROUND((SUM(freight_value)-SUM(price) * 0.16),2) AS diferença_frete,
    ROUND(((SUM(freight_value) / SUM(price)) * 100),
            0) AS pct_of_price
FROM
    analise_frete
GROUP BY seller_state
HAVING pct_of_price > 16
ORDER BY diferença_frete DESC;
