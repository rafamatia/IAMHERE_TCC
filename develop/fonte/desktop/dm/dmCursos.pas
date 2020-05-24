unit dmCursos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCurso = class(TDataModule)
    qryDepartamentos: TFDQuery;
    dqryDepartamentos: TDataSource;
    qryDisciplinas: TFDQuery;
    dqryDisciplinas: TDataSource;
    qryCursos: TFDQuery;
    dqryCursos: TDataSource;
    qryDepartamentosDEP_CODIGO: TIntegerField;
    qryDepartamentosDEP_DESCRICAO: TStringField;
    qryDisciplinasDIS_CODIGO: TIntegerField;
    qryDisciplinasDIS_DESCRICAO: TStringField;
    qryCursosCUR_CODIGO: TIntegerField;
    qryCursosCUR_NOME: TStringField;
    qryCursosCUR_DURACAO: TIntegerField;
    qryCursosCUR_TIPO_DURACAO: TStringField;
    qryCursosCUR_PERIODO: TStringField;
    qryCursosCUR_NIVEL: TStringField;
    qryCursosCUR_CARGAHORARIA: TIntegerField;
    qryCursosCUR_DEPARTAMENTO: TIntegerField;
    qryCursosDEP_DESCRICAO: TStringField;
    qryGradeCurricular: TFDQuery;
    dqryGradeCurricular: TDataSource;
    qryGradeCurricularGRC_ID: TIntegerField;
    qryGradeCurricularGRC_CURSO: TIntegerField;
    qryGradeCurricularGRC_DISCIPLINA: TIntegerField;
    qryGradeCurricularGRC_SERIE: TIntegerField;
    qryGradeCurricularGRC_DATAVIGENCIA: TIntegerField;
    qryGradeCurricularGRC_CARGAHORARIATOTAL: TIntegerField;
    qryGradeCurricularGRC_CARGAHORARIASEMANAL: TIntegerField;
    qryGradeCurricularDIS_DESCRICAO: TStringField;
    qryGradeCurricularSER_DESCRICAO: TStringField;
    qryGradeCurricularDVG_DT_INICIO: TDateField;
    qryGradeCurricularDVG_DT_FIM: TDateField;
    procedure qryDepartamentosAfterInsert(DataSet: TDataSet);
    procedure qryDisciplinasAfterInsert(DataSet: TDataSet);
    procedure qryCursosAfterInsert(DataSet: TDataSet);
    procedure qryGradeCurricularAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }

    { FUNCOES PUBLICAS }
    function funcDepartamentoEstaSendoUsado(AIdDepartamento: integer): Boolean;
    function funcDisciplinasEstaSendoUsada(AIdDisciplina: integer): Boolean;
    function funcExisteDepartamento(AIdDepartamento: integer): String;
    function funcExisteDisciplina(AIdDisciplina: integer): String;

    { PROCEDIMENTOS PUBLICOS }
    procedure procSelectGradeCurricular(AIDCuros: integer);
  end;

var
  dmCurso: TdmCurso;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmConexao, Ufuncoes, constantes, tipos;

{$R *.dfm}
{ TdmCurso }

function TdmCurso.funcDepartamentoEstaSendoUsado(AIdDepartamento
  : integer): Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.cur_departamento from cursos a ' +
      ' where a.cur_departamento = :id_departamento ';
    qryAux.ParamByName('id_departamento').AsInteger := AIdDepartamento;
    qryAux.Open;
    Result := (not(qryAux.IsEmpty));
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmCurso.funcDisciplinasEstaSendoUsada(AIdDisciplina: integer)
  : Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.grc_id from grade_curricular a ' +
      ' where a.grc_disciplina = :id_disciplina ';
    qryAux.ParamByName('id_disciplina').AsInteger := AIdDisciplina;
    qryAux.Open;
    Result := (not(qryAux.IsEmpty));
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmCurso.funcExisteDepartamento(AIdDepartamento: integer): String;
var
  qryAux: TFDQuery;
begin
  Result := EmptyStr;
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.dep_descricao from departamentos a ' +
      ' where a.dep_codigo = :dep_codigo ';
    qryAux.ParamByName('dep_codigo').AsInteger := AIdDepartamento;
    qryAux.Open;
    if (not(qryAux.IsEmpty)) then
      Result := qryAux.fieldByName('dep_descricao').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmCurso.funcExisteDisciplina(AIdDisciplina: integer): String;
var
  qryAux: TFDQuery;
begin
  Result := EmptyStr;
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.dis_descricao from disciplinas a ' +
      ' where a.dis_codigo = :dis_codigo ';
    qryAux.ParamByName('dis_codigo').AsInteger := AIdDisciplina;
    qryAux.Open;
    if (not(qryAux.IsEmpty)) then
      Result := qryAux.fieldByName('dis_descricao').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TdmCurso.procSelectGradeCurricular(AIDCuros: integer);
begin
  qryGradeCurricular.Close;
  qryGradeCurricular.SQL.Clear;
  qryGradeCurricular.SQL.Text := C_SQL_GRADECURRICULAR + C_WHERE_SIMPLES +
    ' A.GRC_CURSO = :GRC_CURSO ';
  qryGradeCurricular.ParamByName('GRC_CURSO').AsInteger := AIDCuros;
  qryGradeCurricular.Open;
end;

procedure TdmCurso.qryCursosAfterInsert(DataSet: TDataSet);
begin
  qryCursosCUR_CODIGO.AsInteger := funcOberProximoID(C_SEQ_CURSOS);
  qryCursosCUR_TIPO_DURACAO.AsString := c_TP_TD_ANUAL;
  qryCursosCUR_PERIODO.AsString := C_TP_PER_MATUTINO;
  qryCursosCUR_NIVEL.AsString := C_TP_GRAU_GRADUACAO;
end;

procedure TdmCurso.qryDepartamentosAfterInsert(DataSet: TDataSet);
begin
  qryDepartamentosDEP_CODIGO.AsInteger :=
    funcOberProximoID(C_SEQ_DEPARTAMENTOS);
end;

procedure TdmCurso.qryDisciplinasAfterInsert(DataSet: TDataSet);
begin
  qryDisciplinasDIS_CODIGO.AsInteger := funcOberProximoID(C_SEQ_DISCIPLINAS);
end;

procedure TdmCurso.qryGradeCurricularAfterInsert(DataSet: TDataSet);
begin
  dmCurso.qryGradeCurricularGRC_ID.AsInteger :=
    funcOberProximoID(C_SEQ_GRADE_CURRICULAR);
  dmCurso.qryGradeCurricularGRC_CURSO.AsInteger :=
    dmCurso.qryCursosCUR_CODIGO.AsInteger;
end;

end.
