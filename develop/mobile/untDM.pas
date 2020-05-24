unit untDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TDM = class(TDataModule)
    fdcConexao: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryDepartamentos: TFDQuery;
    qryDepartamentosDEP_CODIGO: TIntegerField;
    qryDepartamentosDEP_DESCRICAO: TStringField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryProfessorHorario: TFDQuery;
    qryProfessorHorarioPFH_ID: TIntegerField;
    qryProfessorHorarioPFH_PROFESSOR: TStringField;
    qryProfessorHorarioPFH_GRADE: TIntegerField;
    qryProfessorHorarioPFH_HORARIO: TIntegerField;
    qryProfessorHorarioPFH_ANOLETIVO: TIntegerField;
    qryProfessorHorarioPFH_DIADASEMANA: TIntegerField;
    qryProfessorHorarioPES_NOMECOMPLETO: TStringField;
    qryProfessorHorarioHOR_DESCRICAO: TStringField;
    qryProfessorHorarioHOR_QTD_AULA: TIntegerField;
    qryProfessorHorarioCUR_NOME: TStringField;
    qryProfessorHorarioDIS_DESCRICAO: TStringField;
    qryListaChamada: TFDQuery;
    qryListaChamadaPES_NOMECOMPLETO: TStringField;
    qryChamada: TFDQuery;
    qryAux: TFDQuery;
    qryListaChamadaACG_ACADEMICO: TStringField;
    qryListaChamadaACG_GRADE: TIntegerField;
    qryListaChamadaFQA_PRESENCAFALTA: TWideStringField;
    qryListaChamadaIDCHAMADA: TWideStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDM }

end.
