inherited frmCadDataVigencia: TfrmCadDataVigencia
  BorderIcons = [biSystemMenu]
  Caption = 'M001 - Manuten'#231#245'es de Data de Vig'#234'ncia'
  ClientHeight = 120
  ClientWidth = 345
  OnShow = FormShow
  ExplicitWidth = 361
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 345
    Height = 79
    ExplicitWidth = 345
    ExplicitHeight = 79
    object Label1: TLabel
      Left = 27
      Top = 22
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBE_DVG_ID
    end
    object Label2: TLabel
      Left = 133
      Top = 22
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label3: TLabel
      Left = 229
      Top = 22
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object DBE_DVG_ID: TDBEdit
      Left = 27
      Top = 38
      Width = 100
      Height = 21
      DataField = 'DVG_ID'
      DataSource = dmTabAuxiliares.dqryDataVigencia
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
    object meDtInicial: TMaskEdit
      Left = 133
      Top = 38
      Width = 90
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      StyleElements = [seFont, seBorder]
    end
    object meDtFinal: TMaskEdit
      Left = 228
      Top = 38
      Width = 90
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      StyleElements = [seFont, seBorder]
    end
  end
  inherited Panel1: TPanel
    Top = 79
    Width = 345
    ExplicitTop = 79
    ExplicitWidth = 345
  end
end
