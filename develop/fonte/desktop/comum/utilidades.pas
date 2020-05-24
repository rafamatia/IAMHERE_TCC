unit utilidades;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics, Vcl.ExtCtrls, Math, Vcl.Mask;

function Idade(dtNasc: TDateTime): String;
function CZeros(nr, t: integer): string;
function DiaSemana(d: TDateTime): String;
function NomedoMes(dData: TDateTime): string;
function VerCgc(entrada: string): boolean;
function GeraCodProd(f, t, p: integer): string;
function Encripta(const S: String; Key: Word): String;
function Decripta(const S: String; Key: Word): String;
function Tempo(t: integer): string;
function nrItensRot(rot: string): integer;
function fixaPath(path: string): string;
function UltDiaUtil(Data: TDateTime): boolean;
function criaArqTx(nomeArq: string): boolean;
function gravaLogs(nomeArq, mens: string): boolean;
function funcValidaCampoRequirido(Edit: TDBEdit; out c_msg: String): boolean;
function funcValidarCampoRequirido(Edit: TDBEdit; out c_msg: String): boolean;

procedure AbreJanela(f: TComponentClass; t: integer);
procedure MDIFechar;
procedure HabMenu(fMenuPrinc: TMainMenu; fMenu: TMenu; rotinas: string);
procedure CarregaRots(tv: TTreeView; rotinas: string);
procedure AtzTree(tv: TTreeView; fMenuPrinc: TMainMenu; fMenu: TMenu);
procedure RegLogo(org, img: string);
procedure Caps(State: boolean);
procedure procHabilitaDesabilitaBotoes(sbBotao: TSpeedButton;
  Habilita: boolean);

// setar foco
procedure procSetaFoco(edCampo: TDBEdit);
procedure procSetaFocoEdit(edCampo: TEdit);
procedure procSetaFocoMaskEdit(edCampo: TMaskEdit);
procedure procSetaFocoDBLookupComboBox(DBLookupComboBox: TDBLookupComboBox);

// setar cor
procedure procSetaCorCampo(DBECampo: TDBEdit; Leitura, Requirido: boolean);
procedure procSetaCorCampoEdit(edEdit: TEdit; Leitura, Requirido: boolean);
procedure procSetaCorCampoMaskEdit(edEdit: TMaskEdit;
  Leitura, Requirido: boolean);
procedure procSetaCorLookupComboBox(DBLookupComboBox: TDBLookupComboBox;
  Leitura, Requirido: boolean);
procedure procSetaCorDBMemo(DBMemo: TDBMemo; Leitura, Requirido: boolean);
procedure procSetaCorDBRadioGroup(DBRadioGroup: TDBRadioGroup;
  Leitura, Requirido: boolean);

procedure procValidaCampoRequirido(Edit: TDBEdit);

function funcValidaCheckeBoxMarcadoFlowPanel(fp_FlowPanel: TFlowPanel;
  b_Validar: boolean = True; b_MarcarTudo: boolean = False): boolean;

procedure procMensagem(c_Mensagem: String; c_TpMensagem: String = 'I';
  c_Titulo: String = '');

function RemoveAcento(const pText: string): string;

function RemoverAcento(aText: string): string;

const
  nulo: Char = Chr(0);
  BkSpc: Char = Chr(8);
  Tab: Char = Chr(9);
  lf: Char = Chr(10);
  Enter: Char = Chr(13);
  Esc: Char = Chr(27);
  Del: Char = Chr(127);
  vlrMaxTimeOut = 300;
  COR_READONLY: TColor = cl3DLight;
  COR_WHITE: TColor = clWhite;
  COR_REQUIRIDO: TColor = clSkyBlue;
  ZERO: integer = 0;
  UM: integer = 1;
  C_MASCARA_VALOR: String = '###,###,##0.00';

var
  p, orgao, logo, chReg: string;
  Resp: boolean;
  bk: TBookmark;
  Reg: TRegistry;

implementation

uses Ufuncoes;

function Idade(dtNasc: TDateTime): String;
Type
  Data = Record
    Ano: Word;
    Mes: Word;
    Dia: Word;
  End;
Const
  Qdm: String = '312831303130313130313031';
Var
  Dth: Data;
  Dtn: Data;
  anos, meses, dias, nrd: Shortint;
  a, m, d: string;
begin
  DecodeDate(Date, Dth.Ano, Dth.Mes, Dth.Dia);
  DecodeDate(dtNasc, Dtn.Ano, Dtn.Mes, Dtn.Dia);
  anos := Dth.Ano - Dtn.Ano;
  if anos = 1 then
    a := ' ano, '
  else
    a := ' anos, ';
  meses := Dth.Mes - Dtn.Mes;
  if meses < 0 then
  begin
    Dec(anos);
    meses := meses + 12;
  end;
  if meses = 1 then
    m := ' mÍs e '
  else
    m := ' meses e ';
  dias := Dth.Dia - Dtn.Dia;
  if dias < 0 then
  begin
    nrd := StrToInt(Copy(Qdm, (Dth.Mes - 1) * 2 - 1, 2));
    if ((Dth.Mes - 1) = 2) and ((Dth.Ano Div 4) = 0) then
    begin
      Inc(nrd);
    end;
    dias := dias + nrd;
    meses := meses - 1;
  end;
  if dias = 1 then
    d := ' dia'
  else
    d := ' dias';
  Result := IntToStr(anos) + a + IntToStr(meses) + m + IntToStr(dias) + d;
end;

function CZeros(nr, t: integer): string;
var
  S: string;
begin
  S := IntToStr(nr);
  while Length(S) < t do
    S := '0' + S;
  Result := S
end;

function DiaSemana(d: TDateTime): String;
var
  dias: Array [1 .. 7] of String;
begin
  dias[1] := 'Domingo';
  dias[2] := 'Segunda';
  dias[3] := 'TerÁa';
  dias[4] := 'Quarta';
  dias[5] := 'Quinta';
  dias[6] := 'Sexta';
  dias[7] := 'S·bado';
  Result := dias[DayOfWeek(d)]
end;

function NomedoMes(dData: TDateTime): string;
var
  nAno, nMes, nDia: Word;
  cMes: array [1 .. 12] of string;
begin
  cMes[01] := 'Janeiro';
  cMes[02] := 'Fevereiro';
  cMes[03] := 'MarÁo';
  cMes[04] := 'Abril';
  cMes[05] := 'Maio';
  cMes[06] := 'Junho';
  cMes[07] := 'Julho';
  cMes[08] := 'Agosto';
  cMes[09] := 'Setembro';
  cMes[10] := 'Outubro';
  cMes[11] := 'Novembro';
  cMes[12] := 'Dezembro';
  DecodeDate(dData, nAno, nMes, nDia);
  if (nMes >= 1) and (nMes < 13) then
    Result := cMes[nMes]
  else
    Result := ''
end;

function VerCgc(entrada: string): boolean;
var
  CPF, CGC: string;
  d1, d2, i, soma: integer;
begin
  CPF := '';
  Resp := False;

  // analisa CPF no formato 999.999.999-00
  if (Length(entrada) = 14) then
  begin
    if (Copy(entrada, 4, 1) + Copy(entrada, 8, 1) + Copy(entrada, 12, 1) = '..-')
    then
    begin
      CPF := Copy(entrada, 1, 3) + Copy(entrada, 5, 3) + Copy(entrada, 9, 3) +
        Copy(entrada, 13, 2);
      Resp := True
    end;

    // comeca a verificacao do digito
    if Resp then
      try
        // 1∞ digito
        soma := 0;
        for i := 1 to 9 do
          Inc(soma, StrToInt(Copy(CPF, 10 - i, 1)) * (i + 1));
        d1 := 11 - (soma mod 11);
        if d1 > 9 then
          d1 := 0;

        // 2∞ digito
        soma := 0;
        for i := 1 to 10 do
          Inc(soma, StrToInt(Copy(CPF, 11 - i, 1)) * (i + 1));
        d2 := 11 - (soma mod 11);
        if d2 > 9 then
          d2 := 0;

        // Checa os dois dÌgitos
        if (d1 = StrToInt(Copy(CPF, 10, 1))) and
          (d2 = StrToInt(Copy(CPF, 11, 1))) then
          Resp := True
        else
          Resp := False;
      except
        Resp := False;
      end;
    VerCgc := Resp
  end
  else if Length(entrada) = 18 then // analisa CGC no formato 99.999.999/9999-00
  begin
    if (Copy(entrada, 3, 1) + Copy(entrada, 7, 1) + Copy(entrada, 11, 1) +
      Copy(entrada, 16, 1) = '../-') then
    begin
      CGC := Copy(entrada, 1, 2) + Copy(entrada, 4, 3) + Copy(entrada, 8, 3) +
        Copy(entrada, 12, 4) + Copy(entrada, 17, 2);
      Resp := True;
    end;

    // comeca a verificacao do digito
    if Resp then
      try
        // 1∞ digito
        soma := 0;
        for i := 1 to 12 do
          try
            begin
              if i < 5 then
                Inc(soma, StrToInt(Copy(CGC, i, 1)) * (6 - i))
              else
                Inc(soma, StrToInt(Copy(CGC, i, 1)) * (14 - i));
            end
          except
            On EConvertError do
            begin
              Resp := False;
              exit
            end
          end;
        d1 := 11 - (soma mod 11);
        if d1 > 9 then
          d1 := 0;

        // 2∞ digito
        soma := 0;
        for i := 1 to 13 do
        begin
          if i < 6 then
            Inc(soma, StrToInt(Copy(CGC, i, 1)) * (7 - i))
          else
            Inc(soma, StrToInt(Copy(CGC, i, 1)) * (15 - i))
        end;
        d2 := 11 - (soma mod 11);
        if d2 > 9 then
          d2 := 0;

        // Checa os dois dÌgitos
        if (d1 = StrToInt(Copy(CGC, 13, 1))) and
          (d2 = StrToInt(Copy(CGC, 14, 1))) then
          Resp := True
        else
          Resp := False;
      except
        Resp := False;
      end;
    VerCgc := Resp;
  end
end;

function GeraCodProd(f, t, p: integer): string;
var
  f1, t1, p1: string;
begin
  FmtStr(f1, '%.3d', [f]);
  FmtStr(t1, '%.3d', [t]);
  FmtStr(p1, '%.4d', [p]);
  Result := f1 + t1 + p1
end;

function Encripta(const S: String; Key: Word): String;
const
  C1 = 52845;
  C2 = 22719;
var
  i: byte;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := Char(byte(S[i]) xor (Key shr 8));
    Key := (byte(Result[i]) + Key) * C1 + C2;
  end;
end;

function Decripta(const S: String; Key: Word): String;
const
  C1 = 52845;
  C2 = 22719;
var
  i: byte;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := Char(byte(S[i]) xor (Key shr 8));
    Key := (byte(S[i]) + Key) * C1 + C2;
  end;
end;

function nrItensRot(rot: string): integer;
var
  i, p, t: integer;
  S: string;
begin
  t := 0;
  for i := 0 to Length(rot) do
  begin
    S := Copy(rot, 1, 2);
    p := pos('|', rot);
    if p > 0 then
    begin
      if S[2] <> '|' then
      begin
        Delete(rot, 1, p);
        p := pos('|', rot);
        Delete(rot, 1, p - 1)
      end
      else
      begin
        Delete(rot, 1, p + 1);
        p := pos('|', rot);
        Delete(rot, 1, p - 1);
      end;
      Inc(t)
    end
  end;
  Result := t;
end;

function Tempo(t: integer): string;
var
  min, seg: integer;
  m, S: string;
begin
  min := t div 60;
  seg := t mod 60;
  if min < 10 then
    m := '0' + IntToStr(min)
  else
    m := IntToStr(min);
  if seg < 10 then
    S := '0' + IntToStr(seg)
  else
    S := IntToStr(seg);
  Result := m + ':' + S
end;

function fixaPath(path: string): string;
begin
  if path[Length(path)] <> '\' then
    Result := path + '\'
  else
    Result := path
end;

function UltDiaUtil(Data: TDateTime): boolean;
var
  Ano, Mes, Dia: Word;
  AuxData: TDateTime;
  DiaSemana: integer;
  d1, d2: string;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  d1 := DateToStr(Data);
  AuxData := EncodeDate(Ano, Mes + 1, 1) - 1;
  d2 := DateToStr(AuxData);
  DiaSemana := DayOfWeek(AuxData);
  Case DiaSemana of
    1:
      AuxData := AuxData - 2;
    7:
      AuxData := AuxData - 1
  end;
  d2 := DateToStr(AuxData);
  if AuxData = Date then
    Result := True
  else
    Result := False
end;

function criaArqTx(nomeArq: string): boolean;
var
  arqTx: TextFile;
begin
  if not FileExists(nomeArq) then
  begin
    try
      AssignFile(arqTx, nomeArq);
      Rewrite(arqTx);
      CloseFile(arqTx);
      Result := True
    except
      Result := True
    end
  end
end;

function gravaLogs(nomeArq, mens: string): boolean;
var
  log: TextFile;
begin
  try
    AssignFile(log, nomeArq);
    if FileExists(nomeArq) then
      Append(log)
    else
      Rewrite(log);
    Writeln(log, mens);
    CloseFile(log);
    FileSetAttr(nomeArq, faSysFile + faHidden);
    Result := True
  except
    Result := False
  end
end;

procedure AbreJanela(f: TComponentClass; t: integer);
var
  i: integer;
begin
  if Application.MainForm.MDIChildCount > 0 then
    for i := 0 to Application.MainForm.MDIChildCount - 1 do
      if Application.MainForm.MDIChildren[i].Tag = t then
        exit;
  f.Create(nil)
end;

procedure MDIFechar;
var
  i: integer;
begin
  for i := Application.MainForm.MDIChildCount - 1 downto 0 do
    Application.MainForm.MDIChildren[i].Close
end;

procedure HabMenu(fMenuPrinc: TMainMenu; fMenu: TMenu; rotinas: string);
var
  i, j, k, nRots, p: integer;
  a, b, S: string;
  mI, mS: TMenuItem;
begin
  for i := 0 to fMenuPrinc.Items.Count - 1 do
  begin
    fMenu.Items[i].enabled := False;
    for j := 0 to fMenuPrinc.Items[i].Count - 1 do
      fMenu.Items[i].Items[j].enabled := False
  end;
  nRots := nrItensRot(rotinas);
  for i := 0 to nRots do
  begin
    a := Copy(rotinas, 1, 2);
    if a[2] <> '|' then
    begin
      Delete(rotinas, 1, 1);
      p := pos('|', rotinas);
      b := Copy(rotinas, 1, p - 1);
      Delete(rotinas, 1, p - 1)
    end
    else
    begin
      Delete(rotinas, 1, 2);
      p := pos('|', rotinas);
      if p > 0 then
        b := Copy(rotinas, 1, p - 1)
      else
        b := rotinas;
      Delete(rotinas, 1, p - 1)
    end;
    for j := 0 to fMenuPrinc.Items.Count - 1 do
    begin
      mI := fMenu.Items[j];
      S := mI.Caption;
      p := pos('&', S);
      if p > 0 then
        Delete(S, p, 1);
      if b = S then
        mI.enabled := True;
      for k := 0 to fMenu.Items[j].Count - 1 do
      begin
        mS := fMenu.Items[j].Items[k];
        S := mS.Caption;
        p := pos('&', S);
        if p > 0 then
          Delete(S, p, 1);
        if b = S then
          mS.enabled := True
      end
    end
  end
end;

procedure CarregaRots(tv: TTreeView; rotinas: string);
var
  a, b, rotz: string;
  p, i, nrRots: integer;
  m, sm: TTreeNode;
begin
  tv.Items.Clear;
  sm := nil;
  sm := tv.Items.Add(sm, 'Rotinas permitidas');
  rotz := rotinas;
  // nr de itens em rotinas
  nrRots := nrItensRot(rotz);
  for i := 0 to nrRots do
  begin
    a := Copy(rotinas, 1, 2);
    if a[2] <> '|' then
    begin
      Delete(rotinas, 1, 1);
      p := pos('|', rotinas);
      b := Copy(rotinas, 1, p - 1);
      if p > 0 then
      begin
        m := tv.Items.AddChild(sm, b);
        tv.Selected := m;
        Delete(rotinas, 1, p - 1)
      end
    end
    else
    begin
      Delete(rotinas, 1, 2);
      p := pos('|', rotinas);
      if p > 0 then
        b := Copy(rotinas, 1, p - 1)
      else
        b := rotinas;
      m := tv.Selected;
      m := tv.Items.AddChild(m, b);
      Delete(rotinas, 1, p - 1)
    end
  end
end;

procedure AtzTree(tv: TTreeView; fMenuPrinc: TMainMenu; fMenu: TMenu);
var
  i, j, p: integer;
  a, b: string;
  mI, mS: TMenuItem;
  n, sn: TTreeNode;
begin
  tv.Items.Clear;
  sn := nil;
  sn := tv.Items.Add(sn, 'Rotinas de Acesso');
  for i := 0 to fMenuPrinc.Items.Count - 1 do
  begin
    mI := fMenu.Items[i];
    a := mI.Caption;
    p := pos('&', a);
    if p > 0 then
      Delete(a, p, 1);
    n := tv.Items.AddChild(sn, a);
    for j := 0 to mI.Count - 1 do
    begin
      mS := mI.Items[j];
      b := mS.Caption;
      p := pos('&', b);
      if p > 0 then
        Delete(b, p, 1);
      if b <> '-' then
        tv.Items.AddChild(n, b);
    end
  end
end;

procedure RegLogo(org, img: string);
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if not Reg.OpenKey(chReg + '\Config', False) then
    begin
      Reg.OpenKey(chReg + '\Config', True); // nome do programa
      Reg.WriteString('Orgao', org);
      Reg.WriteString('Logo', img);
      Reg.CloseKey
    end
  finally
    Reg.Free
  end
end;

procedure Caps(State: boolean);
begin
  if (State and ((GetKeyState(VK_CAPITAL) and 1) = 0)) or
    ((not State) and ((GetKeyState(VK_CAPITAL) and 1) = 1)) then
  begin
    keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
    keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
  end
end;

procedure procHabilitaDesabilitaBotoes(sbBotao: TSpeedButton;
  Habilita: boolean);
begin
  // sbBotao.Enabled := Habilita;
  sbBotao.Visible := Habilita;
end;

procedure procSetaFoco(edCampo: TDBEdit);
begin
  if edCampo.CanFocus then
    edCampo.SetFocus;
end;

procedure procSetaFocoEdit(edCampo: TEdit);
begin
  if edCampo.CanFocus then
    edCampo.SetFocus;
end;

procedure procSetaFocoMaskEdit(edCampo: TMaskEdit);
begin
  if edCampo.CanFocus then
    edCampo.SetFocus;
end;

procedure procSetaFocoDBLookupComboBox(DBLookupComboBox: TDBLookupComboBox);
begin
  if DBLookupComboBox.CanFocus then
    DBLookupComboBox.SetFocus;
end;

procedure procSetaCorCampo(DBECampo: TDBEdit; Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    DBECampo.Color := COR_WHITE
  else if Leitura then
  begin
    DBECampo.Color := COR_READONLY;
    DBECampo.ReadOnly := True;
    DBECampo.Font.Style := DBECampo.Font.Style + [fsBold];
  end
  else if Requirido then
  begin
    DBECampo.Color := COR_REQUIRIDO;
    DBECampo.ReadOnly := False;
  end;
end;

procedure procSetaCorCampoEdit(edEdit: TEdit; Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    edEdit.Color := COR_WHITE
  else if Leitura then
  begin
    edEdit.Color := COR_READONLY;
    edEdit.ReadOnly := True;
    edEdit.Font.Style := edEdit.Font.Style + [fsBold];
  end
  else if Requirido then
  begin
    edEdit.Color := COR_REQUIRIDO;
    edEdit.ReadOnly := False;
  end;
end;

procedure procSetaCorCampoMaskEdit(edEdit: TMaskEdit;
  Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    edEdit.Color := COR_WHITE
  else if Leitura then
  begin
    edEdit.Color := COR_READONLY;
    edEdit.ReadOnly := True;
    edEdit.Font.Style := edEdit.Font.Style + [fsBold];
  end
  else if Requirido then
  begin
    edEdit.Color := COR_REQUIRIDO;
    edEdit.ReadOnly := False;
  end;
end;

procedure procSetaCorLookupComboBox(DBLookupComboBox: TDBLookupComboBox;
  Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    DBLookupComboBox.Color := COR_WHITE
  else if Leitura then
  begin
    DBLookupComboBox.Color := COR_READONLY;
    DBLookupComboBox.ReadOnly := True;
  end
  else if Requirido then
  begin
    DBLookupComboBox.Color := COR_REQUIRIDO;
    DBLookupComboBox.ReadOnly := False;
  end;
end;

procedure procSetaCorDBMemo(DBMemo: TDBMemo; Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    DBMemo.Color := COR_WHITE
  else if Leitura then
  begin
    DBMemo.Color := COR_READONLY;
    DBMemo.ReadOnly := True;
  end
  else if Requirido then
  begin
    DBMemo.Color := COR_REQUIRIDO;
    DBMemo.ReadOnly := False;
  end;
end;

procedure procSetaCorDBRadioGroup(DBRadioGroup: TDBRadioGroup;
  Leitura, Requirido: boolean);
begin
  if Leitura and Requirido then
    DBRadioGroup.Color := COR_WHITE
  else if Leitura then
  begin
    DBRadioGroup.Color := COR_READONLY;
    DBRadioGroup.ReadOnly := True;
  end
  else if Requirido then
  begin
    DBRadioGroup.Color := COR_REQUIRIDO;
    DBRadioGroup.ReadOnly := False;
  end;
end;

procedure procValidaCampoRequirido(Edit: TDBEdit);
begin
  procSetaFoco(Edit);
  if ((Edit.Field.Required) and ((Edit.Field.IsNull) or (Trim(Edit.Field.Text) = EmptyStr) or (Trim(Edit.Text) = EmptyStr))) then
  begin
    procMensagem('O campo ' + Edit.Field.DisplayLabel +
      ' n„o pode ser nulo!', 'A');
    procSetaFoco(Edit);
    Abort;
  end;
end;

function funcValidaCheckeBoxMarcadoFlowPanel(fp_FlowPanel: TFlowPanel;
  b_Validar: boolean = True; b_MarcarTudo: boolean = False): boolean;
var
  i_Index: integer;
  i_Total: integer;
  i_Count: integer;
begin
  Result := True;
  i_Total := ZeroValue;
  i_Count := ZeroValue;

  if b_Validar then
  begin

    i_Total := fp_FlowPanel.ControlCount;

    for i_Index := 0 to pred(fp_FlowPanel.ControlCount) do
    begin
      if (not(TCheckBox(fp_FlowPanel.Controls[i_Index]).Checked)) then
        Inc(i_Count);
    end;

    if (i_Total = i_Count) then
      Result := False;
  end
  else if (b_MarcarTudo) then
  begin
    for i_Index := 0 to pred(fp_FlowPanel.ControlCount) do
    begin
      TCheckBox(fp_FlowPanel.Controls[i_Index]).Checked :=
        (not(TCheckBox(fp_FlowPanel.Controls[i_Index]).Checked));
    end;
  end;
end;

function funcValidaCampoRequirido(Edit: TDBEdit; out c_msg: String): boolean;
begin
  c_msg := EmptyStr;
  Result := True;
  if Edit.Field.IsNull then
  begin
    c_msg := 'O campo ' + Edit.Field.DisplayLabel + ' n„o pode ser nulo!';
    Result := False;
  end;
end;

function funcValidarCampoRequirido(Edit: TDBEdit; out c_msg: String): boolean;
begin
  c_msg := EmptyStr;
  Result := True;
  if Edit.Text = EmptyStr then
  begin
    c_msg := 'O campo ' + Edit.Field.DisplayLabel + ' n„o pode ser nulo!';
    Result := False;
  end;
end;

procedure procMensagem(c_Mensagem, c_TpMensagem, c_Titulo: String);
begin
  if (c_TpMensagem = 'I') then // INFORMA«√O
  begin
    if (c_Titulo = EmptyStr) then
      c_Titulo := 'InformaÁ„o!';

    Application.MessageBox(Pchar(c_Mensagem), Pchar(c_Titulo),
      MB_ICONINFORMATION + mb_ok);
  end
  else if (c_TpMensagem = 'E') then // INFORMA«√O
  begin
    if (c_Titulo = EmptyStr) then
      c_Titulo := 'Erro!';

    Application.MessageBox(Pchar(c_Mensagem), Pchar(c_Titulo),
      MB_ICONERROR + mb_ok);
  end
  else if (c_TpMensagem = 'A') then // AVISO
  begin
    if (c_Titulo = EmptyStr) then
      c_Titulo := 'Aviso!';

    Application.MessageBox(Pchar(c_Mensagem), Pchar(c_Titulo),
      MB_ICONWARNING + mb_ok);
  end;
end;

function RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

function RemoverAcento(aText: string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(aText) do
    try
      if (pos(aText[x], ComAcento) <> 0) then
        aText[x] := SemAcento[pos(aText[x], ComAcento)];
    except
      on E: Exception do
        raise Exception.Create('Erro no processo.');
    end;

  Result := aText;
end;

end.
