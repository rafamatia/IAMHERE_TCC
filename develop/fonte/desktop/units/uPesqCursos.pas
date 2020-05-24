unit uPesqCursos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqCursos = class(TpPesqPadrao)
    procedure FormShow(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edDadosChange(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectCursos;
  public
    { Public declarations }
  end;

var
  frmPesqCursos: TfrmPesqCursos;

implementation

{$R *.dfm}

uses dmCursos, constantes, utilidades, uCadCursos;

{ TfrmPesqCursos }

procedure TfrmPesqCursos.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectCursos;
end;

procedure TfrmPesqCursos.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelectCursos;
end;

procedure TfrmPesqCursos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2:
      sbNovoClick(Sender);
    VK_F3:
      sbAlterarClick(Sender);
    VK_F4:
      sbExcluirClick(Sender);
  end;
end;

procedure TfrmPesqCursos.FormShow(Sender: TObject);
begin
  inherited;
  procSelectCursos;
end;

procedure TfrmPesqCursos.procSelectCursos;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmCurso.qryCursos.Close;
  dmCurso.qryCursos.SQL.Text := C_SQL_CURSOS;
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
      c_where := C_WHERE_SIMPLES + ' A.CUR_CODIGO = :CODIGO ';
      dmCurso.qryCursos.SQL.Text := dmCurso.qryCursos.SQL.Text + c_where;
      dmCurso.qryCursos.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { DESCRIÇÃO }
    Begin
      c_where := C_WHERE_SIMPLES + ' A.CUR_NOME LIKE :DESCRICAO ';
      dmCurso.qryCursos.SQL.Text := dmCurso.qryCursos.SQL.Text + c_where;
      dmCurso.qryCursos.ParamByName('DESCRICAO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmCurso.qryCursos.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqCursos.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectCursos;
end;

procedure TfrmPesqCursos.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectCursos;
end;

procedure TfrmPesqCursos.sbAlterarClick(Sender: TObject);
var
  i_Id: integer;
begin
  inherited;
  if ((not(dmCurso.qryCursos.Active)) or
    (dmCurso.qryCursos.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadCursos := TfrmCadCursos.Create(Self);
  try
    i_Id := dmCurso.qryCursosCUR_CODIGO.AsInteger;
    dmCurso.qryCursos.Edit;
    frmCadCursos.ShowModal;
  finally
    FreeAndNil(frmCadCursos);
    procSelectCursos;
    dmCurso.qryCursos.Locate('CUR_CODIGO', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqCursos.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmCurso.qryCursos.Active)) then
    dmCurso.qryCursos.Open;

  frmCadCursos := TfrmCadCursos.Create(Self);
  try
    dmCurso.qryCursos.Insert;
    frmCadCursos.ShowModal;
  finally
    FreeAndNil(frmCadCursos);
    procSelectCursos;
  end;
end;

end.
