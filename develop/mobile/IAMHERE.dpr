program IAMHERE;

uses
  System.StartUpCopy,
  FMX.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untCadModelo in 'untCadModelo.pas' {frmCadModelo},
  untDM in 'untDM.pas' {DM: TDataModule},
  untFrequenciaAcademicos in 'untFrequenciaAcademicos.pas' {frmFrequenciaAcademicos},
  uConstantes in 'comuns\uConstantes.pas',
  untLogin in 'untLogin.pas' {frmLogin},
  uFreqAcademicos in 'uFreqAcademicos.pas',
  uFreqAcademicosDAO in 'uFreqAcademicosDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmFrequenciaAcademicos, frmFrequenciaAcademicos);
  Application.Run;
end.
