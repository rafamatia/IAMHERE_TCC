unit untFrequenciaAcademicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untCadModelo, FMX.Objects, FMX.ListBox, FMX.Edit, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmFrequenciaAcademicos = class(TfrmCadModelo)
    Layout3: TLayout;
    Edit1: TEdit;
    cmbCursos: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    cmbHorarioAula: TComboBox;
    Label9: TLabel;
    cmbDisciplinas: TComboBox;
    lytBotoesInferiorFiltros: TLayout;
    lytFazerChamada: TLayout;
    rndFazerChamada: TRoundRect;
    lblFazerChamada: TLabel;
    Layout6: TLayout;
    edtData: TEdit;
    edtDiaDaSemana: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    ToolBar1: TToolBar;
    Label11: TLabel;
    btnCancelar: TSpeedButton;
    btnGravar: TSpeedButton;
    ShadowEffect3: TShadowEffect;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    memHorarioAula: TFDMemTable;
    memHorarioAulaITEMINDEX: TIntegerField;
    memHorarioAulaHORARIO_ID: TIntegerField;
    memHorarioAulaDESCRICAO: TStringField;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    lytFundoListaChamada: TLayout;
    lsviewListaChamada: TListView;
    LinkListControlToField3: TLinkListControlToField;
    Layout1: TLayout;
    lytPresencaTodos: TLayout;
    rndPresencaTodos: TRoundRect;
    lblPresencaTodos: TLabel;
    ShadowEffect4: TShadowEffect;
    lytFaltaTodos: TLayout;
    rndFaltaTodos: TRoundRect;
    lblFaltaTodos: TLabel;
    ShadowEffect5: TShadowEffect;
    procedure lblFazerChamadaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbHorarioAulaChange(Sender: TObject);
    procedure lsviewListaChamadaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lblFaltaTodosClick(Sender: TObject);
    procedure lblPresencaTodosClick(Sender: TObject);
    procedure blNomeInstituicaoClick(Sender: TObject);
    procedure Layout2Click(Sender: TObject);
  private
    { Private declarations }
    procedure procPreencherOpcFiltros;
    procedure procMarcarTodos(APresenca: Boolean); overload;
    procedure procMarcarTodos; overload;
    function DiaSemana(Data: TDateTime): String;

  public
    { Public declarations }
  end;

var
  frmFrequenciaAcademicos: TfrmFrequenciaAcademicos;

implementation

{$R *.fmx}

uses untDM, uConstantes, Androidapi.Helpers, FMX.DialogService, untMensagem,
  uFreqAcademicos, uFreqAcademicosDAO;

procedure TfrmFrequenciaAcademicos.blNomeInstituicaoClick(Sender: TObject);
begin
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryAux.Close;
  DM.qryAux.SQL.Clear;
  DM.qryAux.SQL.Text := 'delete from FREQ_ACADEMICOS';
  DM.qryAux.ExecSQL;
{$ENDIF}
end;

procedure TfrmFrequenciaAcademicos.btnCancelarClick(Sender: TObject);
begin
  procMudarAba(tbitemListagem, Sender);
end;

procedure TfrmFrequenciaAcademicos.btnGravarClick(Sender: TObject);
begin
  TDialogService.MessageDialog('Confirma a chamada?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], System.UITypes.TMsgDlgBtn.mbYes, 0,

    procedure(const AResult: TModalResult)

    var
      i_aux: Integer;
      OFreqAcademicos: TFreqAcademicos;
    begin
      case AResult of
        mrYES:
          begin
{$IF DEFINED (ANDROID) || (IOS)}
            OFreqAcademicos := TFreqAcademicos.Create;
            try
              DM.qryListaChamada.First;
              while (not(DM.qryListaChamada.Eof)) do
              begin
                i_aux := 0;
                for i_aux := 0 to lsviewListaChamada.Items.Count - 1 do
                begin
                  if (lsviewListaChamada.Items[i_aux]
                    .Text = DM.qryListaChamadaPES_NOMECOMPLETO.AsString) then
                  begin
                    OFreqAcademicos.FQA_PRESENCAFALTA := 'F';
                    if lsviewListaChamada.Items[i_aux].Checked then
                      OFreqAcademicos.FQA_PRESENCAFALTA := 'P';
                    strTeste := (lsviewListaChamada.Items[i_aux].Text);
                    STrNOME := DM.qryListaChamadaPES_NOMECOMPLETO.AsString;

                    OFreqAcademicos.FQA_ACADEMICO :=
                      DM.qryListaChamadaACG_ACADEMICO.AsString;
                    OFreqAcademicos.FQA_DTCHAMADA := Date;
                    OFreqAcademicos.FQA_DIASEMANA := DIA_SEMANA;
                    OFreqAcademicos.FQA_ANOLETIVO := ANOLETIVO;
                    OFreqAcademicos.FQA_PROFESSOR := PROFESSOR;
                    OFreqAcademicos.FQA_HORARIO := HORARIO;
                    OFreqAcademicos.FQA_QTDAULA := QTDAULA;
                    OFreqAcademicos.FQA_GRADE :=
                      DM.qryListaChamadaACG_GRADE.AsInteger;
                    OFreqAcademicos.FQA_ID := StrToIntDef( DM.qryListaChamadaIDCHAMADA.AsString, 0);

                    if ((boolChamadaRealizada) and (OFreqAcademicos.FQA_ID > 0)) then
                      TFreqAcademicosDAO.aletarChamada(OFreqAcademicos)
                    else
                      TFreqAcademicosDAO.salvarChamada(OFreqAcademicos);
                  end;
                end;

                DM.qryListaChamada.Next;
              end;
            finally
              FreeAndNil(OFreqAcademicos);
              boolChamadaRealizada := False;
            end;
{$ENDIF}
            procMudarAba(tbitemListagem, Sender);
          end;
      end;
    end);
end;

procedure TfrmFrequenciaAcademicos.cmbHorarioAulaChange(Sender: TObject);
var
  i_grade: Integer;
begin
  inherited;
  cmbCursos.Clear;
  cmbCursos.Items.Clear;
  cmbDisciplinas.Clear;
  cmbDisciplinas.Items.Clear;
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryProfessorHorario.First;
  if DM.qryProfessorHorario.Active and memHorarioAula.Active then
  begin
    if memHorarioAula.Locate('ITEMINDEX', cmbHorarioAula.ItemIndex, []) then
    begin
      try
        DM.qryProfessorHorario.First;
        DM.qryProfessorHorario.Filtered := False;
        DM.qryProfessorHorario.Filter := EmptyStr;
        DM.qryProfessorHorario.Filter := 'PFH_ID=' +
          memHorarioAulaHORARIO_ID.AsString;
        DM.qryProfessorHorario.Filtered := True;

      finally
        DM.qryProfessorHorario.First;
      end;
    end;
  end;
  DM.qryProfessorHorario.First;
{$ENDIF}
end;

function TfrmFrequenciaAcademicos.DiaSemana(Data: TDateTime): String;
var
  NoDia: Integer;
  DiaDaSemana: array [1 .. 7] of String;
begin
  DiaDaSemana[1] := 'DOMINGO';
  DiaDaSemana[2] := 'SEGUNDA-FEIRA';
  DiaDaSemana[3] := 'TERÇA-FEIRA';
  DiaDaSemana[4] := 'QUARTA-FEIRA';
  DiaDaSemana[5] := 'QUINTA-FEIRA';
  DiaDaSemana[6] := 'SEXTA-FEIRA';
  DiaDaSemana[7] := 'SÁBADO';
  NoDia := DayOfWeek(Data);
  Result := DiaDaSemana[NoDia];
  DIA_SEMANA := NoDia;
  ANOLETIVO := CurrentYear;
end;

procedure TfrmFrequenciaAcademicos.FormCreate(Sender: TObject);
begin
  inherited;
  edtData.Text := FormatDateTime('DD/MM/YYYY', Now);
  edtDiaDaSemana.Text := DiaSemana(Now);
  procPreencherOpcFiltros;
end;

procedure TfrmFrequenciaAcademicos.Layout2Click(Sender: TObject);
begin
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryAux.Close;
  DM.qryAux.SQL.Clear;
  DM.qryAux.SQL.Text := 'delete from FREQ_ACADEMICOS';
  DM.qryAux.ExecSQL;
{$ENDIF}
end;

procedure TfrmFrequenciaAcademicos.lblFaltaTodosClick(Sender: TObject);
begin
  procMarcarTodos(False);
end;

procedure TfrmFrequenciaAcademicos.lblFazerChamadaClick(Sender: TObject);
var
  OFreqAcademicos: TFreqAcademicos;
begin
  inherited;
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryProfessorHorario.First;
  if DM.qryProfessorHorario.Active and memHorarioAula.Active then
  begin
    if memHorarioAula.Locate('ITEMINDEX', cmbHorarioAula.ItemIndex, []) then
    begin
      OFreqAcademicos := TFreqAcademicos.Create;
      try
        DM.qryProfessorHorario.First;
        DM.qryProfessorHorario.Filtered := False;
        DM.qryProfessorHorario.Filter := EmptyStr;
        DM.qryProfessorHorario.Filter := 'PFH_ID=' +
          memHorarioAulaHORARIO_ID.AsString;
        DM.qryProfessorHorario.Filtered := True;

        DM.qryProfessorHorario.First;
        PROFESSOR := DM.qryProfessorHorarioPFH_PROFESSOR.AsString;
        HORARIO := DM.qryProfessorHorarioPFH_HORARIO.AsInteger;
        QTDAULA := DM.qryProfessorHorarioHOR_QTD_AULA.AsInteger;

        OFreqAcademicos.FQA_DTCHAMADA := Date;
        OFreqAcademicos.FQA_DIASEMANA := DIA_SEMANA;
        OFreqAcademicos.FQA_ANOLETIVO := ANOLETIVO;
        OFreqAcademicos.FQA_PROFESSOR := PROFESSOR;
        OFreqAcademicos.FQA_HORARIO := HORARIO;
        OFreqAcademicos.FQA_GRADE := DM.qryProfessorHorarioPFH_GRADE.AsInteger;

        DM.qryListaChamada.Close;
        DM.qryListaChamada.SQL.Clear;

        if TFreqAcademicosDAO.efetuadaChamada(OFreqAcademicos) then
        begin
          DM.qryListaChamada.SQL.Text :=
            ' select a.acg_academico, a.acg_grade, c.pes_nomecompleto, cast(x.fqa_presencafalta as varchar(10)) as  fqa_presencafalta, cast(x.fqa_id as varchar(10)) as idchamada '
            + ' from freq_academicos x ' +
            ' inner join academico_grade a on a.acg_grade = x.fqa_grade and a.acg_academico = x.fqa_academico '
            + ' inner join grade_curricular b on a.acg_grade = b.grc_id ' +
            ' inner join pessoas c on a.acg_academico = c.pes_cpfcnpj ' +
            ' inner join disciplinas e on b.grc_disciplina = e.dis_codigo ' +
            ' inner join cursos f on b.grc_curso = f.cur_codigo ' +
            ' inner join series g on b.grc_serie = g.ser_ano ' +
            ' inner join data_vigencia d on b.grc_datavigencia = d.dvg_id ';
          boolChamadaRealizada := True;
        end
        else
        begin
          DM.qryListaChamada.SQL.Text := C_SQL_LISTACHAMADA;
          boolChamadaRealizada := False;
        end;

        DM.qryListaChamada.SQL.Text := DM.qryListaChamada.SQL.Text +
          ' WHERE A.acg_grade=' + DM.qryProfessorHorarioPFH_GRADE.AsString;
        DM.qryListaChamada.Open;

      finally
        DM.qryListaChamada.First;
        DM.qryProfessorHorario.First;
        FreeAndNil(OFreqAcademicos);
      end;
    end;
  end;
  DM.qryProfessorHorario.First;

{$ENDIF}
  procMudarAba(tbitemEdicao, Sender);
  procMarcarTodos;
end;

procedure TfrmFrequenciaAcademicos.lblPresencaTodosClick(Sender: TObject);
begin
  procMarcarTodos(True);
end;

procedure TfrmFrequenciaAcademicos.lsviewListaChamadaItemClick
  (const Sender: TObject; const AItem: TListViewItem);
begin
  try
    AItem.Checked := (not(AItem.Checked));
    AItem.Objects.AccessoryObject.Visible := AItem.Checked;
  finally
  end;
end;

procedure TfrmFrequenciaAcademicos.procMarcarTodos(APresenca: Boolean);
var
  i_aux: Integer;
begin
  for i_aux := 0 to lsviewListaChamada.Items.Count - 1 do
  begin
    lsviewListaChamada.Items[i_aux].Checked := APresenca;
    lsviewListaChamada.Items[i_aux].Objects.AccessoryObject.Visible :=
      APresenca;
  end;
end;

procedure TfrmFrequenciaAcademicos.procMarcarTodos;
var
  i_aux: Integer;
begin
  for i_aux := 0 to lsviewListaChamada.Items.Count - 1 do
  begin
    DM.qryListaChamada.First;
    while (not(DM.qryListaChamada.Eof)) do
    begin
      strTeste := (lsviewListaChamada.Items[i_aux].Text);
      STrNOME := DM.qryListaChamadaPES_NOMECOMPLETO.AsString;
      if (DM.qryListaChamadaPES_NOMECOMPLETO.AsString = lsviewListaChamada.Items
        [i_aux].Text) then
      begin
        lsviewListaChamada.Items[i_aux].Checked :=
          (DM.qryListaChamadaFQA_PRESENCAFALTA.AsString = 'P');
        lsviewListaChamada.Items[i_aux].Objects.AccessoryObject.Visible :=
          lsviewListaChamada.Items[i_aux].Checked;
        break;
      end;
      DM.qryListaChamada.Next;
    end;
  end;
  DM.qryListaChamada.First;
end;

procedure TfrmFrequenciaAcademicos.procPreencherOpcFiltros;
var
  i_Index: Integer;
begin
  cmbHorarioAula.Clear;
  cmbHorarioAula.Items.Clear;
  cmbCursos.Clear;
  cmbDisciplinas.Clear;
  i_Index := 0;
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryProfessorHorario.Close;
  DM.qryProfessorHorario.Filtered := False;
  DM.qryProfessorHorario.Filter := EmptyStr;
  if DM.fdcConexao.Connected then
  begin
    DM.qryProfessorHorario.Close;
    DM.qryProfessorHorario.SQL.Clear;
    DM.qryProfessorHorario.SQL.Text := C_SQL_PROFHORARIO;
    DM.qryProfessorHorario.Open;
  end;

  if DM.qryProfessorHorario.Active then
  begin
    memHorarioAula.Open;
    DM.qryProfessorHorario.First;
    while (not(DM.qryProfessorHorario.Eof)) do
    begin
      memHorarioAula.Append;
      memHorarioAulaITEMINDEX.AsInteger := i_Index;
      memHorarioAulaHORARIO_ID.AsInteger :=
        DM.qryProfessorHorarioPFH_ID.AsInteger;
      memHorarioAulaDESCRICAO.AsString :=
        DM.qryProfessorHorarioHOR_DESCRICAO.AsString;
      memHorarioAula.Post;
      inc(i_Index);
      // cmbHorarioAula.Items.AddObject(DM.qryProfessorHorarioHOR_DESCRICAO.AsString, TObject(DM.qryProfessorHorarioPFH_ID.AsInteger));
      cmbHorarioAula.Items.Add(DM.qryProfessorHorarioHOR_DESCRICAO.AsString);
      // cmbHorarioAula.Items.IndexOf(DM.qryProfessorHorarioHOR_DESCRICAO.AsString) := DM.qryProfessorHorarioPFH_ID.AsInteger;
      // cmbCursos.Items.Add(DM.qryProfessorHorarioCUR_NOME.AsString);
      // cmbDisciplinas.Items.Add(DM.qryProfessorHorarioDIS_DESCRICAO.AsString);
      DM.qryProfessorHorario.Next;
    end;
    DM.qryProfessorHorario.First;
    cmbHorarioAula.ItemIndex := 0;
  end;

{$ENDIF}
end;

end.
