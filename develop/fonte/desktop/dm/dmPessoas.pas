unit dmPessoas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmPessoa = class(TDataModule)
    qryPessoas: TFDQuery;
    dqryPessoas: TDataSource;
    qryPessoasPES_CODIGO: TIntegerField;
    qryPessoasPES_CPFCNPJ: TStringField;
    qryPessoasPES_GENERO: TStringField;
    qryPessoasPES_DATANASCIMENTO: TDateField;
    qryPessoasPES_TIPOPESSOA: TStringField;
    qryPessoasPES_NOMECOMPLETO: TStringField;
    qryPessoasPES_TIPO: TStringField;
    procedure qryPessoasPES_TIPOPESSOAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryPessoasPES_GENEROGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryPessoasPES_TIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

    { =========================================================================== }
    // ROTINA QUE VERIFICA SE A PESSOA EXISTE (PELO CPF/CNPJ)
    function funcPessoaEstaCadastrada(c_cpf_cnpj: String; out c_nome: String)
      : Boolean; overload;

    function funcPessoaEstaCadastrada(c_cpf_cnpj: String): Boolean; overload;
    { =========================================================================== }
  end;

var
  dmPessoa: TdmPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmConexao, tipos;

{$R *.dfm}

function TdmPessoa.funcPessoaEstaCadastrada(c_cpf_cnpj: String): Boolean;
var
   strNome : String;
begin
   Result := funcPessoaEstaCadastrada(c_cpf_cnpj, strNome);
end;

function TdmPessoa.funcPessoaEstaCadastrada(c_cpf_cnpj: String;
  out c_nome: String): Boolean;
begin
  Result := False;
  c_nome := EmptyStr;

  if (c_cpf_cnpj <> EmptyStr) then
  begin
    dmConexaoBanco.qryAux.Close;
    dmConexaoBanco.qryAux.SQL.Clear;
    dmConexaoBanco.qryAux.SQL.Text := ' SELECT A.PES_NOMECOMPLETO ' +
      '   FROM PESSOAS A ' + '  WHERE A.PES_CPFCNPJ = :PES_CPFCNPJ ';
    dmConexaoBanco.qryAux.ParamByName('PES_CPFCNPJ').AsString := c_cpf_cnpj;
    dmConexaoBanco.qryAux.Open;

    Result := (not(dmConexaoBanco.qryAux.IsEmpty));
    if Result then
      c_nome := dmConexaoBanco.qryAux.FieldByName('PES_NOMECOMPLETO').AsString;
  end;
end;

procedure TdmPessoa.qryPessoasPES_GENEROGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := EmptyStr
  else if (Sender.AsString = C_TP_GEN_FEMININO) then
    Text := 'FEMININO'
  else if (Sender.AsString = C_TP_GEN_MASCULINO) then
    Text := 'MASCULINO'
  else if (Sender.AsString = C_TP_GEN_OUTROS) then
    Text := 'OUTRO';
end;

procedure TdmPessoa.qryPessoasPES_TIPOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := EmptyStr
  else if (Sender.AsString = C_TP_PES_ALUNO) then
    Text := C_TP_PES_ALUNO_DESC
  else if (Sender.AsString = C_TP_PES_PROFESSOR) then
    Text := C_TP_PES_PROFESSOR_DESC
  else if (Sender.AsString = C_TP_PES_CLIENTES) then
    Text := C_TP_PES_CLIENTES_DESC
  else if (Sender.AsString = C_TP_PES_FUNCIONARIOS) then
    Text := C_TP_PES_FUNCIONARIOS_DESC
  else if (Sender.AsString = C_TP_PES_FORNECEDORES) then
    Text := C_TP_PES_FORNECEDORES_DESC
  else if (Sender.AsString = C_TP_PES_SISTEMA) then
    Text := C_TP_PES_SISTEMA_DESC
  else if (Sender.AsString = C_TP_PES_TRANSPORTADORA) then
    Text := C_TP_PES_TRANSPORTADORA_DESC;
end;

procedure TdmPessoa.qryPessoasPES_TIPOPESSOAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := EmptyStr
  else if (Sender.AsString = C_TP_PES_FISICA) then
    Text := 'FÍSICA'
  else if (Sender.AsString = C_TP_PES_JURIDICA) then
    Text := 'JURÍDICA';
end;

end.
