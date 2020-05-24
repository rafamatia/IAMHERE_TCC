inherited frmCadDisciplinas: TfrmCadDisciplinas
  Caption = 'M003 - Manuten'#231#245'es de Disciplinas'
  ClientHeight = 113
  ClientWidth = 625
  OnShow = FormShow
  ExplicitWidth = 641
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 625
    Height = 72
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBE_DIS_CODIGO
    end
    object Label2: TLabel
      Left = 114
      Top = 22
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DIS_DESCRICAO
    end
    object DBE_DIS_CODIGO: TDBEdit
      Left = 8
      Top = 38
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'DIS_CODIGO'
      DataSource = dmCurso.dqryDisciplinas
      TabOrder = 0
    end
    object DBE_DIS_DESCRICAO: TDBEdit
      Left = 114
      Top = 38
      Width = 500
      Height = 21
      CharCase = ecUpperCase
      DataField = 'DIS_DESCRICAO'
      DataSource = dmCurso.dqryDisciplinas
      TabOrder = 1
    end
  end
  inherited Panel1: TPanel
    Top = 72
    Width = 625
  end
end
