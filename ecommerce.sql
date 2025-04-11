
# Projeto Conceitual de Banco de Dados - Oficina Mecânica

Este repositório contém o esquema conceitual de banco de dados para um sistema de gerenciamento de ordens de serviço (OS) em uma oficina mecânica. O projeto foi desenvolvido com base na seguinte narrativa:

## Narrativa
- Clientes levam veículos à oficina para consertos ou revisões periódicas.
- Cada veículo é designado a uma equipe de mecânicos, que identifica os serviços a serem executados e preenche uma OS com data de entrega.
- O valor de cada serviço é calculado com base em uma tabela de referência de mão-de-obra.
- O valor das peças também compõe o valor total da OS.
- A mesma equipe avalia e executa os serviços.
- Mecânicos possuem código, nome, endereço e especialidade.
- Cada OS possui número, data de emissão, valor, status e data para conclusão.

## Esquema do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

- **Cliente**: Armazena informações dos clientes.
- **Veículo**: Armazena informações dos veículos dos clientes.
- **Mecânico**: Armazena informações dos mecânicos.
- **Equipe**: Armazena informações das equipes de mecânicos.
- **Equipe_Mecanico**: Relaciona mecânicos às equipes.
- **Ordem_Servico**: Registra as ordens de serviço.
- **Servico**: Armazena os serviços disponíveis.
- **Peca**: Armazena as peças disponíveis.
- **OS_Servico**: Relaciona serviços às ordens de serviço.
- **OS_Peca**: Relaciona peças às ordens de serviço.

## Como Utilizar

1. Clone este repositório.
2. Execute o script SQL em um sistema de gerenciamento de banco de dados (ex: MySQL, PostgreSQL).

## Observações
- Decisões não especificadas na narrativa, como a quantidade de mecânicos por equipe e a forma de cálculo do valor total da OS, foram definidas com base no contexto de uma oficina mecânica.


-- Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    email VARCHAR(100)
);

-- Tabela de Veículos
CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Mecânicos
CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    especialidade VARCHAR(100) NOT NULL
);

-- Tabela de Equipes
CREATE TABLE Equipe (
    id_equipe INT PRIMARY KEY AUTO_INCREMENT,
    nome_equipe VARCHAR(100) NOT NULL
);

-- Tabela de Relacionamento Equipe-Mecânico
CREATE TABLE Equipe_Mecanico (
    id_equipe INT NOT NULL,
    id_mecanico INT NOT NULL,
    PRIMARY KEY (id_equipe, id_mecanico),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);

-- Tabela de Ordens de Serviço (OS)
CREATE TABLE Ordem_Servico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT NOT NULL,
    id_equipe INT NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    status ENUM('Pendente', 'Em Andamento', 'Concluída') NOT NULL,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

-- Tabela de Serviços
CREATE TABLE Servico (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    valor_mao_de_obra DECIMAL(10, 2) NOT NULL
);

-- Tabela de Peças
CREATE TABLE Peca (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

-- Tabela de Relacionamento OS-Serviço
CREATE TABLE OS_Servico (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Tabela de Relacionamento OS-Peça
CREATE TABLE OS_Peca (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);
