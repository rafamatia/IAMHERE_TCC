inherited frmPesqDepartamentos: TfrmPesqDepartamentos
  Caption = 'P002 - Pesquisa dos Departamentos'
  ClientHeight = 481
  ClientWidth = 628
  OnShow = FormShow
  ExplicitWidth = 644
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Width = 628
    Height = 328
    Caption = 'Listagem de Departamentos'
    ExplicitWidth = 628
    ExplicitHeight = 328
    inherited gPadrao: TDBGrid
      Width = 624
      Height = 311
      DataSource = dmCurso.dqryDepartamentos
      Columns = <
        item
          Expanded = False
          FieldName = 'DEP_CODIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEP_DESCRICAO'
          Width = 500
          Visible = True
        end>
    end
  end
  inherited gbCamposConsulta: TGroupBox
    Top = 369
    Width = 628
    ExplicitTop = 369
    ExplicitWidth = 628
    inherited edDados: TEdit
      Width = 622
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
      ExplicitWidth = 622
    end
  end
  inherited Panel1: TPanel
    Top = 440
    Width = 628
    ExplicitTop = 440
    ExplicitWidth = 628
    inherited sb_Sair: TSpeedButton
      Left = 533
      ExplicitLeft = 533
    end
    inherited sbNovo: TSpeedButton
      ExplicitLeft = 2
    end
  end
  inherited paOpcoesConsulta: TPanel
    Width = 628
    ExplicitWidth = 628
    inherited gbOpcConsulta: TGroupBox
      Width = 420
      ExplicitWidth = 420
    end
    inherited gbStatus: TGroupBox
      Left = 420
      Visible = False
      ExplicitLeft = 420
    end
  end
end
