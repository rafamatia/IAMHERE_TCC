inherited frmCadHorarios: TfrmCadHorarios
  Caption = 'M005 - Manuten'#231#245'es dos Hor'#225'rios'
  ClientHeight = 151
  ClientWidth = 602
  OnShow = FormShow
  ExplicitWidth = 618
  ExplicitHeight = 190
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 602
    Height = 110
    ExplicitWidth = 602
    ExplicitHeight = 110
    object Label1: TLabel
      Left = 8
      Top = 18
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBE_HOR_CODIGO
    end
    object Label2: TLabel
      Left = 114
      Top = 18
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_HOR_DESCRICAO
    end
    object Label3: TLabel
      Left = 8
      Top = 61
      Width = 46
      Height = 13
      Caption = 'Qtd. Aula'
      FocusControl = DBE_HOR_QTD_AULA
    end
    object Label4: TLabel
      Left = 114
      Top = 61
      Width = 71
      Height = 13
      Caption = 'Ordem da Aula'
      FocusControl = DBE_HOR_ORDEM_AULA
    end
    object Label5: TLabel
      Left = 220
      Top = 61
      Width = 117
      Height = 13
      Caption = 'Hor'#225'rio de In'#237'cio da Aula'
    end
    object Label6: TLabel
      Left = 346
      Top = 61
      Width = 108
      Height = 13
      Caption = 'Hor'#225'rio de Fim da Aula'
    end
    object Label7: TLabel
      Left = 472
      Top = 61
      Width = 79
      Height = 13
      Caption = 'Dura'#231#227'o da Aula'
    end
    object DBE_HOR_CODIGO: TDBEdit
      Left = 8
      Top = 34
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'HOR_CODIGO'
      DataSource = dmTabAuxiliares.dqryHorarios
      TabOrder = 0
    end
    object DBE_HOR_DESCRICAO: TDBEdit
      Left = 114
      Top = 34
      Width = 478
      Height = 21
      CharCase = ecUpperCase
      DataField = 'HOR_DESCRICAO'
      DataSource = dmTabAuxiliares.dqryHorarios
      TabOrder = 1
    end
    object DBE_HOR_QTD_AULA: TDBEdit
      Left = 8
      Top = 77
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'HOR_QTD_AULA'
      DataSource = dmTabAuxiliares.dqryHorarios
      TabOrder = 2
    end
    object DBE_HOR_ORDEM_AULA: TDBEdit
      Left = 114
      Top = 77
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'HOR_ORDEM_AULA'
      DataSource = dmTabAuxiliares.dqryHorarios
      TabOrder = 3
    end
    object meHrInicioAula: TMaskEdit
      Left = 220
      Top = 77
      Width = 120
      Height = 21
      CharCase = ecUpperCase
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 4
      Text = '  :  :  '
      OnExit = meHrInicioAulaExit
    end
    object meHrFimAula: TMaskEdit
      Left = 346
      Top = 77
      Width = 120
      Height = 21
      CharCase = ecUpperCase
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 5
      Text = '  :  :  '
      OnExit = meHrFimAulaExit
    end
    object meHrDuracaoAula: TMaskEdit
      Left = 472
      Top = 77
      Width = 120
      Height = 21
      CharCase = ecUpperCase
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 6
      Text = '  :  :  '
    end
  end
  inherited Panel1: TPanel
    Top = 110
    Width = 602
    ExplicitTop = 110
    ExplicitWidth = 602
  end
end
