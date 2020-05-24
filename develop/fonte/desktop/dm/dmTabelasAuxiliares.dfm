object dmTabAuxiliares: TdmTabAuxiliares
  OldCreateOrder = False
  Height = 367
  Width = 460
  object qryDataVigencia: TFDQuery
    AfterInsert = qryDataVigenciaAfterInsert
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'select * from data_vigencia')
    Left = 48
    Top = 24
    object qryDataVigenciaDVG_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'DVG_ID'
      Origin = 'DVG_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDataVigenciaDVG_DT_INICIO: TDateField
      DisplayLabel = 'Data Inicial'
      FieldName = 'DVG_DT_INICIO'
      Origin = 'DVG_DT_INICIO'
      Required = True
    end
    object qryDataVigenciaDVG_DT_FIM: TDateField
      DisplayLabel = 'Data Final'
      FieldName = 'DVG_DT_FIM'
      Origin = 'DVG_DT_FIM'
      Required = True
    end
  end
  object dqryDataVigencia: TDataSource
    DataSet = qryDataVigencia
    Left = 48
    Top = 80
  end
  object qrySeries: TFDQuery
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'select a.* from series a')
    Left = 144
    Top = 24
    object qrySeriesSER_ANO: TIntegerField
      DisplayLabel = 'Ano'
      FieldName = 'SER_ANO'
      Origin = 'SER_ANO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      OnValidate = qrySeriesSER_ANOValidate
    end
    object qrySeriesSER_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'SER_DESCRICAO'
      Origin = 'SER_DESCRICAO'
      Required = True
      Size = 30
    end
  end
  object dqrySeries: TDataSource
    DataSet = qrySeries
    Left = 144
    Top = 80
  end
  object qryHorarios: TFDQuery
    AfterInsert = qryHorariosAfterInsert
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    SQL.Strings = (
      'SELECT A.* FROM HORARIOS A')
    Left = 224
    Top = 24
    object qryHorariosHOR_CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'HOR_CODIGO'
      Origin = 'HOR_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryHorariosHOR_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'HOR_DESCRICAO'
      Origin = 'HOR_DESCRICAO'
      Required = True
      Size = 200
    end
    object qryHorariosHOR_QTD_AULA: TIntegerField
      DisplayLabel = 'Qtd. Aula'
      FieldName = 'HOR_QTD_AULA'
      Origin = 'HOR_QTD_AULA'
      Required = True
    end
    object qryHorariosHOR_ORDEM_AULA: TIntegerField
      DisplayLabel = 'Ordem da Aula'
      FieldName = 'HOR_ORDEM_AULA'
      Origin = 'HOR_ORDEM_AULA'
      Required = True
    end
    object qryHorariosHOR_HORA_INICIO: TTimeField
      DisplayLabel = 'Hor'#225'rio de In'#237'cio da Aula'
      FieldName = 'HOR_HORA_INICIO'
      Origin = 'HOR_HORA_INICIO'
      Required = True
    end
    object qryHorariosHOR_HORA_FIM: TTimeField
      DisplayLabel = 'Hor'#225'rio de Fim da Aula'
      FieldName = 'HOR_HORA_FIM'
      Origin = 'HOR_HORA_FIM'
      Required = True
    end
    object qryHorariosHOR_DURACAO: TTimeField
      DisplayLabel = 'Dura'#231#227'o da Aula'
      FieldName = 'HOR_DURACAO'
      Origin = 'HOR_DURACAO'
      Required = True
    end
  end
  object dqryHorarios: TDataSource
    DataSet = qryHorarios
    Left = 224
    Top = 80
  end
end
