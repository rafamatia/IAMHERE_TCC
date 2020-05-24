program ServidorIAMHERE;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  untMenuServidor in 'untMenuServidor.pas' {frmMenuServidor},
  untSrvMetodosGerais in 'untSrvMetodosGerais.pas' {svrMetodosGerais: TDSServerModule},
  untWM in 'untWM.pas' {wm: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmMenuServidor, frmMenuServidor);
  Application.Run;
end.
