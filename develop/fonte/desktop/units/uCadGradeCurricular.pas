unit uCadGradeCurricular;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TfrmCadGradeCurricular = class(TcManuPadrao)
    Label1: TLabel;
    DBE_GRC_ID: TDBEdit;
    GroupBox1: TGroupBox;
    DBE_GRC_DATAVIGENCIA: TDBEdit;
    edtDtInicio: TEdit;
    edtDtFim: TEdit;
    GroupBox2: TGroupBox;
    DBE_GRC_DISCIPLINA: TDBEdit;
    edtDescDisciplina: TEdit;
    GroupBox3: TGroupBox;
    DBE_GRC_SERIE: TDBEdit;
    edtDescSerie: TEdit;
    GroupBox4: TGroupBox;
    DBE_GRC_CARGAHORARIASEMANAL: TDBEdit;
    GroupBox5: TGroupBox;
    DBE_GRC_CARGAHORARIATOTAL: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure DBE_GRC_DISCIPLINAExit(Sender: TObject);
    procedure DBE_GRC_SERIEExit(Sender: TObject);
    procedure DBE_GRC_DATAVIGENCIAExit(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGradeCurricular: TfrmCadGradeCurricular;

implementation

{$R *.dfm}

uses dmCursos, utilidades, uPesqDisciplinas, uPesqSeries, dmTabelasAuxiliares,
  uPesqDataVigencia;

procedure TfrmCadGradeCurricular.DBE_GRC_DATAVIGENCIAExit(Sender: TObject);
var
  c_DtInicio: String;
  c_DtFim: String;
begin
  dmTabAuxiliares.funcExisteDataVigencia(StrToIntDef(DBE_GRC_DATAVIGENCIA.Text,
    0), c_DtInicio, c_DtFim);

  if (c_DtInicio = EmptyStr) or (c_DtFim = EmptyStr) then
  begin
    frmPesqDataVigencia := TfrmPesqDataVigencia.Create(Self);
    try
      frmPesqDataVigencia.b_SomenteConsulta := True;
      frmPesqDataVigencia.ShowModal;
    finally
      if dmTabAuxiliares.qrySeries.IsEmpty then
      begin
        edtDescSerie.Clear;
        DBE_GRC_SERIE.Clear;
      end
      else
      begin
        edtDtInicio.Text :=
          dmTabAuxiliares.qryDataVigenciaDVG_DT_INICIO.AsString;
        edtDtFim.Text := dmTabAuxiliares.qryDataVigenciaDVG_DT_FIM.AsString;
        DBE_GRC_DATAVIGENCIA.Text :=
          dmTabAuxiliares.qryDataVigenciaDVG_ID.AsString;
      end;
      FreeAndNil(frmPesqDataVigencia);
      DBE_GRC_DATAVIGENCIAExit(Sender);
    end;
  end
  else
  begin
    edtDtInicio.Text := c_DtInicio;
    edtDtFim.Text := c_DtFim;
  end;

  if ((edtDtInicio.Text = EmptyStr) or (edtDtFim.Text = EmptyStr)) then
  begin
    DBE_GRC_DATAVIGENCIA.Clear;
    DBE_GRC_DATAVIGENCIAExit(Sender);
  end;

  procSetaFoco(DBE_GRC_CARGAHORARIASEMANAL);
end;

procedure TfrmCadGradeCurricular.DBE_GRC_DISCIPLINAExit(Sender: TObject);
var
  c_DescDisciplina: String;
begin
  inherited;
  c_DescDisciplina := dmCurso.funcExisteDisciplina
    (StrToIntDef(DBE_GRC_DISCIPLINA.Text, 0));
  if (c_DescDisciplina = EmptyStr) then
  begin
    frmPesqDisciplinas := TfrmPesqDisciplinas.Create(Self);
    try
      frmPesqDisciplinas.b_SomenteConsulta := True;
      frmPesqDisciplinas.ShowModal;
    finally
      if dmCurso.qryDisciplinas.IsEmpty then
      begin
        edtDescDisciplina.Clear;
        DBE_GRC_DISCIPLINA.Clear;
      end
      else
      begin
        edtDescDisciplina.Text := dmCurso.qryDisciplinasDIS_DESCRICAO.AsString;
        DBE_GRC_DISCIPLINA.Text := dmCurso.qryDisciplinasDIS_CODIGO.AsString;
      end;
      FreeAndNil(frmPesqDisciplinas);
      DBE_GRC_DISCIPLINAExit(Sender);
    end;
  end
  else
    edtDescDisciplina.Text := c_DescDisciplina;

  if (edtDescDisciplina.Text = EmptyStr) then
  begin
    DBE_GRC_DISCIPLINA.Clear;
    DBE_GRC_DISCIPLINAExit(Sender);
  end;

  procSetaFoco(DBE_GRC_SERIE);
end;

procedure TfrmCadGradeCurricular.DBE_GRC_SERIEExit(Sender: TObject);
var
  c_DescSerie: String;
begin
  inherited;
  c_DescSerie := dmTabAuxiliares.funcExisteSerie
    (StrToIntDef(DBE_GRC_SERIE.Text, 0));
  if (c_DescSerie = EmptyStr) then
  begin
    frmPesqSeries := TfrmPesqSeries.Create(Self);
    try
      frmPesqSeries.b_SomenteConsulta := True;
      frmPesqSeries.ShowModal;
    finally
      if dmTabAuxiliares.qrySeries.IsEmpty then
      begin
        edtDescSerie.Clear;
        DBE_GRC_SERIE.Clear;
      end
      else
      begin
        edtDescSerie.Text := dmTabAuxiliares.qrySeriesSER_DESCRICAO.AsString;
        DBE_GRC_SERIE.Text := dmTabAuxiliares.qrySeriesSER_ANO.AsString;
      end;
      FreeAndNil(frmPesqSeries);
      DBE_GRC_SERIEExit(Sender);
    end;
  end
  else
    edtDescSerie.Text := c_DescSerie;

  if (edtDescSerie.Text = EmptyStr) then
  begin
    DBE_GRC_SERIE.Clear;
    DBE_GRC_SERIEExit(Sender);
  end;

  procSetaFoco(DBE_GRC_DATAVIGENCIA);
end;

procedure TfrmCadGradeCurricular.FormShow(Sender: TObject);
begin
  inherited;
  procSetaCorCampo(DBE_GRC_ID, True, False);
  procSetaCorCampoEdit(edtDescDisciplina, True, False);
  procSetaCorCampoEdit(edtDescSerie, True, False);
  procSetaCorCampoEdit(edtDtInicio, True, False);
  procSetaCorCampoEdit(edtDtFim, True, False);
  procSetaCorCampo(DBE_GRC_SERIE, False, True);
  procSetaCorCampo(DBE_GRC_DATAVIGENCIA, False, True);
  procSetaCorCampo(DBE_GRC_CARGAHORARIASEMANAL, False, True);
  procSetaCorCampo(DBE_GRC_CARGAHORARIATOTAL, False, True);
  procSetaCorCampo(DBE_GRC_DISCIPLINA, False, True);

  edtDescDisciplina.Clear;
  edtDescSerie.Clear;
  edtDtInicio.Clear;
  edtDtFim.Clear;

  if (dmCurso.qryGradeCurricular.State in [dsEdit]) then
  begin
    DBE_GRC_DISCIPLINAExit(Sender);
    DBE_GRC_SERIEExit(Sender);
    DBE_GRC_DATAVIGENCIAExit(Sender);
  end;

  procSetaFoco(DBE_GRC_DISCIPLINA);
end;

procedure TfrmCadGradeCurricular.sbCancelarClick(Sender: TObject);
begin
  try
    dmCurso.qryGradeCurricular.Cancel;
  except
    on E: Exception do
  end;
  inherited;
end;

procedure TfrmCadGradeCurricular.sbGravarClick(Sender: TObject);
begin
  inherited;
  try
    dmCurso.qryGradeCurricularDIS_DESCRICAO.AsString := edtDescDisciplina.Text;
    dmCurso.qryGradeCurricularSER_DESCRICAO.AsString := edtDescSerie.Text;
    dmCurso.qryGradeCurricularDVG_DT_INICIO.AsDateTime := StrToDateTime(edtDtInicio.Text);
    dmCurso.qryGradeCurricularDVG_DT_FIM.AsDateTime := StrToDateTime(edtDtFim.Text);
    dmCurso.qryGradeCurricular.Post;
    Close;
  except
    on E: Exception do
    begin
      procMensagem
        ('Não foi possível gravar este registro! Entre em contato o suporte técnico!'
        + sLineBreak + E.Message, 'E');
      Exit;
    end;
  end;
end;

end.
