unit uPesqSeries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqSeries = class(TpPesqPadrao)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure edDadosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectSeries;
  public
    { Public declarations }
    b_SomenteConsulta: Boolean;
  end;

var
  frmPesqSeries: TfrmPesqSeries;

implementation

{$R *.dfm}

uses dmTabelasAuxiliares, constantes, utilidades, uCadSeries;

procedure TfrmPesqSeries.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectSeries;
end;

procedure TfrmPesqSeries.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelectSeries;
end;

procedure TfrmPesqSeries.FormCreate(Sender: TObject);
begin
  inherited;
  b_SomenteConsulta := False;
end;

procedure TfrmPesqSeries.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPesqSeries.FormShow(Sender: TObject);
begin
  inherited;
  procSelectSeries;
  sbNovo.Visible := (not(b_SomenteConsulta));
  sbAlterar.Visible := (not(b_SomenteConsulta));
  sbExcluir.Visible := (not(b_SomenteConsulta));
end;

procedure TfrmPesqSeries.procSelectSeries;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmTabAuxiliares.qrySeries.Close;
  dmTabAuxiliares.qrySeries.SQL.Text := C_SQL_SERIES;
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
      c_where := C_WHERE_SIMPLES + ' A.SER_ANO = :CODIGO ';
      dmTabAuxiliares.qrySeries.SQL.Text := dmTabAuxiliares.qrySeries.SQL.Text
        + c_where;
      dmTabAuxiliares.qrySeries.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { DESCRIÇÃO }
    Begin
      c_where := C_WHERE_SIMPLES + ' A.SER_DESCRICAO LIKE :DESCRICAO ';
      dmTabAuxiliares.qrySeries.SQL.Text := dmTabAuxiliares.qrySeries.SQL.Text
        + c_where;
      dmTabAuxiliares.qrySeries.ParamByName('DESCRICAO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmTabAuxiliares.qrySeries.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqSeries.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectSeries;
end;

procedure TfrmPesqSeries.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectSeries;
end;

procedure TfrmPesqSeries.sbAlterarClick(Sender: TObject);
var
  i_Id: Integer;
begin
  inherited;
  if ((not(dmTabAuxiliares.qrySeries.Active)) or
    (dmTabAuxiliares.qrySeries.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser alterado.');
    Abort;
  end;

  frmCadSeries := TfrmCadSeries.Create(Self);
  try
    i_Id := dmTabAuxiliares.qrySeriesSER_ANO.AsInteger;
    dmTabAuxiliares.qrySeries.Edit;
    frmCadSeries.ShowModal;
  finally
    FreeAndNil(frmCadSeries);
    procSelectSeries;
    dmTabAuxiliares.qrySeries.Locate('SER_ANO', VarArrayOf([i_Id]), []);
  end;
end;

procedure TfrmPesqSeries.sbExcluirClick(Sender: TObject);
begin
  inherited;
  if ((not(dmTabAuxiliares.qrySeries.Active)) or
    (dmTabAuxiliares.qrySeries.IsEmpty)) then
  begin
    procMensagem('Não existe registro para ser excluído.');
    Abort;
  end;

  if (dmTabAuxiliares.qrySeries.Active) then
  begin
    if dmTabAuxiliares.funcSeriesEstaSendoUsado
      (dmTabAuxiliares.qrySeriesSER_ANO.AsInteger) then
    begin
      procMensagem('Não é possível excluir este registro.' + sLineBreak +
        'Este registro contém vínculo com outras tabelas.');
      Abort;
    end;

    try
      dmTabAuxiliares.qrySeries.Delete;
      procMensagem('Registro Excluído com Sucesso!');
    except
      on E: Exception do
      begin
        raise Exception.Create('Error Message');
      end;
    end;
  end;
end;

procedure TfrmPesqSeries.sbNovoClick(Sender: TObject);
begin
  inherited;
  if (not(dmTabAuxiliares.qrySeries.Active)) then
    dmTabAuxiliares.qrySeries.Open;

  frmCadSeries := TfrmCadSeries.Create(Self);
  try
    dmTabAuxiliares.qrySeries.Insert;
    frmCadSeries.ShowModal;
  finally
    FreeAndNil(frmCadSeries);
    procSelectSeries;
  end;
end;

end.
