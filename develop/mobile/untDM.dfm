object DM: TDM
  OldCreateOrder = False
  Height = 411
  Width = 519
  object fdcConexao: TFDConnection
    Params.Strings = (
      'Database=C:\TCC\develop\db\dbmobile.db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 80
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 176
    Top = 32
  end
  object qryDepartamentos: TFDQuery
    Connection = fdcConexao
    SQL.Strings = (
      'SELECT * FROM DEPARTAMENTOS')
    Left = 64
    Top = 128
    object qryDepartamentosDEP_CODIGO: TIntegerField
      FieldName = 'DEP_CODIGO'
      Origin = 'DEP_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDepartamentosDEP_DESCRICAO: TStringField
      FieldName = 'DEP_DESCRICAO'
      Origin = 'DEP_DESCRICAO'
      Required = True
      Size = 200
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 304
    Top = 32
  end
  object qryProfessorHorario: TFDQuery
    Connection = fdcConexao
    SQL.Strings = (
      'select a.*,'
      '       b.pes_nomecompleto,'
      '       c.hor_descricao,'
      '       c.hor_qtd_aula,'
      '       e.cur_nome,'
      '       f.dis_descricao'
      '  from PROFESSOR_HORARIO a'
      'inner join pessoas b on a.pfh_professor = b.pes_cpfcnpj'
      'inner join horarios c on a.pfh_horario = c.hor_codigo'
      'inner join grade_curricular d on a.pfh_grade = d.grc_id'
      'inner join cursos e on d.grc_curso = e.cur_codigo'
      'inner join disciplinas f on d.grc_disciplina = f.dis_codigo')
    Left = 64
    Top = 200
    object qryProfessorHorarioPFH_ID: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'PFH_ID'
      Origin = 'PFH_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryProfessorHorarioPFH_PROFESSOR: TStringField
      DisplayLabel = 'Professor'
      FieldName = 'PFH_PROFESSOR'
      Origin = 'PFH_PROFESSOR'
      Required = True
    end
    object qryProfessorHorarioPFH_GRADE: TIntegerField
      DisplayLabel = 'Grade Curricular'
      FieldName = 'PFH_GRADE'
      Origin = 'PFH_GRADE'
      Required = True
    end
    object qryProfessorHorarioPFH_HORARIO: TIntegerField
      DisplayLabel = 'Hor'#225'rio da Aula'
      FieldName = 'PFH_HORARIO'
      Origin = 'PFH_HORARIO'
      Required = True
    end
    object qryProfessorHorarioPFH_ANOLETIVO: TIntegerField
      DisplayLabel = 'Ano Letivo'
      FieldName = 'PFH_ANOLETIVO'
      Origin = 'PFH_ANOLETIVO'
      Required = True
    end
    object qryProfessorHorarioPFH_DIADASEMANA: TIntegerField
      DisplayLabel = 'Dia da Semana'
      FieldName = 'PFH_DIADASEMANA'
      Origin = 'PFH_DIADASEMANA'
      Required = True
    end
    object qryProfessorHorarioPES_NOMECOMPLETO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome do Professor'
      FieldName = 'PES_NOMECOMPLETO'
      Origin = 'PES_NOMECOMPLETO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryProfessorHorarioHOR_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Desc. Hor'#225'rio Aula'
      FieldName = 'HOR_DESCRICAO'
      Origin = 'HOR_DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object qryProfessorHorarioHOR_QTD_AULA: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Qtd. Aulas'
      FieldName = 'HOR_QTD_AULA'
      Origin = 'HOR_QTD_AULA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryProfessorHorarioCUR_NOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome do Curso'
      FieldName = 'CUR_NOME'
      Origin = 'CUR_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object qryProfessorHorarioDIS_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome da Disciplina'
      FieldName = 'DIS_DESCRICAO'
      Origin = 'DIS_DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object qryListaChamada: TFDQuery
    Connection = fdcConexao
    SQL.Strings = (
      
        'select a.acg_academico, a.acg_grade, c.pes_nomecompleto, '#39'P'#39' as ' +
        'FQA_PRESENCAFALTA, '#39'0'#39' as IDCHAMADA'
      'from academico_grade a'
      'inner join grade_curricular b on a.acg_grade = b.grc_id'
      'inner join pessoas c on a.acg_academico = c.pes_cpfcnpj'
      'inner join disciplinas e on b.grc_disciplina = e.dis_codigo'
      'inner join cursos f on b.grc_curso = f.cur_codigo'
      'inner join series g on b.grc_serie = g.ser_ano'
      'inner join data_vigencia d on b.grc_datavigencia = d.dvg_id')
    Left = 64
    Top = 272
    object qryListaChamadaPES_NOMECOMPLETO: TStringField
      FieldName = 'PES_NOMECOMPLETO'
      Origin = 'PES_NOMECOMPLETO'
      Required = True
      Size = 60
    end
    object qryListaChamadaACG_ACADEMICO: TStringField
      FieldName = 'ACG_ACADEMICO'
      Origin = 'ACG_ACADEMICO'
      Required = True
    end
    object qryListaChamadaACG_GRADE: TIntegerField
      FieldName = 'ACG_GRADE'
      Origin = 'ACG_GRADE'
      Required = True
    end
    object qryListaChamadaFQA_PRESENCAFALTA: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'FQA_PRESENCAFALTA'
      Origin = 'FQA_PRESENCAFALTA'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object qryListaChamadaIDCHAMADA: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'IDCHAMADA'
      Origin = 'IDCHAMADA'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
  end
  object qryChamada: TFDQuery
    Connection = fdcConexao
    Left = 240
    Top = 192
  end
  object qryAux: TFDQuery
    Connection = fdcConexao
    Left = 240
    Top = 248
  end
end
