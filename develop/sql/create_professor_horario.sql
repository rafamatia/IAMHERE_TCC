CREATE TABLE PROFESSOR_HORARIO(
  PFH_ID INTEGER NOT NULL,
  PFH_PROFESSOR VARCHAR(20) NOT NULL,
  PFH_GRADE INTEGER NOT NULL,
  PFH_HORARIO INTEGER NOT NULL,
  PFH_ANOLETIVO INTEGER NOT NULL,
  PFH_DIADASEMANA INTEGER DEFAULT 1 NOT NULL, /*SEG, TER, QUA,QUI,SEX,SAB,DOM*/
  CONSTRAINT PK_PROFESSORHORARIO PRIMARY KEY (PFH_ID),
  CONSTRAINT FK_PROFHORARIO_GRADECURRICULAR FOREIGN KEY (PFH_GRADE) REFERENCES GRADE_CURRICULAR (GRC_ID),
  CONSTRAINT FK_PROFHORARIO_PESSOAS FOREIGN KEY (PFH_PROFESSOR) REFERENCES PESSOAS (PES_CPFCNPJ),
  CONSTRAINT FK_PROFHORARIO_HORARIO FOREIGN KEY (PFH_HORARIO) REFERENCES HORARIOS (HOR_CODIGO),
  CONSTRAINT UK_PROFESSORHORARIO UNIQUE (PFH_PROFESSOR, PFH_HORARIO, PFH_ANOLETIVO, PFH_DIADASEMANA)

);

CREATE SEQUENCE SEQ_PROFHORARIO;
