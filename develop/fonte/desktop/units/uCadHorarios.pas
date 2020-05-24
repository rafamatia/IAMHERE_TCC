unit uCadHorarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadHorarios = class(TcManuPadrao)
    Label1: TLabel;
    DBE_HOR_CODIGO: TDBEdit;
    Label2: TLabel;
    DBE_HOR_DESCRICAO: TDBEdit;
    Label3: TLabel;
    DBE_HOR_QTD_AULA: TDBEdit;
    Label4: TLabel;
    DBE_HOR_ORDEM_AULA: TDBEdit;
    meHrInicioAula: TMaskEdit;
    meHrFimAula: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    meHrDuracaoAula: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure meHrInicioAulaExit(Sender: TObject);
    procedure meHrFimAulaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbCancelarClick(Sender: TObject);
  private
    { Private declarations }
    function funcValidarHorario: Boolean;
    function funcRetornaHrInicioAula: TDateTime;
    function funcRetornaHrFimAula: TDateTime;
  public
    { Public declarations }
  end;

var
  frmCadHorarios: TfrmCadHorarios;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, utilidades;

procedure TfrmCadHorarios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      sbGravarClick(Sender);
  end;
end;

procedure TfrmCadHorarios.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_HOR_CODIGO, True, False);
  procSetaCorCampoMaskEdit(meHrDuracaoAula, True, False);

  procSetaCorCampo(DBE_HOR_DESCRICAO, False, True);
  procSetaCorCampo(DBE_HOR_QTD_AULA, False, True);
  procSetaCorCampo(DBE_HOR_ORDEM_AULA, False, True);
  procSetaCorCampoMaskEdit(meHrInicioAula, False, True);
  procSetaCorCampoMaskEdit(meHrFimAula, False, True);
  procSetaFoco(DBE_HOR_DESCRICAO);

  if (dmTabAuxiliares.qryHorarios.State in [dsEdit]) then
  begin
    meHrInicioAula.Text :=
      TimeToStr(dmTabAuxiliares.qryHorariosHOR_HORA_INICIO.AsDateTime);
    meHrFimAula.Text :=
      TimeToStr(dmTabAuxiliares.qryHorariosHOR_HORA_FIM.AsDateTime);
    meHrDuracaoAula.Text :=
      TimeToStr(dmTabAuxiliares.qryHorariosHOR_DURACAO.AsDateTime);
  end
  else if (dmTabAuxiliares.qryHorarios.State in [dsInsert]) then
  begin
    meHrInicioAula.Text := '00:00:00';
    meHrFimAula.Text := '00:00:01';
    meHrDuracaoAula.Text := '00:00:01';
  end;
end;

function TfrmCadHorarios.funcRetornaHrFimAula: TDateTime;
begin
  try
    Result := StrToTime(meHrFimAula.Text);
  except
    on E: Exception do
    begin
      procMensagem
        ('Horário de Fim da Aula Inválido, verifique e tente novamente!', 'A');
      Result := 0;
    end;
  end;
end;

function TfrmCadHorarios.funcRetornaHrInicioAula: TDateTime;
begin
  try
    Result := StrToTime(meHrInicioAula.Text);
  except
    on E: Exception do
    begin
      procMensagem
        ('Horário de Início da Aula Inválido, verifique e tente novamente!',
        'A');
      Result := 0;
    end;
  end;
end;

function TfrmCadHorarios.funcValidarHorario: Boolean;
var
  t_HrInicioAula: TDateTime;
  t_HrFimAula: TDateTime;
  t_DuracaoAula: TDateTime;
begin
  Result := False;
  try
    t_HrInicioAula := funcRetornaHrInicioAula;
  except
    on E: Exception do
    begin
      procSetaFocoMaskEdit(meHrInicioAula);
      Exit;
    end;
  end;

  try
    t_HrFimAula := funcRetornaHrFimAula;
  except
    on E: Exception do
    begin
      procSetaFocoMaskEdit(meHrFimAula);
      Exit;
    end;
  end;

  if (t_HrInicioAula > t_HrFimAula) then
  begin
    procMensagem
      ('Horário de Início da Aula Inválido, verifique e tente novamente!', 'A');
    procSetaFocoMaskEdit(meHrInicioAula);
    Exit;
  end;

  if (t_HrFimAula < t_HrInicioAula) then
  begin
    procMensagem
      ('Horário de Fim da Aula Inválido, verifique e tente novamente!', 'A');
    procSetaFocoMaskEdit(meHrFimAula);
    Exit;
  end;

  try
    t_DuracaoAula := (t_HrInicioAula - t_HrFimAula);
    meHrDuracaoAula.Text := TimeToStr(t_DuracaoAula);
  except
    on E: Exception do
    begin
      procMensagem
        ('Horários de Aula Inválidos, verifique e tente novamente!', 'A');
      procSetaFocoMaskEdit(meHrInicioAula);
      Exit;
    end;
  end;
  Result := True;
end;

procedure TfrmCadHorarios.meHrFimAulaExit(Sender: TObject);
begin
  inherited;
  if (not(funcValidarHorario)) then
  begin
    procSetaFocoMaskEdit(meHrFimAula);
    Abort;
  end;
end;

procedure TfrmCadHorarios.meHrInicioAulaExit(Sender: TObject);
begin
  inherited;
  if (not(funcValidarHorario)) then
  begin
    procSetaFocoMaskEdit(meHrInicioAula);
    Abort;
  end;
end;

procedure TfrmCadHorarios.sbCancelarClick(Sender: TObject);
begin
  try
    dmTabAuxiliares.qryHorarios.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadHorarios.sbGravarClick(Sender: TObject);
var
  t_HrInicioAula: TDateTime;
  t_HrFimAula: TDateTime;
  t_DuracaoAula: TDateTime;
begin
  procValidaCampoRequirido(DBE_HOR_DESCRICAO);
  procValidaCampoRequirido(DBE_HOR_QTD_AULA);
  procValidaCampoRequirido(DBE_HOR_ORDEM_AULA);

  if (not(funcValidarHorario)) then
  begin
    procSetaFocoMaskEdit(meHrInicioAula);
    Abort;
  end;

  try
    t_HrInicioAula := funcRetornaHrInicioAula;
  except
    on E: Exception do
    begin
      procSetaFocoMaskEdit(meHrInicioAula);
      Exit;
    end;
  end;

  try
    t_HrFimAula := funcRetornaHrFimAula;
  except
    on E: Exception do
    begin
      procSetaFocoMaskEdit(meHrFimAula);
      Exit;
    end;
  end;

  try
    t_DuracaoAula := StrToTime(meHrDuracaoAula.Text);
  except
    on E: Exception do
    begin
      procMensagem
        ('Duração da Aula Inválida, verifique e tente novamente!', 'A');
      procSetaFocoMaskEdit(meHrInicioAula);
      Exit;
    end;
  end;

  t_DuracaoAula := (t_HrInicioAula - t_HrFimAula);
  if (t_DuracaoAula = 0) then
  begin
    procMensagem
      ('Horários de Aula Inválidos, verifique e tente novamente!', 'A');
    procSetaFocoMaskEdit(meHrInicioAula);
    Exit;
  end;

  Panel1.SetFocus;

  try
    if (dmTabAuxiliares.qryHorarios.State in [dsInsert, dsEdit]) then
    begin
      dmTabAuxiliares.qryHorariosHOR_HORA_INICIO.AsDateTime := t_HrInicioAula;
      dmTabAuxiliares.qryHorariosHOR_HORA_FIM.AsDateTime := t_HrFimAula;
      dmTabAuxiliares.qryHorariosHOR_DURACAO.AsDateTime := t_DuracaoAula;
      dmTabAuxiliares.qryHorarios.Post;
      if (dmTabAuxiliares.qryHorarios.ChangeCount > 0) then
        dmTabAuxiliares.qryHorarios.ApplyUpdates(0);

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
