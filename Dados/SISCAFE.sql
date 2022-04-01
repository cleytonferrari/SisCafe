/* SQL Manager 2005 Lite for InterBase and Firebird 4.2.0.4 */
/* -------------------------------------------------------- */
/* Host     : localhost                                     */
/* Database : C:\SisCafe\Dados\SISCAFE.GDB                  */


CREATE DATABASE 'localhost:C:\SisCafe\Dados\SISCAFE.GDB'   USER 'SYSDBA'
   PAGE_SIZE 4096;


/* Definition for the `GEN_BAIRROS` generator :  */

CREATE GENERATOR GEN_BAIRROS;

SET GENERATOR GEN_BAIRROS TO 15;

/* Definition for the `GEN_CLIENTE` generator :  */

CREATE GENERATOR GEN_CLIENTE;

SET GENERATOR GEN_CLIENTE TO 10;

/* Definition for the `GEN_COMPRA` generator :  */

CREATE GENERATOR GEN_COMPRA;

SET GENERATOR GEN_COMPRA TO 91;

/* Definition for the `GEN_ENDERECOS` generator :  */

CREATE GENERATOR GEN_ENDERECOS;

SET GENERATOR GEN_ENDERECOS TO 42;

/* Definition for the `GEN_FORNECEDOR` generator :  */

CREATE GENERATOR GEN_FORNECEDOR;

SET GENERATOR GEN_FORNECEDOR TO 43;

/* Definition for the `GEN_HISTORICOEMPRESTIMO` generator :  */

CREATE GENERATOR GEN_HISTORICOEMPRESTIMO;

SET GENERATOR GEN_HISTORICOEMPRESTIMO TO 24;

/* Definition for the `GEN_HISTORICOSACARIA` generator :  */

CREATE GENERATOR GEN_HISTORICOSACARIA;

SET GENERATOR GEN_HISTORICOSACARIA TO 32;

/* Definition for the `GEN_ITENSCOMPRA` generator :  */

CREATE GENERATOR GEN_ITENSCOMPRA;

SET GENERATOR GEN_ITENSCOMPRA TO 80;

/* Definition for the `GEN_ITENSVENDA` generator :  */

CREATE GENERATOR GEN_ITENSVENDA;

SET GENERATOR GEN_ITENSVENDA TO 41;

/* Definition for the `GEN_PRODUTO` generator :  */

CREATE GENERATOR GEN_PRODUTO;

SET GENERATOR GEN_PRODUTO TO 10;

/* Definition for the `GEN_VENDA` generator :  */

CREATE GENERATOR GEN_VENDA;

SET GENERATOR GEN_VENDA TO 20;


/* Definition for the `ATU_ESTOQUE` procedure :  */

SET TERM ^ ;

CREATE PROCEDURE ATU_ESTOQUE(
  ID INTEGER,
  OPERACAO VARCHAR(20) CHARACTER SET NONE)
RETURNS(
  OK SMALLINT)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
  EXIT;
END^

SET TERM ; ^

/* Definition for the `ATU_ESTOQUE_EDIT` procedure :  */

SET TERM ^ ;

CREATE PROCEDURE ATU_ESTOQUE_EDIT(
  ID INTEGER,
  OPERACAO VARCHAR(20) CHARACTER SET NONE)
RETURNS(
  OK SMALLINT)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
  EXIT;
END^

SET TERM ; ^

/* Definition for the `ATU_VENDA` procedure :  */

SET TERM ^ ;

CREATE PROCEDURE ATU_VENDA(
  ID INTEGER)
RETURNS(
  OK CHAR(3) CHARACTER SET NONE)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
  EXIT;
END^

SET TERM ; ^

/* Definition for the `ATU_VENDA_EDIT` procedure :  */

SET TERM ^ ;

CREATE PROCEDURE ATU_VENDA_EDIT(
  ID INTEGER)
RETURNS(
  OK CHAR(3) CHARACTER SET NONE)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
  EXIT;
END^

SET TERM ; ^

COMMIT WORK;


/* Structure for the `BAIRROS` table :  */

CREATE TABLE BAIRROS (
  BAIRROS_ID INTEGER NOT NULL,
  NOME VARCHAR(50) CHARACTER SET NONE NOT NULL COLLATE NONE);


CREATE UNIQUE INDEX XPKBAIRROS ON BAIRROS(BAIRROS_ID);


/* Structure for the `CLIENTE` table :  */

CREATE TABLE CLIENTE (
  CLIENTE_ID INTEGER NOT NULL,
  ENDERECOS_ID INTEGER,
  NOME_RAZAOSOCIAL VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  CPF_CNPJ VARCHAR(14) CHARACTER SET NONE COLLATE NONE,
  RG_IE VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  DATA_CADASTRO DATE,
  TELEFONES VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  EMAIL VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
  OBS BLOB);


CREATE UNIQUE INDEX XPKCLIENTE ON CLIENTE(CLIENTE_ID);


/* Structure for the `COMPRA` table :  */

CREATE TABLE COMPRA (
  COMPRA_ID INTEGER NOT NULL,
  FORNECEDOR_ID INTEGER,
  DATA DATE,
  OPCAO VARCHAR(20) CHARACTER SET NONE COLLATE NONE,
  FUNRURAL DECIMAL(10, 2));


CREATE UNIQUE INDEX XPKCOMPRA ON COMPRA(COMPRA_ID);


/* Structure for the `ENDERECOS` table :  */

CREATE TABLE ENDERECOS (
  ENDERECOS_ID INTEGER NOT NULL,
  BAIRROS_ID INTEGER NOT NULL,
  LOGRADOURO VARCHAR(70) CHARACTER SET NONE NOT NULL COLLATE NONE,
  CEP VARCHAR(8) CHARACTER SET NONE NOT NULL COLLATE NONE,
  MUNICIPIO_ID VARCHAR(10) CHARACTER SET NONE NOT NULL COLLATE NONE);


CREATE UNIQUE INDEX XPKENDERECOS ON ENDERECOS(ENDERECOS_ID);


/* Structure for the `FORNECEDOR` table :  */

CREATE TABLE FORNECEDOR (
  FORNECEDOR_ID INTEGER NOT NULL,
  NOME_RAZAOSOCIAL VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  CPF_CNPJ VARCHAR(14) CHARACTER SET NONE COLLATE NONE,
  RG_IE VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  DATA_CADASTRO DATE,
  TELEFONES VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  EMAIL VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
  AVALISTA VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  CPF_AVALISTA CHAR(11) CHARACTER SET NONE COLLATE NONE,
  OBS BLOB,
  SACARIA INTEGER,
  EMPRESTIMO NUMERIC(10, 2),
  ENDERECOS_ID INTEGER);


CREATE UNIQUE INDEX XPKFORNECEDOR ON FORNECEDOR(FORNECEDOR_ID);


/* Structure for the `HISTORICOEMPRESTIMO` table :  */

CREATE TABLE HISTORICOEMPRESTIMO (
  HISTORICOEMPRESTIMO_ID INTEGER NOT NULL,
  FORNECEDOR_ID INTEGER,
  DATA DATE,
  VALOR DECIMAL(10, 2),
  STATUS CHAR(1) CHARACTER SET NONE COLLATE NONE);


CREATE UNIQUE INDEX XPKHISTORICOEMPRESTIMO ON HISTORICOEMPRESTIMO(HISTORICOEMPRESTIMO_ID);


/* Structure for the `HISTORICOSACARIA` table :  */

CREATE TABLE HISTORICOSACARIA (
  HISTORICOSACARIA_ID INTEGER NOT NULL,
  FORNECEDOR_ID INTEGER,
  DATA DATE,
  QUANT INTEGER,
  STATUS CHAR(1) CHARACTER SET NONE COLLATE NONE);


CREATE UNIQUE INDEX XPKHISTORICOSACARIA ON HISTORICOSACARIA(HISTORICOSACARIA_ID);


/* Structure for the `ITENSCOMPRA` table :  */

CREATE TABLE ITENSCOMPRA (
  ITENSCOMPRA_ID INTEGER NOT NULL,
  COMPRA_ID INTEGER,
  PRODUTO_ID INTEGER,
  QUANTIDADE DECIMAL(10, 2),
  VALOR_TOTAL DECIMAL(10, 2),
  APROVEITAMENTO DECIMAL(10, 2));


CREATE INDEX IDX_ITENSCOMPRA ON ITENSCOMPRA(COMPRA_ID);

CREATE UNIQUE INDEX XPKITENSCOMPRA ON ITENSCOMPRA(ITENSCOMPRA_ID);


/* Structure for the `ITENSVENDA` table :  */

CREATE TABLE ITENSVENDA (
  ITENSVENDA_ID INTEGER NOT NULL,
  PRODUTO_ID INTEGER,
  VENDA_ID INTEGER,
  QUANTIDADE DECIMAL(10, 2),
  VALORTOTAL DECIMAL(10, 2));


CREATE UNIQUE INDEX XPKITENSVENDA ON ITENSVENDA(ITENSVENDA_ID);


/* Structure for the `MUNICIPIO` table :  */

CREATE TABLE MUNICIPIO (
  MUNICIPIO_ID VARCHAR(10) CHARACTER SET NONE NOT NULL COLLATE NONE,
  NOME VARCHAR(50) CHARACTER SET NONE NOT NULL COLLATE NONE,
  UF VARCHAR(2) CHARACTER SET NONE NOT NULL COLLATE NONE);


CREATE UNIQUE INDEX XPKMUNICIPIO ON MUNICIPIO(MUNICIPIO_ID);


/* Structure for the `PRODUTO` table :  */

CREATE TABLE PRODUTO (
  PRODUTO_ID INTEGER NOT NULL,
  DESCRICAO VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
  ESTFORNECEDOR DECIMAL(10, 2),
  ESTEMPRESA DECIMAL(10, 2),
  VALORCOMPRA DECIMAL(10, 2),
  VALORVENDA DECIMAL(10, 2),
  UND VARCHAR(4) CHARACTER SET NONE COLLATE NONE);


CREATE UNIQUE INDEX XPKPRODUTO ON PRODUTO(PRODUTO_ID);


/* Structure for the `UF` table :  */

CREATE TABLE UF (
  UF VARCHAR(2) CHARACTER SET NONE NOT NULL COLLATE NONE,
  UF_ID VARCHAR(2) CHARACTER SET NONE COLLATE NONE,
  ESTADO VARCHAR(50) CHARACTER SET NONE COLLATE NONE);


CREATE UNIQUE INDEX XPKUF ON UF(UF);


/* Structure for the `USUARIOS` table :  */

CREATE TABLE USUARIOS (
  USUARIO_ID INTEGER NOT NULL,
  NOME VARCHAR(20) CHARACTER SET NONE COLLATE NONE,
  SENHA VARCHAR(8) CHARACTER SET NONE COLLATE NONE);


ALTER TABLE USUARIOS ADD PRIMARY KEY (USUARIO_ID);


/* Structure for the `VENDA` table :  */

CREATE TABLE VENDA (
  VENDA_ID INTEGER NOT NULL,
  CLIENTE_ID INTEGER,
  DATA DATE);


CREATE UNIQUE INDEX XPKVENDA ON VENDA(VENDA_ID);


COMMIT WORK;


/* Definition for the `ENDERECOCOMPLETO` view :  */

CREATE VIEW ENDERECOCOMPLETO(
  ENDERECOS_ID,
  LOGRADOURO,
  CEP,
  NOMEBAIRRO,
  NOMEMUNICIPIO,
  UF)
AS
SELECT
     ENDERECOS.ENDERECOS_ID,
     ENDERECOS.LOGRADOURO,
     ENDERECOS.CEP,
     BAIRROS.NOME,
     MUNICIPIO.NOME,
     MUNICIPIO.UF
  FROM ENDERECOS, BAIRROS, MUNICIPIO
  WHERE
    ENDERECOS.BAIRROS_ID = BAIRROS.BAIRROS_ID AND
    ENDERECOS.MUNICIPIO_ID = MUNICIPIO.MUNICIPIO_ID
;

/* Definition for the `CLIENTEENDERECO` view :  */

CREATE VIEW CLIENTEENDERECO(
  CLIENTE_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ,
  RG_IE,
  DATA_CADASTRO,
  TELEFONES,
  EMAIL,
  OBS,
  ENDERECOS_ID,
  LOGRADOURO,
  CEP,
  NOMEBAIRRO,
  NOMEMUNICIPIO,
  UF)
AS
SELECT
     CLIENTE.CLIENTE_ID , CLIENTE.NOME_RAZAOSOCIAL , CLIENTE.CPF_CNPJ,
     CLIENTE.RG_IE , CLIENTE.DATA_CADASTRO , CLIENTE.TELEFONES, CLIENTE.EMAIL,
     CLIENTE.OBS, ENDERECOCOMPLETO.ENDERECOS_ID, ENDERECOCOMPLETO.LOGRADOURO,
     ENDERECOCOMPLETO.CEP, ENDERECOCOMPLETO.NOMEBAIRRO, ENDERECOCOMPLETO.NOMEMUNICIPIO, ENDERECOCOMPLETO.UF
     FROM CLIENTE, ENDERECOCOMPLETO
  WHERE
    CLIENTE.ENDERECOS_ID = ENDERECOCOMPLETO.ENDERECOS_ID
;

/* Definition for the `CLIENTEVENDA` view :  */

CREATE VIEW CLIENTEVENDA(
  VENDA_ID,
  DATA,
  CLIENTE_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ)
AS
select venda.venda_id, venda.data,
       cliente.cliente_id, cliente.nome_razaosocial, cliente.cpf_cnpj
from
   venda, cliente
  where
   cliente.cliente_id = venda.cliente_id
;

/* Definition for the `FORNECEDORCOMPRA` view :  */

CREATE VIEW FORNECEDORCOMPRA(
  COMPRA_ID,
  DATA,
  OPCAO,
  FORNECEDOR_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ)
AS
select compra.compra_id, compra.data, compra.opcao,
       fornecedor.fornecedor_id, fornecedor.nome_razaosocial, fornecedor.cpf_cnpj
from
   compra, fornecedor
  where
   fornecedor.fornecedor_id = compra.fornecedor_id
;

/* Definition for the `FORNECEDORENDERECO` view :  */

CREATE VIEW FORNECEDORENDERECO(
  FORNECEDOR_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ,
  RG_IE,
  DATA_CADASTRO,
  TELEFONES,
  EMAIL,
  AVALISTA,
  CPF_AVALISTA,
  OBS,
  SACARIA,
  EMPRESTIMO,
  ENDERECOS_ID,
  LOGRADOURO,
  CEP,
  NOMEBAIRRO,
  NOMEMUNICIPIO,
  UF)
AS
SELECT
     FORNECEDOR.FORNECEDOR_ID , FORNECEDOR.NOME_RAZAOSOCIAL , FORNECEDOR.CPF_CNPJ,
     FORNECEDOR.RG_IE , FORNECEDOR.DATA_CADASTRO , FORNECEDOR.TELEFONES, FORNECEDOR.EMAIL,
     FORNECEDOR.AVALISTA, FORNECEDOR.CPF_AVALISTA, FORNECEDOR.OBS, FORNECEDOR.SACARIA,
     FORNECEDOR.EMPRESTIMO, ENDERECOCOMPLETO.ENDERECOS_ID, ENDERECOCOMPLETO.LOGRADOURO,
     ENDERECOCOMPLETO.CEP, ENDERECOCOMPLETO.NOMEBAIRRO, ENDERECOCOMPLETO.NOMEMUNICIPIO, ENDERECOCOMPLETO.UF
     FROM FORNECEDOR, ENDERECOCOMPLETO
  WHERE
    FORNECEDOR.ENDERECOS_ID = ENDERECOCOMPLETO.ENDERECOS_ID
;

/* Definition for the `HISTORICOCOMPRA` view :  */

CREATE VIEW HISTORICOCOMPRA(
  FORNECEDOR_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ,
  RG_IE,
  COMPRA_ID,
  DATA,
  OPCAO,
  FUNRURAL,
  ITENSCOMPRA_ID,
  PRODUTO_ID,
  QUANTIDADE,
  VALOR_TOTAL,
  APROVEITAMENTO,
  DESCRICAO,
  ESTFORNECEDOR,
  ESTEMPRESA,
  VALORCOMPRA,
  VALORVENDA,
  UND)
AS
SELECT FORNECEDOR.FORNECEDOR_ID, FORNECEDOR.NOME_RAZAOSOCIAL, FORNECEDOR.CPF_CNPJ, FORNECEDOR.RG_IE, COMPRA.COMPRA_ID, COMPRA.DATA, COMPRA.OPCAO, COMPRA.FUNRURAL, ITENSCOMPRA.ITENSCOMPRA_ID, ITENSCOMPRA.PRODUTO_ID, ITENSCOMPRA.QUANTIDADE, ITENSCOMPRA.VALOR_TOTAL, ITENSCOMPRA.APROVEITAMENTO, PRODUTO.DESCRICAO, PRODUTO.ESTFORNECEDOR, PRODUTO.ESTEMPRESA, PRODUTO.VALORCOMPRA, PRODUTO.VALORVENDA, PRODUTO.UND
	FROM FORNECEDOR, COMPRA, ITENSCOMPRA, PRODUTO
	WHERE FORNECEDOR.FORNECEDOR_ID = COMPRA.FORNECEDOR_ID AND
COMPRA.COMPRA_ID = ITENSCOMPRA.COMPRA_ID AND
ITENSCOMPRA.PRODUTO_ID = PRODUTO.PRODUTO_ID
;

/* Definition for the `HISTORICOVENDA` view :  */

CREATE VIEW HISTORICOVENDA(
  CLIENTE_ID,
  NOME_RAZAOSOCIAL,
  CPF_CNPJ,
  RG_IE,
  VENDA_ID,
  DATA,
  ITENSVENDA_ID,
  PRODUTO_ID,
  QUANTIDADE,
  VALORTOTAL,
  DESCRICAO,
  ESTFORNECEDOR,
  ESTEMPRESA,
  VALORCOMPRA,
  VALORVENDA,
  UND)
AS
SELECT CLIENTE.CLIENTE_ID, CLIENTE.NOME_RAZAOSOCIAL, CLIENTE.CPF_CNPJ, CLIENTE.RG_IE, VENDA.VENDA_ID, VENDA.DATA, ITENSVENDA.ITENSVENDA_ID, ITENSVENDA.PRODUTO_ID, ITENSVENDA.QUANTIDADE, ITENSVENDA.VALORTOTAL, PRODUTO.DESCRICAO, PRODUTO.ESTFORNECEDOR, PRODUTO.ESTEMPRESA, PRODUTO.VALORCOMPRA, PRODUTO.VALORVENDA, PRODUTO.UND
	FROM VENDA, CLIENTE, ITENSVENDA, PRODUTO
	WHERE CLIENTE.CLIENTE_ID = VENDA.CLIENTE_ID AND
VENDA.VENDA_ID = ITENSVENDA.VENDA_ID AND
ITENSVENDA.PRODUTO_ID = PRODUTO.PRODUTO_ID
;

COMMIT WORK;


/* Definition for the `ATU_ESTOQUE` procedure :  */

SET TERM ^ ;

ALTER PROCEDURE ATU_ESTOQUE(
  ID INTEGER,
  OPERACAO VARCHAR(20) CHARACTER SET NONE)
RETURNS(
  OK SMALLINT)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
FOR
 SELECT
   PRODUTO_ID, QUANTIDADE
 FROM
   ITENSCOMPRA
 WHERE
   COMPRA_ID = :ID
 INTO
   :COD, :QUANT
 DO BEGIN
 IF (:OPERACAO = 'DEPOSITO') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR + :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'RETIRADA') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR - :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'COMPRA') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA + :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'COMPRA EM DEPOSITO') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR - :QUANT
   WHERE PRODUTO_ID = :COD;
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA + :QUANT
   WHERE PRODUTO_ID = :COD;
 END
END
SUSPEND;
END^

SET TERM ; ^

/* Definition for the `ATU_ESTOQUE_EDIT` procedure :  */

SET TERM ^ ;

ALTER PROCEDURE ATU_ESTOQUE_EDIT(
  ID INTEGER,
  OPERACAO VARCHAR(20) CHARACTER SET NONE)
RETURNS(
  OK SMALLINT)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
FOR
 SELECT
   PRODUTO_ID, QUANTIDADE
 FROM
   ITENSCOMPRA
 WHERE
   COMPRA_ID = :ID
 INTO
   :COD, :QUANT
 DO BEGIN
 IF (:OPERACAO = 'DEPOSITO') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR - :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'RETIRADA') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR + :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'COMPRA') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA - :QUANT
   WHERE PRODUTO_ID = :COD;
 END
 IF (:OPERACAO = 'COMPRA EM DEPOSITO') THEN
 BEGIN
   UPDATE PRODUTO
   SET
   ESTFORNECEDOR = ESTFORNECEDOR + :QUANT
   WHERE PRODUTO_ID = :COD;
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA - :QUANT
   WHERE PRODUTO_ID = :COD;
 END
END
SUSPEND;
END^

SET TERM ; ^

/* Definition for the `ATU_VENDA` procedure :  */

SET TERM ^ ;

ALTER PROCEDURE ATU_VENDA(
  ID INTEGER)
RETURNS(
  OK CHAR(3) CHARACTER SET NONE)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
FOR
 SELECT
   PRODUTO_ID, QUANTIDADE
 FROM
   ITENSVENDA
 WHERE
   VENDA_ID = :ID
 INTO
   :COD, :QUANT
 DO BEGIN
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA - :QUANT
   WHERE PRODUTO_ID = :COD;
END
SUSPEND;
END^

SET TERM ; ^

/* Definition for the `ATU_VENDA_EDIT` procedure :  */

SET TERM ^ ;

ALTER PROCEDURE ATU_VENDA_EDIT(
  ID INTEGER)
RETURNS(
  OK CHAR(3) CHARACTER SET NONE)
AS
DECLARE VARIABLE COD DECIMAL(10,2);
DECLARE VARIABLE QUANT DECIMAL(10,2);
BEGIN
FOR
 SELECT
   PRODUTO_ID, QUANTIDADE
 FROM
   ITENSVENDA
 WHERE
   VENDA_ID = :ID
 INTO
   :COD, :QUANT
 DO BEGIN
   UPDATE PRODUTO
   SET
   ESTEMPRESA = ESTEMPRESA + :QUANT
   WHERE PRODUTO_ID = :COD;
END
SUSPEND;
END^

SET TERM ; ^

COMMIT WORK;


/* Definition for the `AFT_INS_EMPRESTIMO` trigger :  */

SET TERM ^ ;

CREATE TRIGGER AFT_INS_EMPRESTIMO FOR HISTORICOEMPRESTIMO
ACTIVE AFTER INSERT
POSITION 0
AS
BEGIN
IF (NEW.STATUS = 'D') THEN
BEGIN
  UPDATE FORNECEDOR SET
    EMPRESTIMO = EMPRESTIMO - NEW.VALOR
  WHERE
    FORNECEDOR_ID = NEW.FORNECEDOR_ID;
END
IF (NEW.STATUS = 'E') THEN
BEGIN
  UPDATE FORNECEDOR SET
    EMPRESTIMO = EMPRESTIMO + NEW.VALOR
  WHERE
    FORNECEDOR_ID = NEW.FORNECEDOR_ID;
END
END^

SET TERM ; ^

/* Definition for the `AFT_INS_SACARIA` trigger :  */

SET TERM ^ ;

CREATE TRIGGER AFT_INS_SACARIA FOR HISTORICOSACARIA
ACTIVE AFTER INSERT
POSITION 0
AS
BEGIN
IF (NEW.STATUS = 'D') THEN
BEGIN
  UPDATE FORNECEDOR SET
    SACARIA = SACARIA - NEW.QUANT
  WHERE
    FORNECEDOR_ID = NEW.FORNECEDOR_ID;
END
IF (NEW.STATUS = 'E') THEN
BEGIN
  UPDATE FORNECEDOR SET
    SACARIA = SACARIA + NEW.QUANT
  WHERE
    FORNECEDOR_ID = NEW.FORNECEDOR_ID;
END
END^

SET TERM ; ^


