object dmConexaoBanco: TdmConexaoBanco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 145
  Width = 407
  object fdcConexaoBancoFB: TFDConnection
    Params.Strings = (
      'Protocol=TCPIP'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\iamhere\BANCO.FDB'
      'Server=52.14.49.72'
      'Port=3050'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode, evAutoClose, evAutoFetchAll]
    FetchOptions.Mode = fmAll
    UpdateOptions.AssignedValues = [uvRefreshMode, uvAutoCommitUpdates]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.AutoCommitUpdates = True
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object fdtTransacao: TFDTransaction
    Connection = fdcConexaoBancoFB
    Left = 64
    Top = 80
  end
  object qryAux: TFDQuery
    Connection = fdcConexaoBancoFB
    SQL.Strings = (
      'select a.* from pessoas a')
    Left = 232
    Top = 41
  end
end
