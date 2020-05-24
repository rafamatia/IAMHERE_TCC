unit uPesqDepartamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqDepartamentos = class(TpPesqPadrao)
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure edDadosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectDepartamentos;
  public
    { Public declarations }
    b_SomenteConsulta: Boolean;
  end;

var
  frmPesqDepartamentos: TfrmPesqDepartamentos;

implementation

{$R *.dfm}

uses dmCursos, constantes, utilidades, uCadDepartamentos;

{ TfrmPesqDepartamentos }

procedure TfrmPesqDepartamentos.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectDepartamentos;
end;

procedure TfrmPesqDepartamentos.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    procSelectDepartamentos;
end;

procedure TfrmPesqDepartamentos.FormCreate(Sender: TObject);
begin
  inherited;
  b_SomenteConsulta := False;
end;

procedure TfrmPesqDepartamentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2:
      if (not(b_SomenteConsulta)) then
        sbNovoClick(Sender);
    VK_F3:
      if (not(b_SomenteConsulta)) then
        sbAlterarClick(Sender);
    VK_F4:
      if (not(b_SomenteConsulta)) then
        sbExcluirClick(Sender);
  end;
end;

procedure TfrmPesqDepartamentos.FormShow(Sender: TObject);
begin
  inherited;
  procSelectDepartamentos;
  sbNovo.Visible := (not(b_SomenteConsulta));
  sbAlterar.Visible := (not(b_SomenteConsulta));
  sbExcluir.Visible := (not(b_SomenteConsulta));
end;

procedure TfrmPesqDepartamentos.procSelectDepartamentos;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmCurso.qryDepartamentos.Close;
  dmCurso.qryDepartamentos.SQL.Text := C_SQL_DEPARTAMENTOS;
  { ------------------------------------------------ }

  { -------------------------------------------------
    MONTA WHERE DAS OPÇÕES DE CONSULTA
    ------------------------------------------------- }
  if edDados.Text <> EmptyStr then
  Begin
    { CÓDIGO }
    if rbCodigo.Checked then
    Begin
      try
        if edDados.Text <> EmptyStr then
          i_codigo := StrToInt(edDados.Text);
      except
        i_codigo := 0;
      end;
      c_where := C_WHERE_SIMPLES + ' A.DEP_CODIGO = :CODIGO ';
      dmCurso.qryDepartamentos.SQL.Text := dmCurso.qryDepartamentos.SQL.Text
        + c_where;
      dmCurso.qryDepartamentos.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { DESCRIÇÃO }
    Begin
      c_where := C_WHERE_SIMPLES + ' A.DEP_DESCRICAO LIKE :DESCRICAO ';
      dmCurso.qryDepartamentos.SQL.Text := dmCurso.qryDepartamentos.SQL.Text
        + c_where;
      dmCurso.qryDepartamentos.ParamByName('DESCRICAO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmCurso.qryDepartamentos.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqDepartamentos.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectDepartamentos;
end;

procedure TfrmPesqDepartamentos.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectDepartamentos;
end;

procedure TfrmPesqDepartamentos.sbAlterarClick(Sender: TObject);
var
  i_Id: Integer;
begin
  inherited;
  if ((not(dmCurso.qryDepartamentos.Active)) or
    (dmCurso.qryDepartamentos.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadDepartamentos := TfrmCadDepartamentos.Create(Self);
  try
    i_Id := dmCurso.qryDepartamentosDEP_CODIGO.AsInteger;
    dmCurso.qryDepartamentos.Edit;
    frmCadDepartamentos.ShowModal;
  finally
    FreeAndNil(frmCadDepartamentos);
    procSelectDepartamentos;
    dmCurso.qryDepartamentos.Locate('DEP_CODIGO', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqDepartamentos.sbExcluirClick(Sender: TObject);
begin
  inherited;
  if ((not(dmCurso.qryDepartamentos.Active)) or
    (dmCurso.qryDepartamentos.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser excluído.');
    Abort;
  end;

  if (dmCurso.qryDepartamentos.Active) then
  begin
    if dmCurso.funcDepartamentoEstaSendoUsado
      (dmCurso.qryDepartamentosDEP_CODIGO.AsInteger) then
    begin
      procMensagem('Não é possível excluir este registro.' + sLineBreak +
        'Este registro contém vínculo com outras tabelas.');
      Abort;
    end;

    try
      dmCurso.qryDepartamentos.Delete;
      procMensagem('Registro Excluído com Sucesso!');
    except
      on E: Exception do
      begin
        raise Exception.Create('Error Message');
      end;
    end;
  end;
end;

procedure TfrmPesqDepartamentos.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmCurso.qryDepartamentos.Active)) then
    dmCurso.qryDepartamentos.Open;

  frmCadDepartamentos := TfrmCadDepartamentos.Create(Self);
  try
    dmCurso.qryDepartamentos.Insert;
    frmCadDepartamentos.ShowModal;
  finally
    FreeAndNil(frmCadDepartamentos);
    procSelectDepartamentos;
  end;
end;

end.
