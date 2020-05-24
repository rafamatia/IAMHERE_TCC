unit untCadDepartamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untCadModelo, FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Actions, FMX.ActnList, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  MultiDetailAppearanceU, FMX.Bind.Grid, FMX.Grid.Style, FMX.ScrollBox,
  FMX.Grid, Data.Bind.Grid, FMX.Effects, FMX.Objects;

type
  TfrmCadDepartamentos = class(TfrmCadModelo)
    lsviewListaDepartamentos: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ToolBar1: TToolBar;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    ToolBar2: TToolBar;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure lsviewListaDepartamentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDepartamentos: TfrmCadDepartamentos;

implementation

{$R *.fmx}

uses untDM;

procedure TfrmCadDepartamentos.lsviewListaDepartamentosItemClick
  (const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  try
      AItem.Checked := (not (AItem.Checked));
      AItem.Objects.AccessoryObject.Visible := AItem.Checked;
  finally
  end;
end;

end.
