unit uConstantes;

interface

const

  C_SQL_PROFHORARIO = ' select a.*, ' + ' b.pes_nomecompleto, ' +
    ' c.hor_descricao, ' + ' c.hor_qtd_aula, ' + ' e.cur_nome, ' +
    ' f.dis_descricao ' + '  from professor_horario a ' +
    ' inner join pessoas b on a.pfh_professor = b.pes_cpfcnpj ' +
    ' inner join horarios c on a.pfh_horario = c.hor_codigo ' +
    ' inner join grade_curricular d on a.pfh_grade = d.grc_id ' +
    ' inner join cursos e on d.grc_curso = e.cur_codigo ' +
    ' inner join disciplinas f on d.grc_disciplina = f.dis_codigo ';

  C_SQL_LISTACHAMADA = ' select a.acg_academico, a.acg_grade, c.pes_nomecompleto, ''P'' as fqa_presencafalta, ''0'' as IDCHAMADA '+
    ' from academico_grade a ' +
    ' inner join grade_curricular b on a.acg_grade = b.grc_id ' +
    ' inner join pessoas c on a.acg_academico = c.pes_cpfcnpj ' +
    ' inner join disciplinas e on b.grc_disciplina = e.dis_codigo ' +
    ' inner join cursos f on b.grc_curso = f.cur_codigo ' +
    ' inner join series g on b.grc_serie = g.ser_ano ' +
    ' inner join data_vigencia d on b.grc_datavigencia = d.dvg_id ';

var
    PROFESSOR : String;
    DIA_SEMANA: Integer;
    HORARIO: Integer;
    QTDAULA: Integer;
    ANOLETIVO: Integer;
    strTeste: String;
    STRNOME: STRING;
    boolChamadaRealizada: Boolean;
    datadachamada: TDateTime;

implementation

end.
