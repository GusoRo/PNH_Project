-- =========================================================================
-- SCRIPT: 15 Consultas SQL Contextualizadas
-- =========================================================================

USE prato_na_hora_db;

-- 1. Listar pedidos com dados do cliente e funcionario (INNER JOIN)
SELECT p.id AS pedido_id, c.nome AS cliente, f.nome AS funcionario, p.status_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
INNER JOIN funcionarios f ON p.funcionario_id = f.id;

-- 2. Buscar clientes cujo nome comece com 'B' (LIKE)
SELECT * FROM clientes WHERE nome LIKE 'B%';

-- 3. Calcular o valor total de cada pedido (SUM, GROUP BY, INNER JOIN)
SELECT p.id AS pedido_id, SUM(ip.quantidade * ip.preco_unitario) AS valor_total
FROM pedidos p
INNER JOIN itens_pedido ip ON p.id = ip.pedido_id
GROUP BY p.id;

-- 4. Listar marmitas com preco entre R$ 20,00 e R$ 25,00 (BETWEEN)
SELECT nome_marmita, preco FROM produtos WHERE preco BETWEEN 20.00 AND 25.00;

-- 5. Listar pedidos mais recentes primeiro (ORDER BY DESC)
SELECT * FROM pedidos ORDER BY data_pedido DESC;

-- 6. Contar quantos pedidos cada funcionario registrou (GROUP BY, COUNT)
SELECT f.nome AS funcionario, COUNT(p.id) AS total_pedidos
FROM funcionarios f
LEFT JOIN pedidos p ON f.id = p.funcionario_id
GROUP BY f.nome;

-- 7. Exibir clientes e seus telefones (INNER JOIN)
SELECT c.nome, ct.numero AS telefone 
FROM clientes c
INNER JOIN cliente_telefones ct ON c.id = ct.cliente_id;

-- 8. Consultar marmitas com estoque menor que 30 unidades (WHERE)
SELECT nome_marmita, quantidade_disponivel FROM produtos WHERE quantidade_disponivel < 30;

-- 9. Consultar pagamentos pendentes (WHERE)
SELECT * FROM pagamentos WHERE situacao_pagamento = 'Pendente';

-- 10. Faturamento total agrupado pela situacao do pagamento (SUM, GROUP BY)
SELECT situacao_pagamento, SUM(valor) AS total_arrecadado
FROM pagamentos
GROUP BY situacao_pagamento;

-- 11. Encontrar a marmita mais cara do cardapio (ORDER BY, LIMIT)
SELECT nome_marmita, preco FROM produtos ORDER BY preco DESC LIMIT 1;

-- 12. Listar pagamentos dentro de um intervalo de horarios (BETWEEN)
SELECT * FROM pagamentos WHERE data_pagamento BETWEEN '2026-10-26 11:00:00' AND '2026-10-26 12:30:00';

-- 13. Exibir detalhes dos itens vendidos com subtotal (INNER JOIN, Calculo)
SELECT ip.id, pr.nome_marmita, ip.quantidade, ip.preco_unitario, (ip.quantidade * ip.preco_unitario) AS subtotal
FROM itens_pedido ip
INNER JOIN produtos pr ON ip.produto_id = pr.id;

-- 14. Listar pedidos que nao foram cancelados (!=)
SELECT * FROM pedidos WHERE status_pedido <> 'Cancelado';

-- 15. Contar marmitas por faixa de preco (GROUP BY com CASE)
SELECT 
    CASE WHEN preco <= 23.00 THEN 'Ate R$ 23.00' ELSE 'Acima de R$ 23.00' END AS faixa_preco,
    COUNT(*) AS qtd_marmitas
FROM produtos
GROUP BY faixa_preco;
