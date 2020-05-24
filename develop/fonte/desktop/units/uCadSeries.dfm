inherited frmCadSeries: TfrmCadSeries
  Caption = 'M004 - Manuten'#231#245'es de S'#233'ries'
  ClientHeight = 110
  ClientWidth = 519
  OnShow = FormShow
  ExplicitWidth = 535
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 519
    Height = 69
    ExplicitWidth = 519
    ExplicitHeight = 69
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 19
      Height = 13
      Caption = 'Ano'
      FocusControl = DBE_SER_ANO
    end
    object Label2: TLabel
      Left = 115
      Top = 19
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_SER_DESCRICAO
    end
    object DBE_SER_ANO: TDBEdit
      Left = 8
      Top = 35
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'SER_ANO'
      DataSource = dmTabAuxiliares.dqrySeries
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
    object DBE_SER_DESCRICAO: TDBEdit
      Left = 115
      Top = 35
      Width = 394
      Height = 21
      CharCase = ecUpperCase
      DataField = 'SER_DESCRICAO'
      DataSource = dmTabAuxiliares.dqrySeries
      TabOrder = 1
      StyleElements = [seFont, seBorder]
    end
  end
  inherited Panel1: TPanel
    Top = 69
    Width = 519
    ExplicitTop = 69
    ExplicitWidth = 519
  end
end
