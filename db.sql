-- ============================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS E DADOS DE TESTE
-- Projeto: Estúdio - Sistema de Agendamentos (MySQL)
-- ============================================================

-- 1. Criação e Seleção do Banco de Dados
CREATE DATABASE IF NOT EXISTS `estudio_db` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `estudio_db`;

-- Limpeza preventiva de tabelas caso existam
DROP TABLE IF EXISTS `horarios`;
DROP TABLE IF EXISTS `usuarios`;

-- ============================================================
-- 2. Criação da Tabela: usuarios
-- ============================================================
CREATE TABLE `usuarios` (
  `id_usuario` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `telefone` VARCHAR(20) NOT NULL,
  `senha` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 3. Criação da Tabela: horarios (Agendamentos)
-- ============================================================
CREATE TABLE `horarios` (
  `id_horarios` INT AUTO_INCREMENT PRIMARY KEY,
  `data` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_termino` TIME NOT NULL,
  `id_cliente` INT NOT NULL,
  CONSTRAINT `fk_horarios_cliente` 
    FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 4. Inserção de Dados Simulados (MOCK DATA)
-- ============================================================

-- Inserindo Usuários Simulados
INSERT INTO `usuarios` (`id_usuario`, `nome`, `email`, `telefone`, `senha`) VALUES
(1, 'Administrador do Estúdio', 'admin@estudio.com', '(42) 99999-0000', 'admin123'),
(2, 'Ana Silva', 'ana.silva@email.com', '(42) 99888-1111', 'senha123'),
(3, 'Carlos Eduardo', 'carlos.eduardo@email.com', '(42) 99777-2222', 'senha123'),
(4, 'Mariana Costa', 'mariana.costa@email.com', '(42) 99666-3333', 'senha123'),
(5, 'Lucas Oliveira', 'lucas.oliveira@email.com', '(42) 99555-4444', 'senha123');

-- Inserindo Agendamentos Simulados
INSERT INTO `horarios` (`id_horarios`, `data`, `hora_inicio`, `hora_termino`, `id_cliente`) VALUES
(1, '2026-10-10', '09:00:00', '10:00:00', 2),
(2, '2026-10-10', '10:30:00', '11:30:00', 3),
(3, '2026-10-11', '14:00:00', '15:00:00', 4),
(4, '2026-10-12', '08:00:00', '09:00:00', 2),
(5, '2026-10-12', '16:00:00', '17:00:00', 5);

-- ============================================================
-- 5. Consultas de Verificação
-- ============================================================

-- Listar todos os usuários cadastrados
SELECT * FROM `usuarios`;

-- Listar todos os agendamentos com dados dos clientes (JOIN)
SELECT 
    h.id_horarios,
    u.nome AS cliente,
    u.email,
    u.telefone,
    DATE_FORMAT(h.data, '%d/%m/%Y') AS data_agendamento,
    TIME_FORMAT(h.hora_inicio, '%H:%i') AS hora_inicio,
    TIME_FORMAT(h.hora_termino, '%H:%i') AS hora_termino
FROM `horarios` h
JOIN `usuarios` u ON h.id_cliente = u.id_usuario
ORDER BY h.data ASC, h.hora_inicio ASC;