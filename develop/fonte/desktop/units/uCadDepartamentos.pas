unit uCadDepartamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadDepartamentos = class(TcManuPadrao)
    Label1: TLabel;
    DBE_DEP_CODIGO: TDBEdit;
    Label2: TLabel;
    DBE_DEP_DESCRICAO: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDepartamentos: TfrmCadDepartamentos;

implementation

{$R *.dfm}

uses dmCursos, utilidades;

procedure TfrmCadDepartamentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      sbGravarClick(Sender);
  end;
end;

procedure TfrmCadDepartamentos.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_DEP_CODIGO, True, False);
  procSetaCorCampo(DBE_DEP_DESCRICAO, False, True);
  procSetaFoco(DBE_DEP_DESCRICAO);
end;

procedure TfrmCadDepartamentos.sbCancelarClick(Sender: TObject);
begin
  try
    dmCurso.qryDepartamentos.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadDepartamentos.sbGravarClick(Sender: TObject);
begin
  Panel1.SetFocus;
  procValidaCampoRequirido(DBE_DEP_DESCRICAO);

  try
    if (dmCurso.qryDepartamentos.State in [dsInsert, dsEdit]) then
    begin
      dmCurso.qryDepartamentos.Post;
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
