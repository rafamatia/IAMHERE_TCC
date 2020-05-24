unit uCadCursos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  Vcl.Mask;

type
  TfrmCadCursos = class(TcManuPadrao)
    pnlCabecalhoCurso: TPanel;
    gbGradeCurricular: TGroupBox;
    pnlBotoesGradeCurso: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DBE_CUR_CODIGO: TDBEdit;
    Label2: TLabel;
    DBE_CUR_NOME: TDBEdit;
    Label3: TLabel;
    DBE_CUR_DURACAO: TDBEdit;
    DBR_CUR_TIPO_DURACAO: TDBRadioGroup;
    Label4: TLabel;
    DBE_CUR_DEPARTAMENTO: TDBEdit;
    edtDescDepartamento: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBE_CUR_CARGAHORARIA: TDBEdit;
    DBR_CUR_PERIODO: TDBRadioGroup;
    DBR_CUR_NIVEL: TDBRadioGroup;
    sbNovo: TSpeedButton;
    sbAlterar: TSpeedButton;
    sbExcluir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure DBE_CUR_DEPARTAMENTOExit(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCursos: TfrmCadCursos;

implementation

{$R *.dfm}

uses dmCursos, utilidades, uCadGradeCurricular, uPesqDepartamentos, dmConexao;

procedure TfrmCadCursos.DBE_CUR_DEPARTAMENTOExit(Sender: TObject);
var
  c_DescDepartamento: String;
begin
  inherited;
  c_DescDepartamento := dmCurso.funcExisteDepartamento
    (StrToIntDef(DBE_CUR_DEPARTAMENTO.Text, 0));
  if (c_DescDepartamento = EmptyStr) then
  begin
    frmPesqDepartamentos := TfrmPesqDepartamentos.Create(Self);
    try
      frmPesqDepartamentos.b_SomenteConsulta := True;
      frmPesqDepartamentos.ShowModal;
    finally
      if dmCurso.qryDepartamentos.IsEmpty then
      begin
        edtDescDepartamento.Clear;
        DBE_CUR_DEPARTAMENTO.Clear;
      end
      else
      begin
        edtDescDepartamento.Text :=
          dmCurso.qryDepartamentosDEP_DESCRICAO.AsString;
        DBE_CUR_DEPARTAMENTO.Text :=
          dmCurso.qryDepartamentosDEP_CODIGO.AsString;
      end;
      FreeAndNil(frmPesqDepartamentos);
      DBE_CUR_DEPARTAMENTOExit(Sender)
    end;
  end
  else
  begin
    edtDescDepartamento.Text := c_DescDepartamento;
  end;

  if (edtDescDepartamento.Text = EmptyStr) then
    DBE_CUR_DEPARTAMENTO.Clear;

  procSetaFoco(DBE_CUR_CARGAHORARIA);
end;

procedure TfrmCadCursos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  dmConexaoBanco.fdtTransacao.Options.AutoCommit := True;
  dmConexaoBanco.fdtTransacao.Options.AutoStart := True;
  dmConexaoBanco.fdtTransacao.Options.AutoStop := True;
end;

procedure TfrmCadCursos.FormCreate(Sender: TObject);
begin
  inherited;
  dmConexaoBanco.fdtTransacao.Options.AutoCommit := False;
  dmConexaoBanco.fdtTransacao.Options.AutoStart := True;
  dmConexaoBanco.fdtTransacao.Options.AutoStop := False;
end;

procedure TfrmCadCursos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2:
      sbNovoClick(Sender);
    VK_F3:
      sbAlterarClick(Sender);
    VK_F5:
      sbGravarClick(Sender);
  end;
  inherited;
end;

procedure TfrmCadCursos.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_CUR_CODIGO, True, False);
  procSetaCorCampoEdit(edtDescDepartamento, True, False);
  procSetaCorCampo(DBE_CUR_NOME, False, True);
  procSetaCorCampo(DBE_CUR_DURACAO, False, True);
  procSetaCorCampo(DBE_CUR_DEPARTAMENTO, False, True);
  procSetaCorCampo(DBE_CUR_CARGAHORARIA, False, True);

  edtDescDepartamento.Clear;

  if (dmCurso.qryCursos.State in [dsEdit]) then
    DBE_CUR_DEPARTAMENTOExit(Sender);

  procSetaFoco(DBE_CUR_NOME);
  dmCurso.procSelectGradeCurricular(dmCurso.qryCursosCUR_CODIGO.AsInteger);
end;

procedure TfrmCadCursos.sbAlterarClick(Sender: TObject);
begin
  if (DBE_CUR_NOME.Text = EmptyStr) then
  begin
    procMensagem
      ('Descrição do Curso inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_NOME);
    Abort;
  end;

  if ((edtDescDepartamento.Text = EmptyStr) or
    (DBE_CUR_DEPARTAMENTO.Text = EmptyStr)) then
  begin
    procMensagem('Departamento inválido, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DEPARTAMENTO);
    Abort;
  end;

  if (DBE_CUR_CARGAHORARIA.Text = EmptyStr) then
  begin
    procMensagem('Carga Horária inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_CARGAHORARIA);
    Abort;
  end;

  if (DBE_CUR_DURACAO.Text = EmptyStr) then
  begin
    procMensagem('Duração inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DURACAO);
    Abort;
  end;

  frmCadGradeCurricular := TfrmCadGradeCurricular.Create(Self);
  try
    dmCurso.qryGradeCurricular.Edit;
    frmCadGradeCurricular.ShowModal;
  finally
    FreeAndNil(frmCadGradeCurricular);
  end;
end;

procedure TfrmCadCursos.sbCancelarClick(Sender: TObject);
begin
  if (dmCurso.qryGradeCurricular.ChangeCount > 0) then
    dmCurso.qryGradeCurricular.CancelUpdates;
  dmCurso.qryCursos.CancelUpdates;
  inherited;
end;

procedure TfrmCadCursos.sbGravarClick(Sender: TObject);
begin
  inherited;
  if (DBE_CUR_NOME.Text = EmptyStr) then
  begin
    procMensagem
      ('Descrição do Curso inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_NOME);
    Abort;
  end;

  if ((edtDescDepartamento.Text = EmptyStr) or
    (DBE_CUR_DEPARTAMENTO.Text = EmptyStr)) then
  begin
    procMensagem('Departamento inválido, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DEPARTAMENTO);
    Abort;
  end;

  if (DBE_CUR_CARGAHORARIA.Text = EmptyStr) then
  begin
    procMensagem('Carga Horária inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_CARGAHORARIA);
    Abort;
  end;

  if (DBE_CUR_DURACAO.Text = EmptyStr) then
  begin
    procMensagem('Duração inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DURACAO);
    Abort;
  end;

  try
    dmCurso.qryCursos.Post;
    if (dmCurso.qryCursos.ChangeCount > 0) then
      dmCurso.qryCursos.ApplyUpdates(0);

    if (dmCurso.qryGradeCurricular.ChangeCount > 0) then
      dmCurso.qryGradeCurricular.ApplyUpdates(0);

    Close;
  except
    on E: Exception do
  end;
end;

procedure TfrmCadCursos.sbNovoClick(Sender: TObject);
begin
  if (DBE_CUR_NOME.Text = EmptyStr) then
  begin
    procMensagem
      ('Descrição do Curso inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_NOME);
    Abort;
  end;

  if ((edtDescDepartamento.Text = EmptyStr) or
    (DBE_CUR_DEPARTAMENTO.Text = EmptyStr)) then
  begin
    procMensagem('Departamento inválido, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DEPARTAMENTO);
    Abort;
  end;

  if (DBE_CUR_CARGAHORARIA.Text = EmptyStr) then
  begin
    procMensagem('Carga Horária inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_CARGAHORARIA);
    Abort;
  end;

  if (DBE_CUR_DURACAO.Text = EmptyStr) then
  begin
    procMensagem('Duração inválida, verifique e tente novamente!', 'A');
    procSetaFoco(DBE_CUR_DURACAO);
    Abort;
  end;

  frmCadGradeCurricular := TfrmCadGradeCurricular.Create(Self);
  try
    dmCurso.qryGradeCurricular.Insert;
    frmCadGradeCurricular.ShowModal;
  finally
    FreeAndNil(frmCadGradeCurricular);
  end;
end;

end.
