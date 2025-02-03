# ecommecer

Projeto Conceitual de Banco de Dados - E-COMMERCE
Descrição do Projeto
Este projeto consiste em um banco de dados para um sistema de e-commerce, onde são gerenciados clientes (Pessoa Física e Pessoa Jurídica), produtos, pedidos, pagamentos e entregas. O esquema foi refinado para atender às seguintes especificações:

Clientes: Uma conta pode ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), mas não pode ter as duas informações simultaneamente.

Pagamentos: Um cliente pode cadastrar mais de uma forma de pagamento.

-- Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('PF', 'PJ') NOT NULL, -- Define se o cliente é PF ou PJ
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL
);

-- Tabela de Cliente Pessoa Física (PF)
CREATE TABLE Cliente_PF (
    id_cliente INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Cliente Pessoa Jurídica (PJ)
CREATE TABLE Cliente_PJ (
    id_cliente INT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Produtos
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

-- Tabela de Pedidos
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('Pendente', 'Processando', 'Enviado', 'Entregue') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Itens do Pedido
CREATE TABLE Item_Pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela de Pagamentos
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    tipo ENUM('Cartão', 'Boleto', 'PIX') NOT NULL,
    detalhes VARCHAR(255) NOT NULL, -- Ex: número do cartão, chave PIX, código do boleto
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Entregas
CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    status ENUM('Pendente', 'Em Trânsito', 'Entregue') NOT NULL,
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);
# Projeto Conceitual de Banco de Dados - E-COMMERCE

Este repositório contém o esquema de banco de dados para um sistema de e-commerce, desenvolvido em SQL. O projeto foi refinado para atender às seguintes especificações:

1. **Clientes**: Uma conta pode ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), mas não pode ter as duas informações simultaneamente.
2. **Pagamentos**: Um cliente pode cadastrar mais de uma forma de pagamento.

## Esquema do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

- `Cliente`: Armazena informações comuns a todos os clientes.
- `Cliente_PF`: Armazena informações específicas de clientes Pessoa Física.
- `Cliente_PJ`: Armazena informações específicas de clientes Pessoa Jurídica.
- `Produto`: Armazena informações sobre os produtos.
- `Pedido`: Registra os pedidos feitos pelos clientes.
- `Item_Pedido`: Relaciona os produtos aos pedidos.
- `Pagamento`: Permite o cadastro de múltiplas formas de pagamento.
- `Entrega`: Registra as informações de entrega dos pedidos.

## Como Utilizar

1. Clone este repositório.
2. Execute o script SQL em um sistema de gerenciamento de banco de dados (ex: MySQL, PostgreSQL).
3. Adapte o esquema conforme necessário para o seu projeto.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.
