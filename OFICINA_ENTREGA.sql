-- =====================================================
-- BANCO DE DADOS: OFICINA MECÂNICA
-- =====================================================
DROP DATABASE IF EXISTS OficinaDB;
CREATE DATABASE OficinaDB;
USE OficinaDB;


CREATE DATABASE IF NOT EXISTS OficinaDB;
USE OficinaDB;

-- =====================================================
-- 1. TABELA: CLIENTE
-- =====================================================
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    telefone VARCHAR(45),
    email VARCHAR(45),
    endereco VARCHAR(100)
);

-- =====================================================
-- 2. TABELA: VEÍCULO
-- =====================================================
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10),
    modelo VARCHAR(45),
    ano VARCHAR(10),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE
);

-- =====================================================
-- 3. TABELA: EQUIPE
-- =====================================================
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(45),
    responsavel VARCHAR(45)
);

-- =====================================================
-- 4. TABELA: MECÂNICO
-- =====================================================
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    especialidade VARCHAR(45),
    endereco VARCHAR(100),
    Equipe_idEquipe INT,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
        ON DELETE SET NULL
);

-- =====================================================
-- 5. TABELA: TABELA REFERÊNCIA
-- =====================================================
CREATE TABLE TabelaReferencia (
    idTabelaReferencia INT AUTO_INCREMENT PRIMARY KEY,
    descricao_servico VARCHAR(100),
    data_vigencia DATE
);

-- =====================================================
-- 6. TABELA: SERVIÇO
-- =====================================================
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    TabelaReferencia_idTabelaReferencia INT,
    FOREIGN KEY (TabelaReferencia_idTabelaReferencia) REFERENCES TabelaReferencia(idTabelaReferencia)
        ON DELETE SET NULL
);

-- =====================================================
-- 7. TABELA: PEÇA
-- =====================================================
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    valor_unitario DECIMAL(10,2),
    estoque INT
);

-- =====================================================
-- 8. TABELA: ORDEM DE SERVIÇO
-- =====================================================
CREATE TABLE OrdemServico (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    numero_os INT,
    data_emissao DATE,
    data_conclusao_prevista DATE,
    valor_total DECIMAL(10,2),
    status VARCHAR(45),
    veiculo_idVeiculo INT,
    Cliente_idCliente INT,
    Equipe_idEquipe INT,
    FOREIGN KEY (veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

-- =====================================================
-- 9. TABELA RELACIONAL: OS_PECA
-- =====================================================
CREATE TABLE OS_Peca (
    OrdemServico_idOS INT,
    Peca_idPeca INT,
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    PRIMARY KEY (OrdemServico_idOS, Peca_idPeca),
    FOREIGN KEY (OrdemServico_idOS) REFERENCES OrdemServico(idOS)
        ON DELETE CASCADE,
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);

-- =====================================================
-- 10. TABELA RELACIONAL: OS_SERVIÇO
-- =====================================================
CREATE TABLE OS_Servico (
    OrdemServico_idOS INT,
    Servico_idServico INT,
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    PRIMARY KEY (OrdemServico_idOS, Servico_idServico),
    FOREIGN KEY (OrdemServico_idOS) REFERENCES OrdemServico(idOS)
        ON DELETE CASCADE,
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);

-- =====================================================
-- 11. INSERÇÃO DE DADOS
-- =====================================================

-- CLIENTES
INSERT INTO Cliente (nome, telefone, email, endereco)
VALUES 
('Carlos Silva', '11987654321', 'carlos@email.com', 'Rua A, 123'),
('Ana Souza', '11991234567', 'ana@email.com', 'Av. B, 456'),
('Pedro Lima', '11999887766', 'pedro@email.com', 'Rua C, 789');

-- VEÍCULOS
INSERT INTO Veiculo (placa, modelo, ano, Cliente_idCliente)
VALUES 
('ABC1234', 'Civic', '2020', 1),
('XYZ9876', 'Corolla', '2019', 2),
('JKL4321', 'HB20', '2021', 3);

-- EQUIPE
INSERT INTO Equipe (nome_equipe, responsavel)
VALUES 
('Equipe Alpha', 'João Mecânico'),
('Equipe Beta', 'Marcos Técnico');

-- MECÂNICOS
INSERT INTO Mecanico (nome, especialidade, endereco, Equipe_idEquipe)
VALUES 
('João Mecânico', 'Motor', 'Rua D, 12', 1),
('Marcos Técnico', 'Suspensão', 'Av. E, 45', 2);

-- TABELA REFERÊNCIA
INSERT INTO TabelaReferencia (descricao_servico, data_vigencia)
VALUES 
('Tabela de Serviços 2025', '2025-01-01');

-- SERVIÇOS
INSERT INTO Servico (descricao, TabelaReferencia_idTabelaReferencia)
VALUES 
('Troca de óleo', 1),
('Alinhamento e balanceamento', 1),
('Revisão elétrica', 1),
('Troca de pastilhas de freio', 1);

-- PEÇAS
INSERT INTO Peca (descricao, valor_unitario, estoque)
VALUES 
('Filtro de óleo', 40.00, 50),
('Pastilhas de freio', 120.00, 30),
('Bateria 60Ah', 300.00, 20);

-- ORDENS DE SERVIÇO
INSERT INTO OrdemServico (idOS, numero_os, data_emissao, data_conclusao_prevista, valor_total, status, veiculo_idVeiculo, Cliente_idCliente, Equipe_idEquipe)
VALUES
(1001, 501, '2025-10-01', '2025-10-03', 130.00, 'Em andamento', 1, 1, 1),
(1002, 502, '2025-10-02', '2025-10-04', 120.00, 'Concluída', 2, 2, 2),
(1003, 503, '2025-10-03', '2025-10-06', 400.00, 'Em andamento', 3, 3, 1),
(1004, 504, '2025-10-04', '2025-10-05', 80.00, 'Concluída', 1, 1, 1),
(1005, 505, '2025-10-05', '2025-10-07', 120.00, 'Em andamento', 2, 2, 2);

-- OS_SERVIÇO
INSERT INTO OS_Servico (OrdemServico_idOS, Servico_idServico, quantidade, valor_unitario, subtotal)
VALUES
(1001, 1, 1, 80.00, 80.00),
(1001, 4, 1, 50.00, 50.00),
(1002, 2, 1, 120.00, 120.00),
(1003, 3, 2, 200.00, 400.00),
(1004, 1, 1, 80.00, 80.00),
(1005, 2, 1, 120.00, 120.00);

-- OS_PECA
INSERT INTO OS_Peca (OrdemServico_idOS, Peca_idPeca, quantidade, valor_unitario, subtotal)
VALUES
(1001, 1, 1, 40.00, 40.00),
(1001, 2, 1, 120.00, 120.00),
(1003, 3, 1, 300.00, 300.00);

-- =====================================================
-- 12. CONSULTAS DE TESTE
-- =====================================================

-- 1. Ordens de serviço em andamento
SELECT numero_os, status, data_emissao, valor_total
FROM OrdemServico
WHERE status = 'Em andamento';

-- 2. Total gasto por cliente
SELECT c.nome AS Cliente, SUM(os.valor_total) AS TotalGasto
FROM OrdemServico os
JOIN Cliente c ON os.Cliente_idCliente = c.idCliente
GROUP BY c.nome;

-- 3. Serviços realizados por equipe
SELECT e.nome_equipe, COUNT(os.idOS) AS Qtde_OS
FROM OrdemServico os
JOIN Equipe e ON e.idEquipe = os.Equipe_idEquipe
GROUP BY e.nome_equipe;

-- 4. Peças mais usadas
SELECT p.descricao, SUM(op.quantidade) AS TotalUsado
FROM OS_Peca op
JOIN Peca p ON p.idPeca = op.Peca_idPeca
GROUP BY p.descricao
ORDER BY TotalUsado DESC;

-- 5. Clientes com mais de uma OS
SELECT c.nome, COUNT(os.idOS) AS Total_OS
FROM Cliente c
JOIN OrdemServico os ON c.idCliente = os.Cliente_idCliente
GROUP BY c.nome
HAVING COUNT(os.idOS) > 1;
