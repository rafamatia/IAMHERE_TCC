unit uCadSeries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadSeries = class(TcManuPadrao)
    Label1: TLabel;
    DBE_SER_ANO: TDBEdit;
    Label2: TLabel;
    DBE_SER_DESCRICAO: TDBEdit;
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
  frmCadSeries: TfrmCadSeries;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, utilidades;

procedure TfrmCadSeries.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      sbGravarClick(Sender);
  end;
end;

procedure TfrmCadSeries.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_SER_DESCRICAO, False, True);
  procSetaCorCampo(DBE_SER_ANO, False, True);

  if (dmTabAuxiliares.qrySeries.State in [dsInsert]) then
    procSetaFoco(DBE_SER_ANO)
  else if (dmTabAuxiliares.qrySeries.State in [dsEdit]) then
  begin
    procSetaCorCampo(DBE_SER_ANO, True, False);
    procSetaFoco(DBE_SER_DESCRICAO);
  end;
end;

procedure TfrmCadSeries.sbCancelarClick(Sender: TObject);
begin
  try
    dmTabAuxiliares.qrySeries.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadSeries.sbGravarClick(Sender: TObject);
var
  i_Ano: Integer;
begin
  try
    i_Ano := StrToInt(DBE_SER_ANO.Text);
  except
    on E: Exception do
    begin
      procMensagem('Campo "Ano" inválido! Verifique e tente novamente!', 'A');
      procSetaFoco(DBE_SER_ANO);
      Exit;
    end;
  end;

  if dmTabAuxiliares.funcSerieJaExiste(i_Ano) then
  begin
    procMensagem
      ('Já existe uma série cadastrada com este ano, verifique e tente novamente!',
      'A');
    procSetaFoco(DBE_SER_ANO);
    Abort;
  end;

  Panel1.SetFocus;
  procValidaCampoRequirido(DBE_SER_ANO);
  procValidaCampoRequirido(DBE_SER_DESCRICAO);

  if ((dmTabAuxiliares.qrySeriesSER_ANO.IsNull) or
    (dmTabAuxiliares.qrySeriesSER_ANO.AsString = EmptyStr)) then
  begin
    procMensagem('O campo "Ano" não pode ser nulo!', 'A');
    procSetaFoco(DBE_SER_ANO);
    Abort;
  end;

  if (dmTabAuxiliares.qrySeriesSER_ANO.AsInteger = 0) then
  begin
    procMensagem
      ('O campo "Ano" não pode receber o valor "0", tente novamente!', 'A');
    procSetaFoco(DBE_SER_ANO);
    Abort;
  end;

  try
    if (dmTabAuxiliares.qrySeries.State in [dsInsert, dsEdit]) then
    begin
      dmTabAuxiliares.qrySeries.Post;
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
end;

end.
