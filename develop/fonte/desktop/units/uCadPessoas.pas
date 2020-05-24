unit uCadPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadPessoas = class(TcManuPadrao)
    pnlDados: TPanel;
    PageControl1: TPageControl;
    tsProfessorHorario: TTabSheet;
    tsAcademicoGrade: TTabSheet;
    tsCredencialAcesso: TTabSheet;
    tsAcademicoFrequencia: TTabSheet;
    pnlBotoesGradeCurso: TPanel;
    sbNovoProfHor: TSpeedButton;
    sbAlterarProfHor: TSpeedButton;
    sbExcluirProfHor: TSpeedButton;
    DBG_ProfessorHorario: TDBGrid;
    DBG_AcademicoGrade: TDBGrid;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    DBGrid4: TDBGrid;
    Panel5: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label1: TLabel;
    DBE_PES_CODIGO: TDBEdit;
    Label2: TLabel;
    DBE_PES_CPFCNPJ: TDBEdit;
    Label3: TLabel;
    DBE_PES_NOMECOMPLETO: TDBEdit;
    DBR_PES_TIPOPESSOA: TDBRadioGroup;
    dtPES_DATANASCIMENTO: TDateTimePicker;
    Label5: TLabel;
    DBR_PES_TIPO: TDBRadioGroup;
    procedure DBE_PES_CPFCNPJExit(Sender: TObject);
  private
    { Private declarations }
    strCPF_CNPJ: String;
    boolPesFisica: Boolean;

    { ROTINA QUE REALIZA A ATUALIZAÇÃO DOS CAMPOS
      CPF / CNPJ
      TIPO DE PESSOA [FISICA / JURIDICA]
    }
    procedure procAtualizaCampoCPFCNPJ_TipoPessoa;
    procedure procInicializacaoCampos;

  public
    { Public declarations }
  end;

var
  frmCadPessoas: TfrmCadPessoas;

implementation

{$R *.dfm}

uses dmPessoas, Ufuncoes, utilidades, constantes, uVariaveisGlobais, tipos;

procedure TfrmCadPessoas.DBE_PES_CPFCNPJExit(Sender: TObject);
begin
  inherited;
  if DBE_PES_CPFCNPJ.ReadOnly then
    Exit;

  if (DBE_PES_CPFCNPJ.Text = EmptyStr) then
  begin
    utilidades.procSetaFoco(DBE_PES_CPFCNPJ);
    raise Exception.Create('O campo CPF/CNPJ da Pessoa não pode ser nulo!');
  end;

  strCPF_CNPJ := funcInsereMascaraCPFCNPJ(DBE_PES_CPFCNPJ.Text);
  if strCPF_CNPJ = 'N' then
  begin
    utilidades.procSetaFoco(DBE_PES_CPFCNPJ);
    raise Exception.Create('CPF ou CNPJ Inválido!' + sLineBreak +
      'Verifique os dados informados e tente novamente!');
  end;

  if dmPessoa.funcPessoaEstaCadastrada(strCPF_CNPJ) then
  begin
    utilidades.procSetaFoco(DBE_PES_CPFCNPJ);
    raise Exception.Create('Este CPF/CNPJ já está sendo utilizando!' +
      sLineBreak + 'Verifique o CPF/CNPJ informado e tente novamente!');
  end;

  procAtualizaCampoCPFCNPJ_TipoPessoa;
end;

procedure TfrmCadPessoas.procAtualizaCampoCPFCNPJ_TipoPessoa;
begin
  if DBE_PES_CPFCNPJ.ReadOnly then
    Exit;

  boolPesFisica := (strTipoPessoa = C_TP_PES_FISICA);
  dmPessoa.qryPessoasPES_CPFCNPJ.AsString := strCPF_CNPJ;
  dmPessoa.qryPessoasPES_TIPOPESSOA.AsString := strTipoPessoa;
end;

procedure TfrmCadPessoas.procInicializacaoCampos;
begin
  // FOCO NO CAMPO INICIAL
  procSetaFoco(DBE_PES_CPFCNPJ);

  // CAMPOS BLOQUEADOS
  procSetaCorCampo(DBE_PES_CODIGO, True, False);

  // CAMPOS OBRIGATÓRIOS
  procSetaCorCampo(DBE_PES_CPFCNPJ, False, True);
  procSetaCorCampo(DBE_PES_NOMECOMPLETO, False, True);
  procSetaCorCampo(DBE_PES_CODIGO, False, True);

  if (dmPessoa.qryPessoas.State in [dsEdit]) then
  begin
    procSetaCorCampo(DBE_PES_CPFCNPJ, True, False);
    procSetaFoco(DBE_PES_NOMECOMPLETO);
  end;
end;

end.
