unit dmTabelasAuxiliares;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, IdBaseComponent, IdDateTimeStamp;

type
  TdmTabAuxiliares = class(TDataModule)
    qryDataVigencia: TFDQuery;
    dqryDataVigencia: TDataSource;
    qryDataVigenciaDVG_ID: TIntegerField;
    qryDataVigenciaDVG_DT_INICIO: TDateField;
    qryDataVigenciaDVG_DT_FIM: TDateField;
    qrySeries: TFDQuery;
    dqrySeries: TDataSource;
    qryHorarios: TFDQuery;
    dqryHorarios: TDataSource;
    qrySeriesSER_ANO: TIntegerField;
    qrySeriesSER_DESCRICAO: TStringField;
    qryHorariosHOR_CODIGO: TIntegerField;
    qryHorariosHOR_DESCRICAO: TStringField;
    qryHorariosHOR_QTD_AULA: TIntegerField;
    qryHorariosHOR_ORDEM_AULA: TIntegerField;
    qryHorariosHOR_HORA_INICIO: TTimeField;
    qryHorariosHOR_HORA_FIM: TTimeField;
    qryHorariosHOR_DURACAO: TTimeField;
    procedure qryDataVigenciaAfterInsert(DataSet: TDataSet);
    procedure qrySeriesSER_ANOValidate(Sender: TField);
    procedure qryHorariosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function funcDataVigenciaEstaSendoUsada(AIdDtVigencia: integer): Boolean;
    function funcSeriesEstaSendoUsado(AAnoSerie: integer): Boolean;
    function funcSerieJaExiste(AAnoSerie: integer): Boolean;
    function funcValidaDataVigenciaExistente(ADtInicio,
      ADtFim: TDateTime): Boolean;

    function funcExisteSerie(AIdSerie: integer): String;
    function funcExisteDataVigencia(AIdSerie: integer; out ADtInicio: String;
      out ADtFim: string): Boolean;
  end;

var
  dmTabAuxiliares: TdmTabAuxiliares;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmConexao, Ufuncoes, constantes, utilidades;

{$R *.dfm}
{ TdmTabAuxiliares }

function TdmTabAuxiliares.funcDataVigenciaEstaSendoUsada(AIdDtVigencia
  : integer): Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.grc_id ' + ' from grade_curricular a ' +
      ' where a.grc_datavigencia = :id_dtvigencia ';
    qryAux.ParamByName('id_dtvigencia').AsInteger := AIdDtVigencia;
    qryAux.Open;
    Result := (not(qryAux.IsEmpty));
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmTabAuxiliares.funcSerieJaExiste(AAnoSerie: integer): Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := C_SQL_SERIES + ' ' + C_WHERE_SIMPLES +
      ' A.ser_ano = :ser_ano';
    qryAux.ParamByName('ser_ano').AsInteger := AAnoSerie;
    qryAux.Open;
    Result := (not(qryAux.IsEmpty));
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmTabAuxiliares.funcSeriesEstaSendoUsado(AAnoSerie: integer): Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := 'select a.grc_id from grade_curricular a ' +
      ' where a.grc_serie = :id_ano ';
    qryAux.ParamByName('id_ano').AsInteger := AAnoSerie;
    qryAux.Open;
    Result := (not(qryAux.IsEmpty));
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmTabAuxiliares.funcValidaDataVigenciaExistente(ADtInicio,
  ADtFim: TDateTime): Boolean;
var
  qryAux: TFDQuery;
begin
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select count(*) QTD_REGISTRO from data_vigencia a ' +
      'where a.dvg_dt_inicio = :dvg_dt_inicio ' +
      ' and a.dvg_dt_fim = :dvg_dt_fim';
    qryAux.ParamByName('dvg_dt_inicio').AsDateTime := ADtInicio;
    qryAux.ParamByName('dvg_dt_fim').AsDateTime := ADtFim;
    qryAux.Open;
    Result := (qryAux.FieldByName('QTD_REGISTRO').AsInteger > 0);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TdmTabAuxiliares.qryDataVigenciaAfterInsert(DataSet: TDataSet);
begin
  qryDataVigenciaDVG_ID.AsInteger := funcOberProximoID(C_SEQ_DATA_VIGENCIA);
end;

procedure TdmTabAuxiliares.qryHorariosAfterInsert(DataSet: TDataSet);
begin
  qryHorariosHOR_CODIGO.AsInteger := funcOberProximoID(C_SEQ_HORARIOS);
end;

procedure TdmTabAuxiliares.qrySeriesSER_ANOValidate(Sender: TField);
begin
  if dmTabAuxiliares.funcSerieJaExiste
    (dmTabAuxiliares.qrySeriesSER_ANO.AsInteger) then
  begin
    procMensagem
      ('Já existe uma série cadastrada com este ano, verifique e tente novamente!',
      'A');
    Abort;
  end;
end;

function TdmTabAuxiliares.funcExisteDataVigencia(AIdSerie: integer;
  out ADtInicio, ADtFim: string): Boolean;
var
  qryAux: TFDQuery;
begin
  Result := False;
  ADtInicio := EmptyStr;
  ADtFim := EmptyStr;
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text :=
      ' select a.dvg_dt_inicio, a.dvg_dt_fim from data_vigencia a ' +
      ' where a.dvg_id = :dvg_id ';
    qryAux.ParamByName('dvg_id').AsInteger := AIdSerie;
    qryAux.Open;

    if qryAux.IsEmpty then
      exit;

    Result := True;
    ADtInicio := qryAux.FieldByName('dvg_dt_inicio').AsString;
    ADtFim := qryAux.FieldByName('dvg_dt_fim').AsString;;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TdmTabAuxiliares.funcExisteSerie(AIdSerie: integer): String;
var
  qryAux: TFDQuery;
begin
  Result := EmptyStr;
  qryAux := funcObterQuery();
  try
    qryAux.SQL.Text := ' select a.ser_descricao from series a ' +
      ' where a.ser_ano = :ser_ano ';
    qryAux.ParamByName('ser_ano').AsInteger := AIdSerie;
    qryAux.Open;
    if (not(qryAux.IsEmpty)) then
      Result := qryAux.FieldByName('ser_descricao').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

end.
