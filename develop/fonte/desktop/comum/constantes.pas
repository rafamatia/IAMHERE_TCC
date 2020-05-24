unit constantes;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics;

const

  nulo: Char = Chr(0);
  BkSpc: Char = Chr(8);
  Tab: Char = Chr(9);
  lf: Char = Chr(10);
  Enter: Char = Chr(13);
  Esc: Char = Chr(27);
  Del: Char = Chr(127);
  vlrMaxTimeOut = 300;
  COR_READONLY: TColor = cl3DLight;
  COR_WHITE: TColor = clWhite;
  COR_REQUIRIDO: TColor = clSkyBlue;
  ZERO: Integer = 0;
  UM: Integer = 1;
  C_MASCARA_VALOR: String = '###,###,##0.00';

  C_DATA_EMPTY = '  /  /    ';

  C_SENHAPADRAO = '123';

  I_PADRAOCRIPTOGRAFIA = 400;

  C_WHERE_SIMPLES = ' WHERE ';

  { =============================================================================
    INICIO GENERATOR
    ============================================================================= }

  C_SEQ_DATA_VIGENCIA = 'SEQ_DATA_VIGENCIA';

  C_SEQ_DEPARTAMENTOS = 'SEQ_DEPARTAMENTOS';

  C_SEQ_DISCIPLINAS = 'SEQ_DISCIPLINAS';

  C_SEQ_ACADEMICO_GRADE = 'SEQ_ACADEMICO_GRADE';

  C_SEQ_CURSOS = 'SEQ_CURSOS';

  C_SEQ_GRADE_CURRICULAR = 'SEQ_GRADE_CURRICULAR';

  C_SEQ_HORARIOS = 'SEQ_HORARIOS';

  C_SEQ_PESSOAS = 'SEQ_PESSOAS';

  C_SEQ_PROFHORARIO = 'SEQ_PROFHORARIO';

  { =============================================================================
    FIM GENERATOR
    ============================================================================= }

  C_SQL_DATAVIGENCIA = 'SELECT A.* FROM DATA_VIGENCIA A';

  C_SQL_DEPARTAMENTOS = 'SELECT A.* FROM DEPARTAMENTOS A';

  C_SQL_DISCIPLINAS = 'SELECT A.* FROM DISCIPLINAS A';

  C_SQL_SERIES = 'SELECT A.* FROM SERIES A';

  C_SQL_HORARIOS = 'SELECT A.* FROM HORARIOS A';

  C_SQL_PESSOAS = ' SELECT A.* FROM PESSOAS A ';

  C_SQL_CURSOS = 'SELECT A.*, B.DEP_DESCRICAO FROM CURSOS A ' +
    ' INNER JOIN DEPARTAMENTOS B ON A.CUR_DEPARTAMENTO = B.DEP_CODIGO ';

  C_SQL_GRADECURRICULAR =
    ' select a.*,                                                  ' +
    '        c.dis_descricao,                                      ' +
    '        d.ser_descricao,                                      ' +
    '        e.dvg_dt_inicio,                                      ' +
    '        e.dvg_dt_fim                                          ' +
    '   from grade_curricular a                                    ' +
    '  inner join cursos b on b.cur_codigo = a.grc_curso           ' +
    '  inner join disciplinas c on c.dis_codigo = a.grc_disciplina ' +
    '  inner join series d on d.ser_ano = a.grc_serie              ' +
    '  inner join data_vigencia e on e.dvg_id = a.grc_datavigencia ';

implementation

uses tipos;

end.
