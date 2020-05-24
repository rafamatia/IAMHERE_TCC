inherited frmPesqDataVigencia: TfrmPesqDataVigencia
  Caption = 'P001 - Pequisa Data de Vig'#234'ncia'
  ClientHeight = 411
  ClientWidth = 484
  OnShow = FormShow
  ExplicitWidth = 500
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Width = 484
    Height = 258
    Caption = 'Listagem de Datas de Vig'#234'ncia'
    ExplicitWidth = 484
    ExplicitHeight = 258
    inherited gPadrao: TDBGrid
      Width = 480
      Height = 241
      DataSource = dmTabAuxiliares.dqryDataVigencia
      Columns = <
        item
          Expanded = False
          FieldName = 'DVG_ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DVG_DT_INICIO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DVG_DT_FIM'
          Visible = True
        end>
    end
  end
  inherited gbCamposConsulta: TGroupBox
    Top = 299
    Width = 484
    ExplicitTop = 299
    ExplicitWidth = 484
    inherited edDados: TEdit
      Width = 478
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
      ExplicitWidth = 478
    end
  end
  inherited Panel1: TPanel
    Top = 370
    Width = 484
    ExplicitTop = 370
    ExplicitWidth = 484
    inherited sb_Sair: TSpeedButton
      Left = 389
      ExplicitLeft = 386
    end
  end
  inherited paOpcoesConsulta: TPanel
    Width = 484
    ExplicitWidth = 484
    inherited gbOpcConsulta: TGroupBox
      Width = 276
      ExplicitWidth = 276
      inherited rbDescricao: TRadioButton
        Visible = False
      end
    end
    inherited gbStatus: TGroupBox
      Left = 276
      Visible = False
      ExplicitLeft = 276
    end
  end
end
