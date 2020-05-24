CREATE TABLE PESSOAS (
    PES_CODIGO          INTEGER NOT NULL,
    PES_CPFCNPJ         VARCHAR(20) NOT NULL,
    PES_GENERO          VARCHAR(1) DEFAULT 'F' NOT NULL,
    PES_DATANASCIMENTO  DATE,
    PES_TIPOPESSOA      VARCHAR(1) DEFAULT 'F' NOT NULL,
    PES_NOMECOMPLETO    VARCHAR(60) NOT NULL,
    CONSTRAINT PK_PESSOAS PRIMARY KEY (PES_CPFCNPJ)
);

CREATE SEQUENCE SEQ_PESSOAS;