-- =========================================================================
-- PROJETO: Prato na Hora (Delivery de Marmitas)
-- SCRIPT DDL: Criacao do Banco de Dados e Tabelas
-- =========================================================================

CREATE DATABASE IF NOT EXISTS prato_na_hora_db;
USE prato_na_hora_db;

-- 1FN / 4FN: Tabela Clientes e tabela filha de telefones para atomicidade
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

CREATE TABLE cliente_telefones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- Tabela Funcionarios
CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 3FN: Tabela Produtos com dados atomicos e independentes
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_marmita VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade_disponivel INT NOT NULL
);

-- Tabela Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    funcionario_id INT,
    data_pedido DATETIME NOT NULL,
    status_pedido VARCHAR(30) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

-- 2FN: Tabela associativa N:M contendo apenas dados referentes a transacao do item
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela Pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    valor DECIMAL(10,2) NOT NULL,
    situacao_pagamento VARCHAR(30) NOT NULL,
    data_pagamento DATETIME,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE
);
