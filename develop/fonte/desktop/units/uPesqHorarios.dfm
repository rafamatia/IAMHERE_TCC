inherited frmPesqHorarios: TfrmPesqHorarios
  Caption = 'P005 - Pesquisa dos Hor'#225'rios'
  ClientHeight = 615
  ClientWidth = 1070
  OnShow = FormShow
  ExplicitTop = -113
  ExplicitWidth = 1086
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Width = 1070
    Height = 462
    inherited gPadrao: TDBGrid
      Width = 1066
      Height = 445
      DataSource = dmTabAuxiliares.dqryHorarios
      Columns = <
        item
          Expanded = False
          FieldName = 'HOR_CODIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_DESCRICAO'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_QTD_AULA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_ORDEM_AULA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_HORA_INICIO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_HORA_FIM'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOR_DURACAO'
          Visible = True
        end>
    end
  end
  inherited gbCamposConsulta: TGroupBox
    Top = 503
    Width = 1070
    inherited edDados: TEdit
      Width = 1064
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
    end
  end
  inherited Panel1: TPanel
    Top = 574
    Width = 1070
    ExplicitTop = 366
    ExplicitWidth = 1070
    inherited sb_Sair: TSpeedButton
      Left = 975
    end
  end
  inherited paOpcoesConsulta: TPanel
    Width = 1070
    inherited gbOpcConsulta: TGroupBox
      Width = 862
    end
    inherited gbStatus: TGroupBox
      Left = 862
      Visible = False
    end
  end
end
