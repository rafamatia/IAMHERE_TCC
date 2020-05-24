unit uFreqAcademicosDAO;

interface

uses uFreqAcademicos, System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI;

type
  TFreqAcademicosDAO = class
  private
    function maiorIDFreqAcademicos: Integer;
  public
    class function salvarChamada(AFreqAcademico: TFreqAcademicos): Boolean;
    class function aletarChamada(AFreqAcademico: TFreqAcademicos): Boolean;
    class function efetuadaChamada(AFreqAcademico: TFreqAcademicos): Boolean;
  end;

implementation

uses untDM, uConstantes;

{ TFreqAcademicosDAO }

class function TFreqAcademicosDAO.aletarChamada(AFreqAcademico
  : TFreqAcademicos): Boolean;
begin
  DM.qryChamada.Close;
  DM.qryChamada.SQL.Clear;
  DM.qryChamada.SQL.Text := 'update freq_academicos ' +
    ' set fqa_presencafalta = :fqa_presencafalta ' +
    ' where (fqa_id = :fqa_id) ';
  DM.qryChamada.ParamByName('fqa_presencafalta').AsString :=
    AFreqAcademico.FQA_PRESENCAFALTA;
  DM.qryChamada.ParamByName('fqa_id').AsInteger := AFreqAcademico.FQA_ID;
  DM.qryChamada.ExecSQL;
end;

class function TFreqAcademicosDAO.efetuadaChamada(AFreqAcademico
  : TFreqAcademicos): Boolean;
begin
  DM.qryAux.Close;
  DM.qryAux.SQL.Clear;
  DM.qryAux.SQL.Text := ' select a.fqa_id ' + ' from freq_academicos a ' +
    ' where a.fqa_professor = :fqa_professor ' +
    ' and a.fqa_dtchamada = :fqa_dtchamada ' + ' and a.fqa_grade = :fqa_grade '
    + ' and a.fqa_anoletivo = :fqa_anoletivo ' +
    ' and a.fqa_diasemana = :fqa_diasemana ' +
    ' and a.fqa_horario = :fqa_horario ';
  DM.qryAux.ParamByName('fqa_professor').AsString :=
    AFreqAcademico.FQA_PROFESSOR;
  DM.qryAux.ParamByName('fqa_dtchamada').AsDateTime := Date;
  DM.qryAux.ParamByName('fqa_grade').AsInteger := AFreqAcademico.FQA_GRADE;
  DM.qryAux.ParamByName('fqa_anoletivo').AsInteger :=
    AFreqAcademico.FQA_ANOLETIVO;
  DM.qryAux.ParamByName('fqa_diasemana').AsInteger :=
    AFreqAcademico.FQA_DIASEMANA;
  DM.qryAux.ParamByName('fqa_horario').AsInteger := AFreqAcademico.FQA_HORARIO;
  DM.qryAux.Open;
  DM.qryAux.First;
  datadachamada := AFreqAcademico.FQA_DTCHAMADA;
  datadachamada := DM.qryAux.ParamByName('fqa_dtchamada').AsDateTime;
  if DM.qryAux.recordcount > 0 then
    Result := true
  else
    Result := false;
  boolChamadaRealizada := Result;
end;

function TFreqAcademicosDAO.maiorIDFreqAcademicos: Integer;
begin
  DM.qryAux.Close;
  DM.qryAux.SQL.Clear;
  DM.qryAux.SQL.Text := ' select max(a.fqa_id) maior from freq_academicos a ';
  DM.qryAux.Open;

  if DM.qryAux.FieldByName('maior').IsNull then
    Result := 1
  else
    Result := (DM.qryAux.FieldByName('maior').AsInteger + 1);
end;

class function TFreqAcademicosDAO.salvarChamada(AFreqAcademico
  : TFreqAcademicos): Boolean;
var
  OFreqAcademicoDAO: TFreqAcademicosDAO;
begin
  OFreqAcademicoDAO := TFreqAcademicosDAO.Create;
  try
    DM.qryChamada.Close;
    DM.qryChamada.SQL.Clear;
    DM.qryChamada.SQL.Text :=
      ' insert into freq_academicos (fqa_id, fqa_academico, fqa_professor, fqa_dtchamada, fqa_grade, fqa_presencafalta, fqa_anoletivo, fqa_diasemana, fqa_horario, fqa_qtdaula) '
      + ' values (:fqa_id, :fqa_academico, :fqa_professor, :fqa_dtchamada, :fqa_grade, :fqa_presencafalta, :fqa_anoletivo, :fqa_diasemana, :fqa_horario, :fqa_qtdaula) ';
    DM.qryChamada.ParamByName('fqa_id').AsInteger :=
      OFreqAcademicoDAO.maiorIDFreqAcademicos;
    DM.qryChamada.ParamByName('fqa_academico').AsString :=
      AFreqAcademico.FQA_ACADEMICO;
    DM.qryChamada.ParamByName('fqa_professor').AsString :=
      AFreqAcademico.FQA_PROFESSOR;
    DM.qryChamada.ParamByName('fqa_dtchamada').AsDateTime :=
      AFreqAcademico.FQA_DTCHAMADA;
    DM.qryChamada.ParamByName('fqa_grade').AsInteger :=
      AFreqAcademico.FQA_GRADE;
    DM.qryChamada.ParamByName('fqa_presencafalta').AsString :=
      AFreqAcademico.FQA_PRESENCAFALTA;
    DM.qryChamada.ParamByName('fqa_anoletivo').AsInteger :=
      AFreqAcademico.FQA_ANOLETIVO;
    DM.qryChamada.ParamByName('fqa_diasemana').AsInteger :=
      AFreqAcademico.FQA_DIASEMANA;
    DM.qryChamada.ParamByName('fqa_horario').AsInteger :=
      AFreqAcademico.FQA_HORARIO;
    DM.qryChamada.ParamByName('fqa_qtdaula').AsInteger :=
      AFreqAcademico.FQA_QTDAULA;
    DM.qryChamada.ExecSQL;
  finally
    FreeAndNil(OFreqAcademicoDAO);
  end;
end;

end.
