unit uFreqAcademicos;

interface

type
  TFreqAcademicos = class
  private
    FFQA_ID: Integer;
    FFQA_ACADEMICO: String;
    FFQA_PROFESSOR: String;
    FFQA_DTCHAMADA: TDateTime;
    FFQA_GRADE: Integer;
    FFQA_PRESENCAFALTA: String;
    FFQA_DTSINCRONIZACAO: TDate;
    FFQA_ANOLETIVO: Integer;
    FFQA_DIASEMANA: Integer;
    FFQA_HORARIO: Integer;
    FFQA_QTDAULA: Integer;
  public
    property FQA_ID: Integer read FFQA_ID write FFQA_ID;
    property FQA_ACADEMICO: String read FFQA_ACADEMICO write FFQA_ACADEMICO;
    property FQA_PROFESSOR: String read FFQA_PROFESSOR write FFQA_PROFESSOR;
    property FQA_DTCHAMADA: TDateTime read FFQA_DTCHAMADA write FFQA_DTCHAMADA;
    property FQA_GRADE: Integer read FFQA_GRADE write FFQA_GRADE;
    property FQA_PRESENCAFALTA: String read FFQA_PRESENCAFALTA write FFQA_PRESENCAFALTA;
    property FQA_DTSINCRONIZACAO: TDate read FFQA_DTSINCRONIZACAO write FFQA_DTSINCRONIZACAO;
    property FQA_ANOLETIVO: Integer read FFQA_ANOLETIVO write FFQA_ANOLETIVO;
    property FQA_DIASEMANA: Integer read FFQA_DIASEMANA write FFQA_DIASEMANA;
    property FQA_HORARIO: Integer read FFQA_HORARIO write FFQA_HORARIO;
    property FQA_QTDAULA: Integer read FFQA_QTDAULA write FFQA_QTDAULA;

    Constructor Create; // declaração do metodo construtor
    Destructor Destroy; Override; // declaração do metodo destrutor
  end;

implementation

{ TFreqAcademicos }

constructor TFreqAcademicos.Create;
begin

end;

destructor TFreqAcademicos.Destroy;
begin

  inherited;
end;

end.
