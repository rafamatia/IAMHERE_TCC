unit uPesqHorarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqHorarios = class(TpPesqPadrao)
    procedure FormShow(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edDadosChange(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectHorarios;
  public
    { Public declarations }
  end;

var
  frmPesqHorarios: TfrmPesqHorarios;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, constantes, utilidades, uCadHorarios;

{ TfrmPesqHorarios }

procedure TfrmPesqHorarios.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectHorarios;
end;

procedure TfrmPesqHorarios.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelectHorarios;
end;

procedure TfrmPesqHorarios.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPesqHorarios.FormShow(Sender: TObject);
begin
  inherited;
  procSelectHorarios;
end;

procedure TfrmPesqHorarios.procSelectHorarios;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmTabAuxiliares.qryHorarios.Close;
  dmTabAuxiliares.qryHorarios.SQL.Text := C_SQL_HORARIOS;
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
      c_where := C_WHERE_SIMPLES + ' A.HOR_CODIGO = :CODIGO ';
      dmTabAuxiliares.qryHorarios.SQL.Text :=
        dmTabAuxiliares.qryHorarios.SQL.Text + c_where;
      dmTabAuxiliares.qryHorarios.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { DESCRIÇÃO }
    Begin
      c_where := C_WHERE_SIMPLES + ' A.HOR_DESCRICAO LIKE :DESCRICAO ';
      dmTabAuxiliares.qryHorarios.SQL.Text :=
        dmTabAuxiliares.qryHorarios.SQL.Text + c_where;
      dmTabAuxiliares.qryHorarios.ParamByName('DESCRICAO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmTabAuxiliares.qryHorarios.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqHorarios.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectHorarios;
end;

procedure TfrmPesqHorarios.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectHorarios;
end;

procedure TfrmPesqHorarios.sbAlterarClick(Sender: TObject);
var
  i_Id: Integer;
begin
  inherited;
  if ((not(dmTabAuxiliares.qryHorarios.Active)) or
    (dmTabAuxiliares.qryHorarios.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadHorarios := TfrmCadHorarios.Create(Self);
  try
    i_Id := dmTabAuxiliares.qryHorariosHOR_CODIGO.AsInteger;
    dmTabAuxiliares.qryHorarios.Edit;
    frmCadHorarios.ShowModal;
  finally
    FreeAndNil(frmCadHorarios);
    procSelectHorarios;
    dmTabAuxiliares.qryHorarios.Locate('HOR_CODIGO', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqHorarios.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmTabAuxiliares.qryHorarios.Active)) then
    dmTabAuxiliares.qryHorarios.Open;

  frmCadHorarios := TfrmCadHorarios.Create(Self);
  try
    dmTabAuxiliares.qryHorarios.Insert;
    frmCadHorarios.ShowModal;
  finally
    FreeAndNil(frmCadHorarios);
    procSelectHorarios;
  end;
end;

end.
