-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mecanica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mecanica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mecanica` DEFAULT CHARACTER SET utf8 ;
USE `mecanica` ;

-- -----------------------------------------------------
-- Table `mecanica`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `CPF` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `endereco` VARCHAR(255) NULL COMMENT 'Logradouro,Bairro,Cidade,Estado(2)',
  `dataNascimento` DATE NULL,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `placa` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `ano` CHAR(4) NULL,
  `combustivel` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mecanica`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`ordemServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`ordemServico` (
  `idordemServico` INT NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `dataEmissao` DATETIME NULL,
  `prevEntrega` DATETIME NULL,
  `dataEntrega` DATETIME NULL,
  `status` ENUM("Aguardando aprovação", "Serviço em execusão", "Servço finalizado") NULL DEFAULT 'Aguardando aprovacao',
  `valor` FLOAT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Veiculo_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idordemServico`, `Equipe_idEquipe`, `Veiculo_idVeiculo`, `Veiculo_Cliente_idCliente`),
  INDEX `fk_ordemServico_Equipe1_idx` (`Equipe_idEquipe` ASC),
  INDEX `fk_ordemServico_Veiculo1_idx` (`Veiculo_idVeiculo` ASC, `Veiculo_Cliente_idCliente` ASC),
  CONSTRAINT `fk_ordemServico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mecanica`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordemServico_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo` , `Veiculo_Cliente_idCliente`)
    REFERENCES `mecanica`.`Veiculo` (`idVeiculo` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Mecanico` (
  `idMecanico` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `especialidade` VARCHAR(45) NULL,
  `disponibilidade` TINYINT NULL,
  `endereco` VARCHAR(255) NULL COMMENT 'Logradouro,Bairro,Cidade,Estado(2)',
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`idMecanico`, `Equipe_idEquipe`),
  INDEX `fk_Mecanico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mecanica`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`Pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Pecas` (
  `idPecas` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`idPecas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`Servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`Servicos` (
  `idServicos` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  `duracao` DATETIME NULL,
  PRIMARY KEY (`idServicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`ServicosExecutados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`ServicosExecutados` (
  `Servicos_idServicos` INT NOT NULL,
  `ordemServico_idordemServico` INT NOT NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`Servicos_idServicos`, `ordemServico_idordemServico`),
  INDEX `fk_Servicos_has_ordemServico_ordemServico1_idx` (`ordemServico_idordemServico` ASC),
  INDEX `fk_Servicos_has_ordemServico_Servicos1_idx` (`Servicos_idServicos` ASC),
  CONSTRAINT `fk_Servicos_has_ordemServico_Servicos1`
    FOREIGN KEY (`Servicos_idServicos`)
    REFERENCES `mecanica`.`Servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servicos_has_ordemServico_ordemServico1`
    FOREIGN KEY (`ordemServico_idordemServico`)
    REFERENCES `mecanica`.`ordemServico` (`idordemServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mecanica`.`PecasUtilizadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mecanica`.`PecasUtilizadas` (
  `Pecas_idPecas` INT NOT NULL,
  `ordemServico_idordemServico` INT NOT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`Pecas_idPecas`, `ordemServico_idordemServico`),
  INDEX `fk_Pecas_has_ordemServico_ordemServico1_idx` (`ordemServico_idordemServico` ASC),
  INDEX `fk_Pecas_has_ordemServico_Pecas1_idx` (`Pecas_idPecas` ASC) ,
  CONSTRAINT `fk_Pecas_has_ordemServico_Pecas1`
    FOREIGN KEY (`Pecas_idPecas`)
    REFERENCES `mecanica`.`Pecas` (`idPecas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pecas_has_ordemServico_ordemServico1`
    FOREIGN KEY (`ordemServico_idordemServico`)
    REFERENCES `mecanica`.`ordemServico` (`idordemServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS ServicosExecutados (
  Servicos_idServicos INT NOT NULL,
  ordemServico_idordemServico INT NOT NULL,
  valor FLOAT NULL,
  PRIMARY KEY (Servicos_idServicos,ordemServico_idordemServico),
  FOREIGN KEY (Servicos_idServicos) REFERENCES Servicos (idServicos),
  FOREIGN KEY (ordemServico_idordemServico) REFERENCES ordemServico (idordemServico)
  );



CREATE TABLE IF NOT EXISTS `mecanica`.`PecasUtilizadas` (
  `Pecas_idPecas` INT NOT NULL,
  `ordemServico_idordemServico` INT NOT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`Pecas_idPecas`, `ordemServico_idordemServico`),
  INDEX `fk_Pecas_has_ordemServico_ordemServico1_idx` (`ordemServico_idordemServico` ASC),
  INDEX `fk_Pecas_has_ordemServico_Pecas1_idx` (`Pecas_idPecas` ASC) ,
  CONSTRAINT `fk_Pecas_has_ordemServico_Pecas1`
    FOREIGN KEY (`Pecas_idPecas`)
    REFERENCES `mecanica`.`Pecas` (`idPecas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pecas_has_ordemServico_ordemServico1`
    FOREIGN KEY (`ordemServico_idordemServico`)
    REFERENCES `mecanica`.`ordemServico` (`idordemServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
