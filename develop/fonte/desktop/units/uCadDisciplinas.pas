unit uCadDisciplinas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadDisciplinas = class(TcManuPadrao)
    Label1: TLabel;
    DBE_DIS_CODIGO: TDBEdit;
    Label2: TLabel;
    DBE_DIS_DESCRICAO: TDBEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDisciplinas: TfrmCadDisciplinas;

implementation

{$R *.dfm}

uses dmCursos, utilidades;

procedure TfrmCadDisciplinas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      sbGravarClick(Sender);
  end;
end;

procedure TfrmCadDisciplinas.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_DIS_CODIGO, True, False);
  procSetaCorCampo(DBE_DIS_DESCRICAO, False, True);
  procSetaFoco(DBE_DIS_DESCRICAO);
end;

procedure TfrmCadDisciplinas.sbCancelarClick(Sender: TObject);
begin
  try
    dmCurso.qryDisciplinas.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadDisciplinas.sbGravarClick(Sender: TObject);
begin
  Panel1.SetFocus;
  procValidaCampoRequirido(DBE_DIS_DESCRICAO);

  try
    if (dmCurso.qryDisciplinas.State in [dsInsert, dsEdit]) then
    begin
      dmCurso.qryDisciplinas.Post;
      procMensagem('Registro Salvo com Sucesso!');
      Close;
    end
    else
      procMensagem
        ('Não foi possível gravar este registro! Entre em contato o suporte técnico!',
        'E');
  except
    on E: Exception do
    begin
      procMensagem
        ('Não foi possível gravar este registro! Entre em contato o suporte técnico!'
        + sLineBreak + E.Message, 'E');
      Exit;
    end;
  end;
  inherited;
end;

end.
