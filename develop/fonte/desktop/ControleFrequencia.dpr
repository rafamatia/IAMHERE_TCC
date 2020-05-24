program ControleFrequencia;

uses
  Vcl.Forms,
  uMenuPrincipal in 'uMenuPrincipal.pas' {frmMenuPrincipal},
  constantes in 'comum\constantes.pas',
  tipos in 'comum\tipos.pas',
  UManutencaoPadrao in 'comum\UManutencaoPadrao.pas' {cManuPadrao},
  UPequisaPadrao in 'comum\UPequisaPadrao.pas' {pPesqPadrao},
  utilidades in 'comum\utilidades.pas',
  uVariaveisGlobais in 'comum\uVariaveisGlobais.pas',
  dmConexao in 'dm\dmConexao.pas' {dmConexaoBanco: TDataModule},
  dmTabelasAuxiliares in 'dm\dmTabelasAuxiliares.pas' {dmTabAuxiliares: TDataModule},
  dmCursos in 'dm\dmCursos.pas' {dmCurso: TDataModule},
  uCadCursos in 'units\uCadCursos.pas' {frmCadCursos},
  uCadDataVigencia in 'units\uCadDataVigencia.pas' {frmCadDataVigencia},
  uCadDepartamentos in 'units\uCadDepartamentos.pas' {frmCadDepartamentos},
  uCadDisciplinas in 'units\uCadDisciplinas.pas' {frmCadDisciplinas},
  uCadHorarios in 'units\uCadHorarios.pas' {frmCadHorarios},
  uCadSeries in 'units\uCadSeries.pas' {frmCadSeries},
  uPesqCursos in 'units\uPesqCursos.pas' {frmPesqCursos},
  uPesqDataVigencia in 'units\uPesqDataVigencia.pas' {frmPesqDataVigencia},
  uPesqDepartamentos in 'units\uPesqDepartamentos.pas' {frmPesqDepartamentos},
  uPesqDisciplinas in 'units\uPesqDisciplinas.pas' {frmPesqDisciplinas},
  uPesqHorarios in 'units\uPesqHorarios.pas' {frmPesqHorarios},
  uPesqSeries in 'units\uPesqSeries.pas' {frmPesqSeries},
  uCadGradeCurricular in 'units\uCadGradeCurricular.pas' {frmCadGradeCurricular},
  Vcl.Themes,
  Vcl.Styles,
  uPesqPessoas in 'units\uPesqPessoas.pas' {frmPesqPessoas},
  dmPessoas in 'dm\dmPessoas.pas' {dmPessoa: TDataModule},
  uCadPessoas in 'units\uCadPessoas.pas' {frmCadPessoas},
  Ufuncoes in 'comum\Ufuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TdmConexaoBanco, dmConexaoBanco);
  Application.CreateForm(TdmTabAuxiliares, dmTabAuxiliares);
  Application.CreateForm(TdmCurso, dmCurso);
  Application.CreateForm(TdmPessoa, dmPessoa);
  Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
  Application.CreateForm(TfrmCadPessoas, frmCadPessoas);
  Application.Run;
end.
