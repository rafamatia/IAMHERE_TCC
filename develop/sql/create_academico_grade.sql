CREATE TABLE ACADEMICO_GRADE (
    ACG_ID         INTEGER NOT NULL,
    ACG_ACADEMICO  VARCHAR(20) NOT NULL,
    ACG_GRADE      INTEGER NOT NULL,
    ACG_ANOLETIVO  INTEGER NOT NULL,
    CONSTRAINT PK_ACADEMICOGRADE PRIMARY KEY (ACG_ID),
    CONSTRAINT FK_ACADGRADE_GRADECURRICULAR FOREIGN KEY (ACG_GRADE) REFERENCES GRADE_CURRICULAR (GRC_ID),
    CONSTRAINT FK_ACADGRADE_PESSOAS FOREIGN KEY (ACG_ACADEMICO) REFERENCES PESSOAS (PES_CPFCNPJ),
    CONSTRAINT UK_ACADEMICOGRADE UNIQUE (ACG_ACADEMICO, ACG_GRADE, ACG_ANOLETIVO)
);

CREATE SEQUENCE SEQ_ACADEMICO_GRADE;

