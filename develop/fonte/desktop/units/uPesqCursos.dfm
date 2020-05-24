inherited frmPesqCursos: TfrmPesqCursos
  Caption = 'P006 - Pesquisa dos Cursos'
  ClientHeight = 632
  ClientWidth = 1510
  WindowState = wsMaximized
  OnShow = FormShow
  ExplicitTop = -8
  ExplicitWidth = 1526
  ExplicitHeight = 671
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Width = 1510
    Height = 479
    inherited gPadrao: TDBGrid
      Width = 1506
      Height = 462
      DataSource = dmCurso.dqryCursos
      Columns = <
        item
          Expanded = False
          FieldName = 'CUR_CODIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_NOME'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_DURACAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_TIPO_DURACAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_PERIODO'
          Title.Caption = 'Turno'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_NIVEL'
          Title.Caption = 'Grau'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_CARGAHORARIA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUR_DEPARTAMENTO'
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
    Top = 520
    Width = 1510
    inherited edDados: TEdit
      Width = 1504
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
    end
  end
  inherited Panel1: TPanel
    Top = 591
    Width = 1510
    inherited sb_Sair: TSpeedButton
      Left = 1415
    end
  end
  inherited paOpcoesConsulta: TPanel
    Width = 1510
    inherited gbOpcConsulta: TGroupBox
      Width = 1302
    end
    inherited gbStatus: TGroupBox
      Left = 1302
      Visible = False
    end
  end
end
