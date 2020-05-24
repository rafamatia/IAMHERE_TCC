unit uMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Sair1: TMenuItem;
    minDepartamentos: TMenuItem;
    minCursos: TMenuItem;
    minDisciplinas: TMenuItem;
    minPessoas: TMenuItem;
    minSeries: TMenuItem;
    minHorarios: TMenuItem;
    HorriodeAulas1: TMenuItem;
    DatasdeVigncia1: TMenuItem;
    abelasAuxiliares1: TMenuItem;
    N1: TMenuItem;
    procedure DatasdeVigncia1Click(Sender: TObject);
    procedure minDepartamentosClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure minDisciplinasClick(Sender: TObject);
    procedure minSeriesClick(Sender: TObject);
    procedure minHorariosClick(Sender: TObject);
    procedure minCursosClick(Sender: TObject);
    procedure minPessoasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

{$R *.dfm}

uses uPesqDataVigencia, uPesqDepartamentos, uPesqDisciplinas, uPesqSeries,
  uPesqHorarios, uPesqCursos, uPesqPessoas;

procedure TfrmMenuPrincipal.DatasdeVigncia1Click(Sender: TObject);
begin
  frmPesqDataVigencia := TfrmPesqDataVigencia.Create(Self);
  try
    frmPesqDataVigencia.ShowModal;
  finally
    FreeAndNil(frmPesqDataVigencia);
  end;
end;

procedure TfrmMenuPrincipal.minCursosClick(Sender: TObject);
begin
  frmPesqCursos := TfrmPesqCursos.Create(Self);
  try
    frmPesqCursos.ShowModal;
  finally
    FreeAndNil(frmPesqCursos);
  end;
end;

procedure TfrmMenuPrincipal.minDepartamentosClick(Sender: TObject);
begin
  frmPesqDepartamentos := TfrmPesqDepartamentos.Create(Self);
  try
    frmPesqDepartamentos.ShowModal;
  finally
    FreeAndNil(frmPesqDepartamentos);
  end;
end;

procedure TfrmMenuPrincipal.minDisciplinasClick(Sender: TObject);
begin
  frmPesqDisciplinas := TfrmPesqDisciplinas.Create(Self);
  try
    frmPesqDisciplinas.ShowModal;
  finally
    FreeAndNil(frmPesqDisciplinas);
  end;
end;

procedure TfrmMenuPrincipal.minHorariosClick(Sender: TObject);
begin
  frmPesqHorarios := TfrmPesqHorarios.Create(Self);
  try
    frmPesqHorarios.ShowModal;
  finally
    FreeAndNil(frmPesqHorarios);
  end;
end;

procedure TfrmMenuPrincipal.minPessoasClick(Sender: TObject);
begin
  frmPesqPessoas := TfrmPesqPessoas.Create(Self);
  try
    frmPesqPessoas.ShowModal;
  finally
    FreeAndNil(frmPesqPessoas);
  end;
end;

procedure TfrmMenuPrincipal.minSeriesClick(Sender: TObject);
begin
  frmPesqSeries := TfrmPesqSeries.Create(Self);
  try
    frmPesqSeries.ShowModal;
  finally
    FreeAndNil(frmPesqSeries);
  end;
end;

procedure TfrmMenuPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
