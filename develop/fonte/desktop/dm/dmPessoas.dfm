object dmPessoa: TdmPessoa
  OldCreateOrder = False
  Height = 279
  Width = 364
  object qryPessoas: TFDQuery
    CachedUpdates = True
    Connection = dmConexaoBanco.fdcConexaoBancoFB
    UpdateOptions.AssignedValues = [uvRefreshMode]
    UpdateOptions.RefreshMode = rmAll
    SQL.Strings = (
      'select a.* from pessoas a')
    Left = 120
    Top = 24
    object qryPessoasPES_CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'PES_CODIGO'
      Origin = 'PES_CODIGO'
      Required = True
    end
    object qryPessoasPES_TIPOPESSOA: TStringField
      DisplayLabel = 'F'#237'sica / Jur'#237'dica'
      FieldName = 'PES_TIPOPESSOA'
      Origin = 'PES_TIPOPESSOA'
      Required = True
      OnGetText = qryPessoasPES_TIPOPESSOAGetText
      Size = 1
    end
    object qryPessoasPES_CPFCNPJ: TStringField
      DisplayLabel = 'CPF / CNPJ'
      FieldName = 'PES_CPFCNPJ'
      Origin = 'PES_CPFCNPJ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPessoasPES_NOMECOMPLETO: TStringField
      DisplayLabel = 'Nome Completo'
      FieldName = 'PES_NOMECOMPLETO'
      Origin = 'PES_NOMECOMPLETO'
      Required = True
      Size = 60
    end
    object qryPessoasPES_GENERO: TStringField
      DisplayLabel = 'G'#234'nero'
      FieldName = 'PES_GENERO'
      Origin = 'PES_GENERO'
      Required = True
      OnGetText = qryPessoasPES_GENEROGetText
      Size = 1
    end
    object qryPessoasPES_DATANASCIMENTO: TDateField
      DisplayLabel = 'Dt. Nascimento'
      FieldName = 'PES_DATANASCIMENTO'
      Origin = 'PES_DATANASCIMENTO'
    end
    object qryPessoasPES_TIPO: TStringField
      DisplayLabel = 'Tipo de Cadastro'
      FieldName = 'PES_TIPO'
      Origin = 'PES_TIPO'
      Required = True
      OnGetText = qryPessoasPES_TIPOGetText
      Size = 1
    end
  end
  object dqryPessoas: TDataSource
    DataSet = qryPessoas
    Left = 120
    Top = 80
  end
end
