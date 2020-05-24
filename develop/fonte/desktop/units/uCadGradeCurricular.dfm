inherited frmCadGradeCurricular: TfrmCadGradeCurricular
  Caption = 'M007 - Manuten'#231#227'o das Grades Curriculares'
  ClientHeight = 222
  ClientWidth = 899
  OnShow = FormShow
  ExplicitWidth = 915
  ExplicitHeight = 261
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 899
    Height = 181
    ExplicitWidth = 899
    ExplicitHeight = 181
    object Label1: TLabel
      Left = 9
      Top = 20
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBE_GRC_ID
    end
    object DBE_GRC_ID: TDBEdit
      Left = 9
      Top = 36
      Width = 108
      Height = 21
      CharCase = ecUpperCase
      DataField = 'GRC_ID'
      DataSource = dmCurso.dqryGradeCurricular
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
    object GroupBox1: TGroupBox
      Left = 359
      Top = 119
      Width = 291
      Height = 52
      Caption = 'Data de Vig'#234'ncia'
      TabOrder = 1
      object DBE_GRC_DATAVIGENCIA: TDBEdit
        Left = 7
        Top = 20
        Width = 100
        Height = 21
        CharCase = ecUpperCase
        DataField = 'GRC_DATAVIGENCIA'
        DataSource = dmCurso.dqryGradeCurricular
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        OnExit = DBE_GRC_DATAVIGENCIAExit
      end
      object edtDtInicio: TEdit
        Left = 111
        Top = 20
        Width = 85
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        Text = '99/99/9999'
        StyleElements = [seFont, seBorder]
      end
      object edtDtFim: TEdit
        Left = 200
        Top = 20
        Width = 85
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
        Text = '99/99/9999'
        StyleElements = [seFont, seBorder]
      end
    end
    object GroupBox2: TGroupBox
      Left = 9
      Top = 63
      Width = 879
      Height = 50
      Caption = 'Disciplina'
      TabOrder = 2
      object DBE_GRC_DISCIPLINA: TDBEdit
        Left = 7
        Top = 18
        Width = 100
        Height = 21
        CharCase = ecUpperCase
        DataField = 'GRC_DISCIPLINA'
        DataSource = dmCurso.dqryGradeCurricular
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        OnExit = DBE_GRC_DISCIPLINAExit
      end
      object edtDescDisciplina: TEdit
        Left = 114
        Top = 18
        Width = 758
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        Text = 'EDTDESCDISCIPLINA'
        StyleElements = [seFont, seBorder]
      end
    end
    object GroupBox3: TGroupBox
      Left = 9
      Top = 119
      Width = 344
      Height = 52
      Caption = 'S'#233'rie'
      TabOrder = 3
      object DBE_GRC_SERIE: TDBEdit
        Left = 8
        Top = 20
        Width = 100
        Height = 21
        CharCase = ecUpperCase
        DataField = 'GRC_SERIE'
        DataSource = dmCurso.dqryGradeCurricular
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        OnExit = DBE_GRC_SERIEExit
      end
      object edtDescSerie: TEdit
        Left = 114
        Top = 20
        Width = 223
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        Text = 'EDTDESCSERIE'
        StyleElements = [seFont, seBorder]
      end
    end
    object GroupBox4: TGroupBox
      Left = 656
      Top = 119
      Width = 113
      Height = 52
      Caption = 'C.H. Semanal'
      TabOrder = 4
      object DBE_GRC_CARGAHORARIASEMANAL: TDBEdit
        Left = 6
        Top = 20
        Width = 100
        Height = 21
        CharCase = ecUpperCase
        DataField = 'GRC_CARGAHORARIASEMANAL'
        DataSource = dmCurso.dqryGradeCurricular
        TabOrder = 0
        StyleElements = [seFont, seBorder]
      end
    end
    object GroupBox5: TGroupBox
      Left = 775
      Top = 119
      Width = 113
      Height = 52
      Caption = 'C.H. Total'
      TabOrder = 5
      object DBE_GRC_CARGAHORARIATOTAL: TDBEdit
        Left = 7
        Top = 20
        Width = 100
        Height = 21
        CharCase = ecUpperCase
        DataField = 'GRC_CARGAHORARIATOTAL'
        DataSource = dmCurso.dqryGradeCurricular
        TabOrder = 0
        StyleElements = [seFont, seBorder]
      end
    end
  end
  inherited Panel1: TPanel
    Top = 181
    Width = 899
    ExplicitTop = 181
    ExplicitWidth = 899
  end
end
