unit untLogin;

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
  TfrmLogin = class(TForm)
    tbctrlLogin: TTabControl;
    tbitemLogin: TTabItem;
    tbitemMenuPrincipal: TTabItem;
    Rectangle1: TRectangle;
    lytLogin: TLayout;
    GridLayout1: TGridLayout;
    lytUsuario: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Layout1: TLayout;
    Label2: TLabel;
    Edit2: TEdit;
    lytEntrar: TLayout;
    ShadowEffect4: TShadowEffect;
    RoundRect1: TRoundRect;
    lblEntrar: TLabel;
    lytMenuPrincipal: TLayout;
    actAcaoLogin: TActionList;
    mudaraba: TChangeTabAction;
    procedure lblEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FActiveForm: TForm;
    procedure procMudarAba(ATabItem: TTabItem; Sender: TObject);
    procedure procAbrirFormulario(AFormClass: TComponentClass);
    procedure procAjsutarLayout;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses untPrincipal, untDM;
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  procAjsutarLayout;
{$IF DEFINED (ANDROID) || (IOS)}
  DM.fdcConexao.Connected := False;
  DM.fdcConexao.DriverName := 'SQLite';
  DM.fdcConexao.Params.Values['Database'] :=
    TPath.Combine(TPath.GetDocumentsPath, 'dbmobile.db');
  DM.fdcConexao.Connected := True;
{$ENDIF}
end;

procedure TfrmLogin.lblEntrarClick(Sender: TObject);
begin
//  procAbrirFormulario(TfrmPrincipal);
//  procMudarAba(tbitemMenuPrincipal, Sender);
//  frmLogin.DisposeOf;
//  frmLogin := nil;
  //        FActiveForm.DisposeOf; // NÃO UTILIZAR FREE
  //      FActiveForm := Nil;
 // FreeAndNil(frmLogin);
  // try
   frmPrincipal := TfrmPrincipal.Create(Application);
   frmPrincipal.Show;
  // finally
  // FreeAndNil(frmPrincipal);
  // end;
end;

procedure TfrmLogin.procAbrirFormulario(AFormClass: TComponentClass);
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

  tcLayoutBase := FActiveForm.FindComponent('lytMenuPrinc');
  if Assigned(tcLayoutBase) then
    lytMenuPrincipal.AddObject(TLayout(tcLayoutBase));
end;

procedure TfrmLogin.procAjsutarLayout;
begin
  tbctrlLogin.ActiveTab := tbitemLogin;
  tbctrlLogin.TabPosition := TTabPosition.None;
end;

procedure TfrmLogin.procMudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  mudaraba.Tab := ATabItem;
  mudaraba.ExecuteTarget(Sender);

  if ATabItem = tbitemLogin then
  begin
    if Assigned(FActiveForm) then
    begin
      if FActiveForm.ClassType = TfrmPrincipal then
      begin
        FActiveForm.DisposeOf; // NÃO UTILIZAR FREE
        FActiveForm := Nil;
      end;
    end;
  end;
end;

end.
