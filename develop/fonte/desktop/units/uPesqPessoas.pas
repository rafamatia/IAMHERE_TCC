unit uPesqPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqPessoas = class(TpPesqPadrao)
    procedure edDadosChange(Sender: TObject);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure procSelectPessoas;
  public
    { Public declarations }
  end;

var
  frmPesqPessoas: TfrmPesqPessoas;

implementation

{$R *.dfm}

uses dmPessoas, constantes, utilidades;

{ TfrmPesqPessoas }

procedure TfrmPesqPessoas.edDadosChange(Sender: TObject);
begin
  inherited;
  if (Trim(edDados.Text) = EmptyStr) then
    procSelectPessoas;
end;

procedure TfrmPesqPessoas.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelectPessoas;
end;

procedure TfrmPesqPessoas.FormShow(Sender: TObject);
begin
  inherited;
  procSelectPessoas;
end;

procedure TfrmPesqPessoas.procSelectPessoas;
Var
  c_where: String;
  i_codigo: Integer;
begin
  { -------------------------------------------------
    FECHA A QRY E ATRIBUI O NOVO SELECT
    ------------------------------------------------- }
  dmPessoa.qryPessoas.Close;
  dmPessoa.qryPessoas.SQL.Clear;
  dmPessoa.qryPessoas.SQL.Text := C_SQL_PESSOAS;
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
      c_where := C_WHERE_SIMPLES + ' A.PES_CODIGO = :CODIGO ';
      dmPessoa.qryPessoas.SQL.Text := dmPessoa.qryPessoas.SQL.Text + c_where;
      dmPessoa.qryPessoas.ParamByName('CODIGO').AsInteger := i_codigo;
    End
    else { NOME DA PESSOA }
    Begin
      c_where := C_WHERE_SIMPLES +
        ' A.PES_NOMECOMPLETO LIKE :PES_NOMECOMPLETO ';
      dmPessoa.qryPessoas.SQL.Text := dmPessoa.qryPessoas.SQL.Text + c_where;
      dmPessoa.qryPessoas.ParamByName('PES_NOMECOMPLETO').AsString :=
        '%' + edDados.Text + '%';
    End;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmPessoa.qryPessoas.Open;
  { --------------------- }
  procSetaFocoEdit(edDados);
end;

procedure TfrmPesqPessoas.rbCodigoClick(Sender: TObject);
begin
  inherited;
  procSelectPessoas;
end;

procedure TfrmPesqPessoas.rbDescricaoClick(Sender: TObject);
begin
  inherited;
  procSelectPessoas;
end;

end.
