unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  System.IOUtils, FMX.Edit, FMX.Platform, FMX.VirtualKeyboard;

type
  TfrmPrincipal = class(TForm)
    tbctrlPrincipal: TTabControl;
    tbitemMenu: TTabItem;
    tbitemApoio: TTabItem;
    lytPrincipal: TLayout;
    lytBackground: TLayout;
    acAcoes: TActionList;
    actMudarAba: TChangeTabAction;
    lytSuperior: TLayout;
    lytInferior: TLayout;
    rctNomeInstituicao: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout2: TLayout;
    blNomeInstituicao: TLabel;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    lytMenu: TGridLayout;
    lytMenuFrequencia: TLayout;
    rctMenuFrequencia: TRectangle;
    imgMenuFrequencia: TImage;
    ShadowEffect3: TShadowEffect;
    lytOpcMenuFrequencia: TLayout;
    lblMenuFrequencia: TLabel;
    ShadowEffect5: TShadowEffect;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Image1: TImage;
    ShadowEffect4: TShadowEffect;
    Layout4: TLayout;
    Label3: TLabel;
    ShadowEffect6: TShadowEffect;
    Rectangle3: TRectangle;
    Layout5: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RectAnimation1: TRectAnimation;
    lytMenuPrinc: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    imgFechar: TImage;
    ShadowEffect7: TShadowEffect;
    Layout6: TLayout;
    Label2: TLabel;
    ShadowEffect8: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure imgMenuFrequenciaClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
  private
    { Private declarations }
    FActiveForm: TForm;
  public
    { Public declarations }
    procedure procMudarAba(ATabItem: TTabItem; Sender: TObject);
    procedure procAbrirFormulario(AFormClass: TComponentClass);
    procedure procAjsutarLayout;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses untCadDepartamentos, untDM, untFrequenciaAcademicos;
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  procAjsutarLayout;
  // Label6.Text := 'Desconectado';
{$IF DEFINED (ANDROID) || (IOS)}
  DM.fdcConexao.Connected := False;
  DM.fdcConexao.DriverName := 'SQLite';
  DM.fdcConexao.Params.Values['Database'] :=
    TPath.Combine(TPath.GetDocumentsPath, 'dbmobile.db');
  DM.fdcConexao.Connected := True;
  // if DM.fdcConexao.Connected then
  // Label6.Text := 'Conectado';
{$ENDIF}
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
{$IF DEFINED (ANDROID) || (IOS)}
  DM.qryAux.Close;
  DM.qryAux.SQL.Clear;
    DM.qryAux.SQL.Text := 'delete from FREQ_ACADEMICOS';
  DM.qryAux.ExecSQL;
{$ENDIF}
  FreeAndNil(Application);
end;

procedure TfrmPrincipal.imgMenuFrequenciaClick(Sender: TObject);
begin
  procAbrirFormulario(TfrmFrequenciaAcademicos);
  procMudarAba(tbitemApoio, Sender);
end;

procedure TfrmPrincipal.procAbrirFormulario(AFormClass: TComponentClass);
var
  tcLayoutBase, tcBotaoMenu: TComponent;
begin
  if Assigned(FActiveForm) then
  begin
    if FActiveForm.ClassType = AFormClass then
    begin
      FActiveForm.DisposeOf; // NÃO UTILIZAR FREE
      FActiveForm := Nil;
    end;
  end;

  Application.CreateForm(AFormClass, FActiveForm);

  tcLayoutBase := FActiveForm.FindComponent('lytBase');
  if Assigned(tcLayoutBase) then
    Self.lytPrincipal.AddObject(TLayout(tcLayoutBase));
end;

procedure TfrmPrincipal.procAjsutarLayout;
begin
  tbctrlPrincipal.ActiveTab := tbitemMenu;
  tbctrlPrincipal.TabPosition := TTabPosition.None;
end;

procedure TfrmPrincipal.procMudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  frmPrincipal.actMudarAba.Tab := ATabItem;
  frmPrincipal.actMudarAba.ExecuteTarget(Self);

  if ATabItem = tbitemMenu then
  begin
    if Assigned(FActiveForm) then
    begin
      if FActiveForm.ClassType = TfrmFrequenciaAcademicos then
      begin
        FActiveForm.DisposeOf; // NÃO UTILIZAR FREE
        FActiveForm := Nil;
      end;
    end;
  end;

end;

end.
