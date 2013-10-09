-- -----------------------------------------------------
-- Table `INSTITUICAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `INSTITUICAO` (
  `idINSTITUICAO` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(45) NULL,
  `nome` VARCHAR(240) NULL,
  `cnpj` VARCHAR(45) NULL,
  PRIMARY KEY (`idINSTITUICAO`))
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- -----------------------------------------------------
-- Table `PESSOA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PESSOA` (
  `idPESSOA` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(240) NULL,
  `email` VARCHAR(240) NULL,
  `tipo` VARCHAR(240) NULL,
  `INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idPESSOA`, `INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_PESSOA_INSTITUICAO1_idx` (`INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_PESSOA_INSTITUICAO1`
    FOREIGN KEY (`INSTITUICAO_idINSTITUICAO`)
    REFERENCES `INSTITUICAO` (`idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- -----------------------------------------------------
-- Table `REPRESENTANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REPRESENTANTE` (
  `idREPRESENTANTE` INT NOT NULL AUTO_INCREMENT,
  `cargo` VARCHAR(240) NULL,
  `departamento` VARCHAR(240) NULL,
  `tipoRepresentante` VARCHAR(45) NULL,
  `PESSOA_idPESSOA` INT NOT NULL,
  `PESSOA_INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idREPRESENTANTE`, `PESSOA_idPESSOA`, `PESSOA_INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_REPRESENTANTE_PESSOA1_idx` (`PESSOA_idPESSOA` ASC, `PESSOA_INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_REPRESENTANTE_PESSOA1`
    FOREIGN KEY (`PESSOA_idPESSOA` , `PESSOA_INSTITUICAO_idINSTITUICAO`)
    REFERENCES `PESSOA` (`idPESSOA` , `INSTITUICAO_idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1
COMMENT = ' ';

-- -----------------------------------------------------
-- Table `CIRCUITO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CIRCUITO` (
  `idCIRCUITO` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(240) NULL,
  `dataAtivacao` DATE NULL,
  `dataDesativacao` DATE NULL,
  `INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idCIRCUITO`, `INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_CIRCUITO_INSTITUICAO1_idx` (`INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_CIRCUITO_INSTITUICAO1`
    FOREIGN KEY (`INSTITUICAO_idINSTITUICAO`)
    REFERENCES `INSTITUICAO` (`idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1
COMMENT = '';

-- -----------------------------------------------------
-- Table `TIPO_INSTRUMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TIPO_INSTRUMENTO` (
  `idTIPO_INSTRUMENTO` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(240) NULL,
  PRIMARY KEY (`idTIPO_INSTRUMENTO`))
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- -----------------------------------------------------
-- Table `INSTRUMENTO_JURIDICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `INSTRUMENTO_JURIDICO` (
  `idINSTRUMENTO_JURIDICO` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(240) NULL,
  `dataInicio` DATE NULL,
  `dataFim` DATE NULL,
  `valorContratoOriginal` DOUBLE NULL,
  `informacoes` VARCHAR(240) NULL,
  `INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  `TIPO_INSTRUMENTO_idTIPO_INSTRUMENTO` INT NOT NULL,
  `INSTITUICAO_CONTRATADA_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idINSTRUMENTO_JURIDICO`, `INSTITUICAO_idINSTITUICAO`, `TIPO_INSTRUMENTO_idTIPO_INSTRUMENTO`, `INSTITUICAO_CONTRATADA_idINSTITUICAO`),
  INDEX `fk_INSTRUMENTO_JURIDICO_TIPO_INSTRUMENTO1_idx` (`TIPO_INSTRUMENTO_idTIPO_INSTRUMENTO` ASC),
  INDEX `fk_INSTRUMENTO_JURIDICO_INSTITUICAO1_idx` (`INSTITUICAO_CONTRATADA_idINSTITUICAO` ASC),
  CONSTRAINT `fk_INSTRUMENTO_JURIDICO_TIPO_INSTRUMENTO1`
    FOREIGN KEY (`TIPO_INSTRUMENTO_idTIPO_INSTRUMENTO`)
    REFERENCES `TIPO_INSTRUMENTO` (`idTIPO_INSTRUMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INSTITUICAO_CONTRATADA_idINSTITUICAO1`
    FOREIGN KEY (`INSTITUICAO_idINSTITUICAO`)
    REFERENCES `INSTITUICAO` (`idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INSTRUMENTO_JURIDICO_INSTITUICAO1`
    FOREIGN KEY (`INSTITUICAO_CONTRATADA_idINSTITUICAO`)
    REFERENCES `INSTITUICAO` (`idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- -----------------------------------------------------
-- Table `ADITIVOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ADITIVOS` (
  `idADITIVOS` INT NOT NULL AUTO_INCREMENT,
  `numeroProrrogacao` INT NULL,
  `dataInicio` DATE NULL,
  `dataFim` DATE NULL,
  `INSTRUMENTO_JURIDICO_idINSTRUMENTO_JURIDICO` INT NOT NULL,
  `INSTRUMENTO_JURIDICO_INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idADITIVOS`, `INSTRUMENTO_JURIDICO_idINSTRUMENTO_JURIDICO`, `INSTRUMENTO_JURIDICO_INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_ADITIVOS_INSTRUMENTO_JURIDICO1_idx` (`INSTRUMENTO_JURIDICO_idINSTRUMENTO_JURIDICO` ASC, `INSTRUMENTO_JURIDICO_INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_ADITIVOS_INSTRUMENTO_JURIDICO1`
    FOREIGN KEY (`INSTRUMENTO_JURIDICO_idINSTRUMENTO_JURIDICO` , `INSTRUMENTO_JURIDICO_INSTITUICAO_idINSTITUICAO`)
    REFERENCES `INSTRUMENTO_JURIDICO` (`idINSTRUMENTO_JURIDICO` , `INSTITUICAO_idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- -----------------------------------------------------
-- Table ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ENDERECO` (
  `idENDERECO` INT NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(240) NULL,
  `bairro` VARCHAR(240) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cep` VARCHAR(15) NULL,
  `INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idENDERECO`, `INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_ENDERECO_INSTITUICAO1_idx` (`INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_ENDERECO_INSTITUICAO1`
    FOREIGN KEY (`INSTITUICAO_idINSTITUICAO`)
    REFERENCES `INSTITUICAO` (`idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TELEFONE` (
  `idTELEFONE` INT NOT NULL AUTO_INCREMENT,
  `telefoneFixo` VARCHAR(45) NULL,
  `telefoneMovel` VARCHAR(45) NULL,
  `PESSOA_idPESSOA` INT NOT NULL,
  `PESSOA_INSTITUICAO_idINSTITUICAO` INT NOT NULL,
  PRIMARY KEY (`idTELEFONE`, `PESSOA_idPESSOA`, `PESSOA_INSTITUICAO_idINSTITUICAO`),
  INDEX `fk_TELEFONE_PESSOA1_idx` (`PESSOA_idPESSOA` ASC, `PESSOA_INSTITUICAO_idINSTITUICAO` ASC),
  CONSTRAINT `fk_TELEFONE_PESSOA1`
    FOREIGN KEY (`PESSOA_idPESSOA` , `PESSOA_INSTITUICAO_idINSTITUICAO`)
    REFERENCES `PESSOA` (`idPESSOA` , `INSTITUICAO_idINSTITUICAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;


SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
