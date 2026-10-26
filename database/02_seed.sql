-- =========================================================================
-- SCRIPT DML: Povoamento Inicial de Dados (Inputs)
-- =========================================================================

USE prato_na_hora_db;

-- Inputs na tabela Funcionarios (5 registros)
INSERT INTO funcionarios (nome, cargo, email) VALUES
('Carlos Atendente', 'Atendente', 'carlos@pratonahora.com'),
('Mariana Caixa', 'Caixa', 'mariana@pratonahora.com'),
('Joao Entregador', 'Entregador', 'joao@pratonahora.com'),
('Ana Gerente', 'Gerente', 'ana@pratonahora.com'),
('Lucas Cozinheiro', 'Cozinha', 'lucas@pratonahora.com');

-- Inputs na tabela Clientes (5 registros)
INSERT INTO clientes (nome, endereco, cidade, estado) VALUES
('Bruno Lima', 'Rua das Flores, 123', 'Sao Paulo', 'SP'),
('Camila Rocha', 'Av. Paulista, 1000', 'Sao Paulo', 'SP'),
('Diego Souza', 'Rua Augusta, 500', 'Sao Paulo', 'SP'),
('Fernanda Dias', 'Rua da Consolacao, 200', 'Sao Paulo', 'SP'),
('Gabriel Martins', 'Praca da Se, 50', 'Sao Paulo', 'SP');

-- Inputs na tabela Cliente Telefones (5 registros)
INSERT INTO cliente_telefones (cliente_id, numero) VALUES
(1, '11988881111'),
(2, '11977772222'),
(3, '11966663333'),
(4, '11955554444'),
(5, '11944445555');

-- Inputs na tabela Produtos / Marmitas (5 registros)
INSERT INTO produtos (nome_marmita, preco, quantidade_disponivel) VALUES
('Marmita Frango Grelhado', 22.00, 45),
('Marmita Carne Moida', 24.00, 30),
('Marmita Strogonoff de Frango', 26.00, 20),
('Marmita Feijoada Executiva', 28.00, 15),
('Marmita Vegetariana (Grao-de-bico)', 20.00, 25);

-- Inputs na tabela Pedidos (5 registros)
INSERT INTO pedidos (cliente_id, funcionario_id, data_pedido, status_pedido) VALUES
(1, 1, '2026-10-26 11:30:00', 'Entregue'),
(2, 1, '2026-10-26 12:00:00', 'Em Rota'),
(3, 2, '2026-10-26 12:15:00', 'Preparando'),
(4, 1, '2026-10-26 12:30:00', 'Confirmado'),
(5, 2, '2026-10-26 13:00:00', 'Cancelado');

-- Inputs na tabela Itens do Pedido (5 registros)
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 2, 22.00),
(2, 3, 1, 26.00),
(3, 2, 2, 24.00),
(4, 4, 1, 28.00),
(5, 5, 1, 20.00);

-- Inputs na tabela Pagamentos (5 registros)
INSERT INTO pagamentos (pedido_id, valor, situacao_pagamento, data_pagamento) VALUES
(1, 44.00, 'Pago', '2026-10-26 11:35:00'),
(2, 26.00, 'Pago', '2026-10-26 12:05:00'),
(3, 48.00, 'Pendente', NULL),
(4, 28.00, 'Pago', '2026-10-26 12:32:00'),
(5, 20.00, 'Cancelado', NULL);
