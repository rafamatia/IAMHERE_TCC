inherited frmPesqPessoas: TfrmPesqPessoas
  Caption = 'P008 - Pesquisa de Pessoas'
  ClientHeight = 475
  ClientWidth = 1067
  OnShow = FormShow
  ExplicitWidth = 1083
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Width = 1067
    Height = 322
    ExplicitWidth = 844
    ExplicitHeight = 322
    inherited gPadrao: TDBGrid
      Width = 1063
      Height = 305
      DataSource = dmPessoa.dqryPessoas
      Columns = <
        item
          Expanded = False
          FieldName = 'PES_CODIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_TIPOPESSOA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_CPFCNPJ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_NOMECOMPLETO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_GENERO'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_TIPO'
          Width = 119
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PES_DATANASCIMENTO'
          Visible = True
        end>
    end
  end
  inherited gbCamposConsulta: TGroupBox
    Top = 363
    Width = 1067
    ExplicitTop = 363
    ExplicitWidth = 844
    inherited edDados: TEdit
      Top = 41
      Width = 1061
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
      ExplicitTop = 41
      ExplicitWidth = 838
    end
  end
  inherited Panel1: TPanel
    Top = 434
    Width = 1067
    ExplicitTop = 434
    ExplicitWidth = 844
    inherited sb_Sair: TSpeedButton
      Left = 972
      ExplicitLeft = 749
    end
  end
  inherited paOpcoesConsulta: TPanel
    Width = 1067
    ExplicitWidth = 844
    inherited gbOpcConsulta: TGroupBox
      Width = 859
      ExplicitWidth = 636
      inherited rbDescricao: TRadioButton
        Caption = 'Nome da Pessoa'
      end
    end
    inherited gbStatus: TGroupBox
      Left = 859
      Visible = False
      ExplicitLeft = 636
    end
  end
end
