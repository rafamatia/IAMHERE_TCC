unit uCadDataVigencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadDataVigencia = class(TcManuPadrao)
    Label1: TLabel;
    DBE_DVG_ID: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    meDtInicial: TMaskEdit;
    meDtFinal: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDataVigencia: TfrmCadDataVigencia;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, utilidades;

procedure TfrmCadDataVigencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      sbGravarClick(Sender);
  end;
end;

procedure TfrmCadDataVigencia.FormShow(Sender: TObject);
begin
  inherited;
  meDtInicial.Text := DateToStr(Date);
  meDtFinal.Text := DateToStr(Date);
  procSetaCorCampo(DBE_DVG_ID, True, False);
  procSetaCorCampoMaskEdit(meDtInicial, False, True);
  procSetaCorCampoMaskEdit(meDtFinal, False, True);
  procSetaFocoMaskEdit(meDtInicial);
  if (dmTabAuxiliares.qryDataVigencia.State in [dsEdit]) then
  begin
    meDtInicial.Text :=
      DateToStr(dmTabAuxiliares.qryDataVigenciaDVG_DT_INICIO.AsDateTime);
    meDtFinal.Text :=
      DateToStr(dmTabAuxiliares.qryDataVigenciaDVG_DT_FIM.AsDateTime);
  end;
end;

procedure TfrmCadDataVigencia.sbCancelarClick(Sender: TObject);
begin
  try
    dmTabAuxiliares.qryDataVigencia.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadDataVigencia.sbGravarClick(Sender: TObject);
var
  d_DtInicial: TDateTime;
  d_DtFinal: TDateTime;
begin
  try
    d_DtInicial := StrToDateTime(meDtInicial.Text);
  except
    on E: Exception do
    begin
      procMensagem('Data Inicial Inválida, verifique e tente novamente!', 'A');
      Exit;
    end;
  end;

  try
    d_DtFinal := StrToDateTime(meDtFinal.Text);
  except
    on E: Exception do
    begin
      procMensagem('Data Inicial Inválida, verifique e tente novamente!', 'A');
      Exit;
    end;
  end;

  if (d_DtInicial > d_DtFinal) then
  begin
    procMensagem('Data Inicial Inválida, verifique e tente novamente!', 'A');
    Abort;
  end;

  if (dmTabAuxiliares.funcValidaDataVigenciaExistente(d_DtInicial, d_DtFinal))
  then
  begin
    procMensagem
      ('Já existe um registro com estes dados, verifique e tente novamente!',
      'A');
    Abort;
  end;

  try
    if (dmTabAuxiliares.qryDataVigencia.State in [dsInsert, dsEdit]) then
    begin
      dmTabAuxiliares.qryDataVigenciaDVG_DT_INICIO.AsDateTime := d_DtInicial;
      dmTabAuxiliares.qryDataVigenciaDVG_DT_FIM.AsDateTime := d_DtFinal;
      dmTabAuxiliares.qryDataVigencia.Post;
      if (dmTabAuxiliares.qryDataVigencia.ChangeCount > 0) then
        dmTabAuxiliares.qryDataVigencia.ApplyUpdates(0);

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
