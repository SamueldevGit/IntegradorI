-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06-Nov-2020 às 02:53
-- Versão do servidor: 10.4.14-MariaDB
-- versão do PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `f`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `inserePessoa` (IN `Nome` VARCHAR(100), IN `Apelido` VARCHAR(100))  BEGIN
INSERT INTO pessoa (Pes_Nome, Pes_Apelido, Pes_Dat_Cadastro, DELETED) VALUES (nome, apelido, now(), null);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insereProduto` (IN `Descricao` VARCHAR(100), IN `Marca` VARCHAR(50), IN `Categoria` VARCHAR(50), IN `Valor` DECIMAL(8,2), IN `QtdMinima` FLOAT, IN `Figura` VARCHAR(500), IN `ForCodigo` INT, IN `Observacao` VARCHAR(200))  BEGIN
INSERT INTO produto(
        Pro_Descricao,
        Pro_Categoria,
        Pro_Marca,
        Pro_Valor,
        Pro_Qtd_Minima,
        Pro_Figura,
        For_Codigo,
        Pro_Observacao
    )
VALUES (
        Descricao,
        Categoria,
        Marca,
        Valor,
        QtdMinima,
        Figura,
        ForCodigo,
        Observacao
    );

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insereUsuario` (IN `Nome` VARCHAR(100), IN `Apelido` VARCHAR(100), IN `Email` VARCHAR(100), IN `Senha` VARBINARY(256))  BEGIN
call inserePessoa(Nome, Apelido);
SELECT LAST_INSERT_ID() INTO @PesCodigo;
INSERT INTO Usuario	(Usu_Nome,Usu_Login,	Usu_Senha,Usu_Tentativa,Usu_Dat_Expiracao, Usu_Dat_Cadastro, Pes_Codigo) VALUES (Nome, Email, Senha, 0, DATE_ADD(NOW(), INTERVAL 90 DAY),  now(), @PesCodigo);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estoque`
--

CREATE TABLE `estoque` (
  `Est_Codigo` int(11) NOT NULL,
  `Pro_Codigo` int(11) DEFAULT NULL,
  `Est_Dat_Lancamento` timestamp NULL DEFAULT current_timestamp(),
  `Est_Entrada` tinyint(1) DEFAULT NULL COMMENT 'Entrada = 1 Saida = 0',
  `Est_Observacao` varchar(200) DEFAULT NULL,
  `Est_Quantidade` float DEFAULT NULL,
  `Est_Saldo` float DEFAULT NULL,
  `Pes_Codigo` int(11) NOT NULL,
  `Est_Vlr_Unitario` float DEFAULT NULL,
  `Est_Vlr_NF` float DEFAULT NULL,
  `For_Codigo` int(11) DEFAULT NULL,
  `Usu_Codigo_Cadastro` int(11) DEFAULT NULL,
  `Est_Ajuste` tinyint(1) DEFAULT 0,
  `Est_Dat_Vencimento` timestamp NULL DEFAULT NULL,
  `DELETED` enum('*','') DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `estoque`
--

INSERT INTO `estoque` (`Est_Codigo`, `Pro_Codigo`, `Est_Dat_Lancamento`, `Est_Entrada`, `Est_Observacao`, `Est_Quantidade`, `Est_Saldo`, `Pes_Codigo`, `Est_Vlr_Unitario`, `Est_Vlr_NF`, `For_Codigo`, `Usu_Codigo_Cadastro`, `Est_Ajuste`, `Est_Dat_Vencimento`, `DELETED`) VALUES
(1, 1, '2020-11-05 23:52:05', 1, NULL, 10, NULL, 0, 5, NULL, NULL, 1, 0, '2020-11-21 23:51:16', ''),
(2, 1, '2020-11-05 23:52:55', 1, NULL, 10, NULL, 0, 5, NULL, NULL, 1, 0, '2020-11-21 23:51:16', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `For_Codigo` int(11) NOT NULL,
  `For_Descricao` varchar(500) NOT NULL,
  `For_CNPJ` varchar(20) DEFAULT NULL,
  `For_Endereco` varchar(500) DEFAULT NULL,
  `For_Bairro` varchar(45) DEFAULT NULL,
  `For_Numero` varchar(10) DEFAULT NULL,
  `For_Complemento` varchar(30) DEFAULT NULL,
  `For_CEP` varchar(20) DEFAULT NULL,
  `For_Email` varchar(100) DEFAULT NULL,
  `For_Razao_Social` varchar(100) DEFAULT NULL,
  `For_Telefone` varchar(45) DEFAULT NULL,
  `For_Celular` varchar(45) DEFAULT NULL,
  `For_Observacao` varchar(500) DEFAULT NULL,
  `DELETED` enum('*','') DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`For_Codigo`, `For_Descricao`, `For_CNPJ`, `For_Endereco`, `For_Bairro`, `For_Numero`, `For_Complemento`, `For_CEP`, `For_Email`, `For_Razao_Social`, `For_Telefone`, `For_Celular`, `For_Observacao`, `DELETED`) VALUES
(1, 'Kaiser', '1511515155', 'Na casa dele', 'No bairo dele', '88', 'e', '89805100', 'for@email.com', 'force LTDA', '4933226255', '49999999999', NULL, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `Pes_Codigo` int(11) NOT NULL,
  `Pes_Nome` varchar(100) NOT NULL,
  `Pes_Apelido` varchar(25) DEFAULT NULL,
  `Pes_Dat_Cadastro` datetime DEFAULT NULL,
  `DELETED` enum('*','') DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pessoa`
--

INSERT INTO `pessoa` (`Pes_Codigo`, `Pes_Nome`, `Pes_Apelido`, `Pes_Dat_Cadastro`, `DELETED`) VALUES
(1, 'Evandro dos Santos', 'Evandro', '2020-11-05 20:46:46', '*'),
(2, 'Evandro lima', 'Lima', '2020-11-05 21:15:28', NULL),
(3, 'Gustavo', 'GUGU', '2020-11-05 21:18:42', NULL),
(4, 'Maiki', 'mK', '2020-11-13 21:20:20', NULL),
(5, 'EU', 'TU', '2020-11-05 21:55:47', NULL),
(6, 'Tadeu Shimit', 'Shim', '2020-11-05 21:55:53', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `Pro_Codigo` int(11) NOT NULL,
  `Pro_Descricao` varchar(200) NOT NULL,
  `Pro_Valor` decimal(8,2) DEFAULT NULL,
  `Pro_Marca` varchar(50) DEFAULT NULL,
  `Pro_Categoria` varchar(50) DEFAULT NULL,
  `Pro_Saldo` float DEFAULT 0,
  `Pro_Figura` varchar(1000) DEFAULT NULL,
  `Pro_Qtd_Minima` int(11) DEFAULT NULL,
  `Pro_Dat_Cadastro` timestamp NULL DEFAULT current_timestamp(),
  `Pes_Codigo` int(11) NOT NULL,
  `For_Codigo` int(11) DEFAULT NULL,
  `Pro_Observacao` varchar(500) DEFAULT NULL,
  `Pro_Disp_Venda` tinyint(1) DEFAULT 0,
  `DELETED` enum('*','') DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`Pro_Codigo`, `Pro_Descricao`, `Pro_Valor`, `Pro_Marca`, `Pro_Categoria`, `Pro_Saldo`, `Pro_Figura`, `Pro_Qtd_Minima`, `Pro_Dat_Cadastro`, `Pes_Codigo`, `For_Codigo`, `Pro_Observacao`, `Pro_Disp_Venda`, `DELETED`) VALUES
(1, 'Ceva', '10.00', NULL, NULL, 0, NULL, 5, '2020-11-05 23:48:49', 1, NULL, NULL, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `Usu_Codigo` int(11) NOT NULL,
  `Usu_Nome` varchar(50) DEFAULT NULL,
  `Usu_Login` varchar(50) DEFAULT NULL,
  `Usu_Senha` varbinary(256) DEFAULT NULL,
  `Usu_Tentativa` tinyint(4) DEFAULT NULL,
  `Usu_Dat_Expiracao` datetime DEFAULT NULL,
  `Pes_Codigo` int(11) NOT NULL,
  `Usu_Inf_Imagem` tinyint(1) DEFAULT 0,
  `PCa_Codigo` int(11) DEFAULT NULL,
  `Usu_Dat_Cadastro` datetime DEFAULT NULL,
  `DELETED` enum('*','') DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`Usu_Codigo`, `Usu_Nome`, `Usu_Login`, `Usu_Senha`, `Usu_Tentativa`, `Usu_Dat_Expiracao`, `Pes_Codigo`, `Usu_Inf_Imagem`, `PCa_Codigo`, `Usu_Dat_Cadastro`, `DELETED`) VALUES
(1, 'Evandro', 'evandro@email', 0x1234, NULL, NULL, 1, 0, NULL, '2020-11-18 20:47:03', ''),
(2, 'Tadeu Shimit', 'tadeu@email.com', 0x73656e6861466f63616461, 0, '2021-02-03 21:55:53', 6, 0, NULL, '2020-11-05 21:55:53', '');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`Est_Codigo`),
  ADD KEY `FK_Est_ProCodigo` (`Pro_Codigo`),
  ADD KEY `FK_Est_PesCodigo` (`Pes_Codigo`),
  ADD KEY `FK_Estoque_ForCodigo` (`For_Codigo`),
  ADD KEY `FK_Estoque_UsuCodigoCadastro` (`Usu_Codigo_Cadastro`);

--
-- Índices para tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`For_Codigo`),
  ADD UNIQUE KEY `For_Codigo_UNIQUE` (`For_Codigo`);

--
-- Índices para tabela `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`Pes_Codigo`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`Pro_Codigo`),
  ADD KEY `FK_Pes_Codigo_Pessoa_idx` (`Pes_Codigo`),
  ADD KEY `FK_Produto_ForCodigo` (`For_Codigo`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Usu_Codigo`),
  ADD KEY `fk_Usuario_Pessoa1_idx` (`Pes_Codigo`),
  ADD KEY `IDX_Usuario_PCaCodigo` (`PCa_Codigo`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `Est_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `For_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `Pes_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `Pro_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `Usu_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `FK_Pes_Produto` FOREIGN KEY (`Pes_Codigo`) REFERENCES `pessoa` (`Pes_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Produto_ForCodigo` FOREIGN KEY (`For_Codigo`) REFERENCES `fornecedor` (`For_Codigo`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_Pessoa1` FOREIGN KEY (`Pes_Codigo`) REFERENCES `pessoa` (`Pes_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
