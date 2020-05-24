unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, IniFiles,
  Vcl.Dialogs, Vcl.Forms, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexaoBanco = class(TDataModule)
    fdcConexaoBancoFB: TFDConnection;
    fdtTransacao: TFDTransaction;
    qryAux: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procConexaoBancoFirebird;
  public
    { Public declarations }
  end;

var
  dmConexaoBanco: TdmConexaoBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmConexaoBanco }

procedure TdmConexaoBanco.DataModuleCreate(Sender: TObject);
begin
  procConexaoBancoFirebird;
end;

procedure TdmConexaoBanco.procConexaoBancoFirebird;
var
  arq: TIniFile;
  c_CaminhoSistema: string;
  c_DataBase: string;
  c_Server: string;
  c_Port: string;
  c_UserName: string;
  c_Password: string;
begin
  c_CaminhoSistema := ExtractFilePath(Application.ExeName);
  arq := TIniFile.Create(c_CaminhoSistema + 'config.ini');
  c_DataBase := arq.ReadString('SecessionDatabase', 'Database', '');
  c_Server := arq.ReadString('SecessionServer', 'Server', '');
  c_Port := arq.ReadString('SecessionPort', 'Port', '');
  c_UserName := arq.ReadString('SecessionUserName', 'UserName', '');
  c_Password := arq.ReadString('SecessionPassword', 'Password', '');
  try
    fdcConexaoBancoFB.Connected := False; // fecha a conexão com o banco
    fdcConexaoBancoFB.Params.Clear; // limpa os parametros
    fdcConexaoBancoFB.DriverName := 'FB';
    fdcConexaoBancoFB.Params.Add('Database=' + c_DataBase);
    fdcConexaoBancoFB.Params.Add('Server=' + c_Server);
    fdcConexaoBancoFB.Params.Add('Port=' + c_Port);
    fdcConexaoBancoFB.Params.Add('user_name=' + c_UserName);
    fdcConexaoBancoFB.Params.Add('password=' + c_Password);
    fdcConexaoBancoFB.Connected := True; // abre a conexão com o banco
    fdcConexaoBancoFB.Open;
  except
    on E: Exception do
    begin
      ShowMessage
        ('Ocorreu um problema ao realizar a conexão com o Banco de Dados' +
        sLineBreak + E.Message);
      Application.Terminate;
    end;
  end;
end;

end.
