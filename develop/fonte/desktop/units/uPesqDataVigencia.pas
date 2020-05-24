unit uPesqDataVigencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqDataVigencia = class(TpPesqPadrao)
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure edDadosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procSelecionar;
  public
    { Public declarations }
    b_SomenteConsulta: Boolean;
  end;

var
  frmPesqDataVigencia: TfrmPesqDataVigencia;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, constantes, utilidades, uCadDataVigencia;

{ TfrmPesqDataVigencia }

procedure TfrmPesqDataVigencia.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelecionar;
end;

procedure TfrmPesqDataVigencia.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    procSelecionar;
end;

procedure TfrmPesqDataVigencia.FormCreate(Sender: TObject);
begin
  inherited;
  b_SomenteConsulta := False;
end;

procedure TfrmPesqDataVigencia.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPesqDataVigencia.FormShow(Sender: TObject);
begin
  inherited;
  procSelecionar;
  sbNovo.Visible := (not(b_SomenteConsulta));
  sbAlterar.Visible := (not(b_SomenteConsulta));
  sbExcluir.Visible := (not(b_SomenteConsulta));
end;

procedure TfrmPesqDataVigencia.procSelecionar;
var
  c_Filtro: string;
  i_codigo: integer;
begin
  dmTabAuxiliares.qryDataVigencia.Close;
  dmTabAuxiliares.qryDataVigencia.SQL.Clear;
  dmTabAuxiliares.qryDataVigencia.SQL.Text := C_SQL_DATAVIGENCIA;

  if ((edDados.Text <> EmptyStr) and (rbCodigo.Checked)) then
  begin
    try
      if edDados.Text <> EmptyStr then
        i_codigo := StrToInt(edDados.Text);
    except
      i_codigo := 0;
    end;

    c_Filtro := 'A.DVG_ID = :CODIGO';

    dmTabAuxiliares.qryDataVigencia.SQL.Text := C_SQL_DATAVIGENCIA +
      C_WHERE_SIMPLES + c_Filtro;
    dmTabAuxiliares.qryDataVigencia.ParamByName('CODIGO').AsInteger := i_codigo;
  end;

  dmTabAuxiliares.qryDataVigencia.Open;
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqDataVigencia.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelecionar;
end;

procedure TfrmPesqDataVigencia.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelecionar;
end;

procedure TfrmPesqDataVigencia.sbAlterarClick(Sender: TObject);
var
  i_Id: integer;
begin
  inherited;
  if ((not(dmTabAuxiliares.qryDataVigencia.Active)) or
    (dmTabAuxiliares.qryDataVigencia.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadDataVigencia := TfrmCadDataVigencia.Create(Self);
  try
    i_Id := dmTabAuxiliares.qryDataVigenciaDVG_ID.AsInteger;
    dmTabAuxiliares.qryDataVigencia.Edit;
    frmCadDataVigencia.ShowModal;
  finally
    FreeAndNil(frmCadDataVigencia);
    procSelecionar;
    dmTabAuxiliares.qryDataVigencia.Locate('DVG_ID', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqDataVigencia.sbExcluirClick(Sender: TObject);
begin
  if ((not(dmTabAuxiliares.qryDataVigencia.Active)) or
    (dmTabAuxiliares.qryDataVigencia.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser excluído.');
    Abort;
  end;

  if (dmTabAuxiliares.qryDataVigencia.Active) then
  begin
    if dmTabAuxiliares.funcDataVigenciaEstaSendoUsada
      (dmTabAuxiliares.qryDataVigenciaDVG_ID.AsInteger) then
    begin
      procMensagem('Não é possível excluir este registro.' + sLineBreak +
        'Este registro contém vínculo com outras tabelas.');
      Abort;
    end;

    try
      dmTabAuxiliares.qryDataVigencia.Delete;
      procMensagem('Registro Excluído com Sucesso!');
    except
      on E: Exception do
      begin
        raise Exception.Create('Error Message');
      end;
    end;
  end;
end;

procedure TfrmPesqDataVigencia.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmTabAuxiliares.qryDataVigencia.Active)) then
    dmTabAuxiliares.qryDataVigencia.Open;

  frmCadDataVigencia := TfrmCadDataVigencia.Create(Self);
  try
    dmTabAuxiliares.qryDataVigencia.Insert;
    frmCadDataVigencia.ShowModal;
  finally
    FreeAndNil(frmCadDataVigencia);
    procSelecionar;
  end;
end;

end.
