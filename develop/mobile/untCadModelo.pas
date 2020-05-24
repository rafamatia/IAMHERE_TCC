unit untCadModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation, System.Actions,
  FMX.ActnList, FMX.Effects, FMX.Objects;

type
  TfrmCadModelo = class(TForm)
    lytBase: TLayout;
    tbctrlPrincipal: TTabControl;
    tbitemListagem: TTabItem;
    tbitemEdicao: TTabItem;
    toolSuperior: TToolBar;
    btnVoltar: TSpeedButton;
    lblTitulo: TLabel;
    ActionList1: TActionList;
    actMudarAba: TChangeTabAction;
    lytSuperior: TLayout;
    rctNomeInstituicao: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout2: TLayout;
    blNomeInstituicao: TLabel;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    lytInferior: TLayout;
    Rectangle3: TRectangle;
    Layout5: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure procMudarAba(ATabItem: TTabItem; Sender: TObject);
  end;

var
  frmCadModelo: TfrmCadModelo;

implementation

{$R *.fmx}

uses untPrincipal;

procedure TfrmCadModelo.btnVoltarClick(Sender: TObject);
begin
  //frmPrincipal.procAbrirFormulario(TfrmPrincipal);
  frmPrincipal.procMudarAba(frmPrincipal.tbitemMenu, Sender);
end;

procedure TfrmCadModelo.FormCreate(Sender: TObject);
begin
  tbctrlPrincipal.ActiveTab := tbitemListagem;
  tbctrlPrincipal.TabPosition := TTabPosition.None;
end;

procedure TfrmCadModelo.procMudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actMudarAba.Tab := ATabItem;
  actMudarAba.ExecuteTarget(Sender);
end;

end.
