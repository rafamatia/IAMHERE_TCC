CREATE TABLE FREQ_ACADEMICOS(
FQA_ID INTEGER NOT NULL,
FQA_ACADEMICO VARCHAR(20) NOT NULL,
FQA_PROFESSOR VARCHAR(20) NOT NULL,
FQA_DTCHAMADA DATE NOT NULL,
FQA_GRADE INTEGER NOT NULL,
FQA_PRESENCAFALTA VARCHAR(1) DEFAULT 'P' NOT NULL,
FQA_DTSINCRONIZACAO DATE,
FQA_ANOLETIVO INTEGER NOT NULL,
FQA_DIASEMANA INTEGER NOT NULL,
FQA_HORARIO INTEGER NOT NULL,
FQA_QTDAULA INTEGER NOT NULL,
CONSTRAINT PK_FREQACADEMICOS PRIMARY KEY (FQA_ID),
CONSTRAINT FK_FREQACAD_ACADEMICO FOREIGN KEY (FQA_ACADEMICO) REFERENCES PESSOAS (PES_CPFCNPJ),
CONSTRAINT FK_FREQACAD_PROFESSOR FOREIGN KEY (FQA_PROFESSOR) REFERENCES PESSOAS (PES_CPFCNPJ),
CONSTRAINT FK_FREQACAD_GRADECURRICULAR FOREIGN KEY (FQA_GRADE) REFERENCES GRADE_CURRICULAR (GRC_ID),
CONSTRAINT FK_FREQACAD_HORARIO FOREIGN KEY (FQA_HORARIO) REFERENCES HORARIOS (HOR_CODIGO)
);
