inherited frmCadDepartamentos: TfrmCadDepartamentos
  BorderIcons = [biSystemMenu]
  Caption = 'M002 - Manuten'#231#245'es de Departamentos'
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
    ExplicitWidth = 625
    ExplicitHeight = 72
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBE_DEP_CODIGO
    end
    object Label2: TLabel
      Left = 114
      Top = 21
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DEP_DESCRICAO
    end
    object DBE_DEP_CODIGO: TDBEdit
      Left = 8
      Top = 37
      Width = 100
      Height = 21
      CharCase = ecUpperCase
      DataField = 'DEP_CODIGO'
      DataSource = dmCurso.dqryDepartamentos
      TabOrder = 0
    end
    object DBE_DEP_DESCRICAO: TDBEdit
      Left = 114
      Top = 37
      Width = 500
      Height = 21
      CharCase = ecUpperCase
      DataField = 'DEP_DESCRICAO'
      DataSource = dmCurso.dqryDepartamentos
      TabOrder = 1
    end
  end
  inherited Panel1: TPanel
    Top = 72
    Width = 625
    ExplicitTop = 72
    ExplicitWidth = 625
  end
end
