unit untMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TfrmMensagem = class(TForm)
    lytLogin: TLayout;
    GridLayout1: TGridLayout;
    lytUsuario: TLayout;
    lblMensagem: TLabel;
    GridLayout2: TGridLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    boolCancelou: Boolean;
    boolConfirmou: Boolean;
  end;

var
  frmMensagem: TfrmMensagem;

implementation

{$R *.fmx}

procedure TfrmMensagem.FormCreate(Sender: TObject);
begin
  boolCancelou := False;
  boolConfirmou := False;
end;

procedure TfrmMensagem.SpeedButton1Click(Sender: TObject);
begin
  boolConfirmou := True;
end;

procedure TfrmMensagem.SpeedButton2Click(Sender: TObject);
begin
  boolCancelou := True;
end;

end.
