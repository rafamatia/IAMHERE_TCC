object dmCurso: TdmCurso
  OldCreateOrder = False
  Height = 234
  Width = 531
  object qryDepartamentos: TFDQuery
    AfterInsert = qryDepartamentosAfterInsert
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'select a.*'
      ' from departamentos a')
    Left = 48
    Top = 24
    object qryDepartamentosDEP_CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'DEP_CODIGO'
      Origin = 'DEP_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDepartamentosDEP_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DEP_DESCRICAO'
      Origin = 'DEP_DESCRICAO'
      Required = True
      Size = 200
    end
  end
  object dqryDepartamentos: TDataSource
    DataSet = qryDepartamentos
    Left = 48
    Top = 80
  end
  object qryDisciplinas: TFDQuery
    AfterInsert = qryDisciplinasAfterInsert
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'select a.*'
      ' from disciplinas a')
    Left = 160
    Top = 24
    object qryDisciplinasDIS_CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'DIS_CODIGO'
      Origin = 'DIS_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDisciplinasDIS_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DIS_DESCRICAO'
      Origin = 'DIS_DESCRICAO'
      Required = True
      Size = 200
    end
  end
  object dqryDisciplinas: TDataSource
    DataSet = qryDisciplinas
    Left = 160
    Top = 80
  end
  object qryCursos: TFDQuery
    AfterInsert = qryCursosAfterInsert
    CachedUpdates = True
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    UpdateOptions.AssignedValues = [uvRefreshMode]
    UpdateOptions.RefreshMode = rmAll
    SQL.Strings = (
      'select a.*,'
      '       b.dep_descricao'
      ' from cursos a'
      ' inner join departamentos b on a.cur_departamento = b.dep_codigo')
    Left = 264
    Top = 24
    object qryCursosCUR_CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CUR_CODIGO'
      Origin = 'CUR_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCursosCUR_NOME: TStringField
      DisplayLabel = 'Descri'#231#227'o do Curso'
      FieldName = 'CUR_NOME'
      Origin = 'CUR_NOME'
      Required = True
      Size = 200
    end
    object qryCursosCUR_DURACAO: TIntegerField
      DisplayLabel = 'Dura'#231#227'o'
      FieldName = 'CUR_DURACAO'
      Origin = 'CUR_DURACAO'
      Required = True
    end
    object qryCursosCUR_TIPO_DURACAO: TStringField
      DisplayLabel = 'Tipo Dura'#231#227'o'
      FieldName = 'CUR_TIPO_DURACAO'
      Origin = 'CUR_TIPO_DURACAO'
      Required = True
      Size = 1
    end
    object qryCursosCUR_PERIODO: TStringField
      DisplayLabel = 'Per'#237'odo'
      FieldName = 'CUR_PERIODO'
      Origin = 'CUR_PERIODO'
      Required = True
      Size = 1
    end
    object qryCursosCUR_NIVEL: TStringField
      DisplayLabel = 'N'#237'vel Escolar'
      FieldName = 'CUR_NIVEL'
      Origin = 'CUR_NIVEL'
      Required = True
      Size = 1
    end
    object qryCursosCUR_CARGAHORARIA: TIntegerField
      DisplayLabel = 'Carga Hor'#225'ria'
      FieldName = 'CUR_CARGAHORARIA'
      Origin = 'CUR_CARGAHORARIA'
      Required = True
    end
    object qryCursosCUR_DEPARTAMENTO: TIntegerField
      DisplayLabel = 'C'#243'd. Departamento'
      FieldName = 'CUR_DEPARTAMENTO'
      Origin = 'CUR_DEPARTAMENTO'
      Required = True
    end
    object qryCursosDEP_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Desc. Departamento'
      FieldName = 'DEP_DESCRICAO'
      Origin = 'DEP_DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object dqryCursos: TDataSource
    DataSet = qryCursos
    Left = 264
    Top = 80
  end
  object qryGradeCurricular: TFDQuery
    AfterInsert = qryGradeCurricularAfterInsert
    CachedUpdates = True
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'select a.*,'
      '       c.dis_descricao,'
      '       d.ser_descricao,'
      '       e.dvg_dt_inicio,'
      '       e.dvg_dt_fim'
      '  from grade_curricular a'
      ' inner join cursos b on b.cur_codigo = a.grc_curso'
      ' inner join disciplinas c on c.dis_codigo = a.grc_disciplina'
      ' inner join series d on d.ser_ano = a.grc_serie'
      ' inner join data_vigencia e on e.dvg_id = a.grc_datavigencia')
    Left = 360
    Top = 24
    object qryGradeCurricularGRC_ID: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'GRC_ID'
      Origin = 'GRC_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryGradeCurricularGRC_CURSO: TIntegerField
      DisplayLabel = 'C'#243'd. Curso'
      FieldName = 'GRC_CURSO'
      Origin = 'GRC_CURSO'
      Required = True
    end
    object qryGradeCurricularGRC_DISCIPLINA: TIntegerField
      DisplayLabel = 'C'#243'd. Disciplina'
      FieldName = 'GRC_DISCIPLINA'
      Origin = 'GRC_DISCIPLINA'
      Required = True
    end
    object qryGradeCurricularGRC_SERIE: TIntegerField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'GRC_SERIE'
      Origin = 'GRC_SERIE'
      Required = True
    end
    object qryGradeCurricularGRC_DATAVIGENCIA: TIntegerField
      DisplayLabel = 'C'#243'd. Dt. Vig'#234'ncia'
      FieldName = 'GRC_DATAVIGENCIA'
      Origin = 'GRC_DATAVIGENCIA'
      Required = True
    end
    object qryGradeCurricularGRC_CARGAHORARIATOTAL: TIntegerField
      DisplayLabel = 'C.H. Total'
      FieldName = 'GRC_CARGAHORARIATOTAL'
      Origin = 'GRC_CARGAHORARIATOTAL'
      Required = True
    end
    object qryGradeCurricularGRC_CARGAHORARIASEMANAL: TIntegerField
      DisplayLabel = 'C.H. Semanal'
      FieldName = 'GRC_CARGAHORARIASEMANAL'
      Origin = 'GRC_CARGAHORARIASEMANAL'
      Required = True
    end
    object qryGradeCurricularDIS_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Desc. Disciplina'
      FieldName = 'DIS_DESCRICAO'
      Origin = 'DIS_DESCRICAO'
      ProviderFlags = []
      Size = 200
    end
    object qryGradeCurricularSER_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Desc. S'#233'rie'
      FieldName = 'SER_DESCRICAO'
      Origin = 'SER_DESCRICAO'
      ProviderFlags = []
      Size = 30
    end
    object qryGradeCurricularDVG_DT_INICIO: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Dt. Vig'#234'ncia Inical'
      FieldName = 'DVG_DT_INICIO'
      Origin = 'DVG_DT_INICIO'
      ProviderFlags = []
    end
    object qryGradeCurricularDVG_DT_FIM: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Dt. Vig'#234'ncia Final'
      FieldName = 'DVG_DT_FIM'
      Origin = 'DVG_DT_FIM'
      ProviderFlags = []
    end
  end
  object dqryGradeCurricular: TDataSource
    DataSet = qryGradeCurricular
    Left = 360
    Top = 80
  end
end
