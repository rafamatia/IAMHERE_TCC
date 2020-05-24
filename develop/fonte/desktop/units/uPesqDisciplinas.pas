unit uPesqDisciplinas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqDisciplinas = class(TpPesqPadrao)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure edDadosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectDisciplinas;
  public
    { Public declarations }
    b_SomenteConsulta: Boolean;
  end;

var
  frmPesqDisciplinas: TfrmPesqDisciplinas;

implementation

{$R *.dfm}

uses dmCursos, constantes, uCadDisciplinas, Ufuncoes, utilidades;

procedure TfrmPesqDisciplinas.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectDisciplinas;
end;

procedure TfrmPesqDisciplinas.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelectDisciplinas;
end;

procedure TfrmPesqDisciplinas.FormCreate(Sender: TObject);
begin
  inherited;
  b_SomenteConsulta := False;
end;

procedure TfrmPesqDisciplinas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPesqDisciplinas.FormShow(Sender: TObject);
begin
  inherited;
  procSelectDisciplinas;

  sbNovo.Visible := (not(b_SomenteConsulta));
  sbAlterar.Visible := (not(b_SomenteConsulta));
  sbExcluir.Visible := (not(b_SomenteConsulta));
end;

procedure TfrmPesqDisciplinas.procSelectDisciplinas;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmCurso.qryDisciplinas.Close;
  dmCurso.qryDisciplinas.SQL.Text := C_SQL_DISCIPLINAS;
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
      c_where := C_WHERE_SIMPLES + ' A.DIS_CODIGO = :CODIGO ';
      dmCurso.qryDisciplinas.SQL.Text := dmCurso.qryDisciplinas.SQL.Text
        + c_where;
      dmCurso.qryDisciplinas.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { DESCRIÇÃO }
    Begin
      c_where := C_WHERE_SIMPLES + ' A.DIS_DESCRICAO LIKE :DESCRICAO ';
      dmCurso.qryDisciplinas.SQL.Text := dmCurso.qryDisciplinas.SQL.Text
        + c_where;
      dmCurso.qryDisciplinas.ParamByName('DESCRICAO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmCurso.qryDisciplinas.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqDisciplinas.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectDisciplinas;
end;

procedure TfrmPesqDisciplinas.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectDisciplinas;
end;

procedure TfrmPesqDisciplinas.sbAlterarClick(Sender: TObject);
var
  i_Id: Integer;
begin
  inherited;
  if ((not(dmCurso.qryDisciplinas.Active)) or (dmCurso.qryDisciplinas.IsEmpty))
  then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadDisciplinas := TfrmCadDisciplinas.Create(Self);
  try
    i_Id := dmCurso.qryDisciplinasDIS_CODIGO.AsInteger;
    dmCurso.qryDisciplinas.Edit;
    frmCadDisciplinas.ShowModal;
  finally
    FreeAndNil(frmCadDisciplinas);
    procSelectDisciplinas;
    dmCurso.qryDisciplinas.Locate('DIS_CODIGO', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqDisciplinas.sbExcluirClick(Sender: TObject);
begin
  inherited;
  if ((not(dmCurso.qryDisciplinas.Active)) or (dmCurso.qryDisciplinas.IsEmpty))
  then
  begin
    procMensagem('Não existe registro para ser excluído.');
    Abort;
  end;

  if (dmCurso.qryDisciplinas.Active) then
  begin
    if dmCurso.funcDisciplinasEstaSendoUsada
      (dmCurso.qryDisciplinasDIS_CODIGO.AsInteger) then
    begin
      procMensagem('Não é possível excluir este registro.' + sLineBreak +
        'Este registro contém vínculo com outras tabelas.');
      Abort;
    end;

    try
      dmCurso.qryDisciplinas.Delete;
      procMensagem('Registro Excluído com Sucesso!');
    except
      on E: Exception do
      begin
        raise Exception.Create('Error Message');
      end;
    end;
  end;
end;

procedure TfrmPesqDisciplinas.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmCurso.qryDisciplinas.Active)) then
    dmCurso.qryDisciplinas.Open;

  frmCadDisciplinas := TfrmCadDisciplinas.Create(Self);
  try
    dmCurso.qryDisciplinas.Insert;
    frmCadDisciplinas.ShowModal;
  finally
    FreeAndNil(frmCadDisciplinas);
    procSelectDisciplinas;
  end;
end;

end.
