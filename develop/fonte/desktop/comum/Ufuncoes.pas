unit Ufuncoes;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics,
  Vcl.ExtCtrls, Math,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, IniFiles;

// RETORNA SE A PESSOA É DO TIPO FISICA OU JURIDICA
function funcSetFisicaJuridica(c_TipoPessoa: String): String;

function funcAjustarCPFCNPJ(c_CPF_CNPJ: String): String;

function funcInsereMascaraCPFCNPJ(c_CPF_CNPJ: String): String;

// ROTINA QUE VERIFICA SE É CPF OU CNPJ OU NENHUM
// RETORNOS : CPF [INDICA QUE O VALOR DIGITADO É CPF]
// CNPJ [INDICA QUE O VALOR DIGITADO É CNPJ]
// N [INDICA QUE O VALOR DIGITADO NÃO É CPF NEM CNPJ]
function funcVerificaCPFCNPJ(c_CPF_CNPJ: String): String;

// VALIDA SE O CPF É VÁLIDO
function funcValidaCPF(c_CPF_CNPJ: String): Boolean;

// VALIDA SE O CNPJ É VÁLIDO
function IsValidCNPJ(pCNPJ: string): Boolean;

// VALIDA SE O CNPJ É VÁLIDO
{ *********************************
  NÃO USAR ESSA FUNÇÃO
  ********************************** }
function funcValidaCNPJ(c_CPF_CNPJ: String): Boolean;
{ ********************************* }
{ ********************************* }

Function Crypt(Action, Src: String): String;

function Encripta(const S: String; Key: Word): String;
function Decripta(const S: String; Key: Word): String;

Function Criptografa(texto: string; chave: integer): String;
Function DesCriptografa(texto: string; chave: integer): String;
function AsciiToInt(Caracter: Char): integer;
function funcObterQuery(ASQL: String = ''): TFDQuery;
function funcOberProximoID(ASequencial: String): integer;

implementation

uses tipos, dmConexao, constantes, dmPessoas, uVariaveisGlobais;
// , UdmPessoas;

function funcSetFisicaJuridica(c_TipoPessoa: String): String;
begin
  Result := c_TipoPessoa;
end;

function AsciiToInt(Caracter: Char): integer;
var
  i: integer;
begin
  i := 32;
  while i < 255 do
  begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

function IsValidCNPJ(pCNPJ: string): Boolean;
var
  v: array [1 .. 2] of Word;
  cnpj: array [1 .. 14] of Byte;
  i: Byte;
begin
  try
    for i := 1 to 14 do
      cnpj[i] := StrToInt(pCNPJ[i]);
    // Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5 * cnpj[1] + 4 * cnpj[2] + 3 * cnpj[3] + 2 * cnpj[4];
    v[1] := v[1] + 9 * cnpj[5] + 8 * cnpj[6] + 7 * cnpj[7] + 6 * cnpj[8];
    v[1] := v[1] + 5 * cnpj[9] + 4 * cnpj[10] + 3 * cnpj[11] + 2 * cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    // Nota: Calcula o segundo dígito de verificação.
    v[2] := 6 * cnpj[1] + 5 * cnpj[2] + 4 * cnpj[3] + 3 * cnpj[4];
    v[2] := v[2] + 2 * cnpj[5] + 9 * cnpj[6] + 8 * cnpj[7] + 7 * cnpj[8];
    v[2] := v[2] + 6 * cnpj[9] + 5 * cnpj[10] + 4 * cnpj[11] + 3 * cnpj[12];
    v[2] := v[2] + 2 * v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);
    // Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except
    on E: Exception do
      Result := False;
  end;
end;

function funcValidaCPF(c_CPF_CNPJ: String): Boolean;
var
  i_n1: integer;
  i_n2: integer;
  i_n3: integer;
  i_n4: integer;
  i_n5: integer;
  i_n6: integer;
  i_n7: integer;
  i_n8: integer;
  i_n9: integer;
  i_d1: integer;
  i_d2: integer;
  c_VlrDigitado: string;
  c_VlrCalculado: string;
begin
  try
    i_n1 := StrToInt(c_CPF_CNPJ[1]);
    i_n2 := StrToInt(c_CPF_CNPJ[2]);
    i_n3 := StrToInt(c_CPF_CNPJ[3]);
    i_n4 := StrToInt(c_CPF_CNPJ[4]);
    i_n5 := StrToInt(c_CPF_CNPJ[5]);
    i_n6 := StrToInt(c_CPF_CNPJ[6]);
    i_n7 := StrToInt(c_CPF_CNPJ[7]);
    i_n8 := StrToInt(c_CPF_CNPJ[8]);
    i_n9 := StrToInt(c_CPF_CNPJ[9]);
  except
    on E: Exception do
      Result := False;
  end;

  i_d1 := i_n9 * 9 + i_n8 * 8 + i_n7 * 7 + i_n6 * 6 + i_n5 * 5 + i_n4 * 4 + i_n3
    * 3 + i_n2 * 2 + i_n1 * 1;

  i_d1 := (i_d1 mod 11);

  if (i_d1 >= 10) then
    i_d1 := ZeroValue;

  i_d2 := i_d1 * 9 + i_n9 * 8 + i_n8 * 7 + i_n7 * 6 + i_n6 * 5 + i_n5 * 4 + i_n4
    * 3 + i_n3 * 2 + i_n2 * 1 + i_n1 * 0;

  i_d2 := (i_d2 mod 11);

  if (i_d2 >= 10) then
    i_d2 := ZeroValue;

  c_VlrCalculado := IntToStr(i_d1) + IntToStr(i_d2);
  c_VlrDigitado := c_CPF_CNPJ[10] + c_CPF_CNPJ[11];

  Result := (c_VlrCalculado = c_VlrDigitado);
end;

function funcValidaCNPJ(c_CPF_CNPJ: String): Boolean;
var
  i_n1: integer;
  i_n2: integer;
  i_n3: integer;
  i_n4: integer;
  i_n5: integer;
  i_n6: integer;
  i_n7: integer;
  i_n8: integer;
  i_n9: integer;
  i_n10: integer;
  i_n11: integer;
  i_n12: integer;
  i_d1: integer;
  i_d2: integer;
  c_VlrDigitado: string;
  c_VlrCalculado: string;
begin
  i_n1 := StrToInt(c_CPF_CNPJ[1]);
  i_n2 := StrToInt(c_CPF_CNPJ[2]);
  i_n3 := StrToInt(c_CPF_CNPJ[3]);
  i_n4 := StrToInt(c_CPF_CNPJ[4]);
  i_n5 := StrToInt(c_CPF_CNPJ[5]);
  i_n6 := StrToInt(c_CPF_CNPJ[6]);
  i_n7 := StrToInt(c_CPF_CNPJ[7]);
  i_n8 := StrToInt(c_CPF_CNPJ[8]);
  i_n9 := StrToInt(c_CPF_CNPJ[9]);
  i_n10 := StrToInt(c_CPF_CNPJ[10]);
  i_n11 := StrToInt(c_CPF_CNPJ[11]);
  i_n12 := StrToInt(c_CPF_CNPJ[12]);

  i_d1 := i_n12 * 6 + i_n11 * 7 + i_n10 * 8 + i_n9 * 9 + i_n8 * 2 + i_n7 * 3 +
    i_n6 * 4 + i_n5 * 5 + i_n4 * 6 + i_n3 * 7 + i_n2 * 8 + i_n1 * 9;

  i_d1 := 11 - (i_d1 mod 11);

  if (i_d1 >= 10) then
    i_d1 := ZeroValue;

  i_d2 := // i_d1  * 5 +
    i_n12 * 6 + i_n11 * 7 + i_n10 * 8 + i_n9 * 9 + i_n8 * 2 + i_n7 * 3 + i_n6 *
    4 + i_n5 * 5 + i_n4 * 6 + i_n3 * 7 + i_n2 * 8 + i_n1 * 9;

  i_d2 := 11 - (i_d2 mod 11);

  if (i_d2 >= 10) then
    i_d2 := ZeroValue;

  c_VlrCalculado := IntToStr(i_d2) + IntToStr(i_d1);
  c_VlrDigitado := c_CPF_CNPJ[13] + c_CPF_CNPJ[14];

  Result := (c_VlrCalculado = c_VlrDigitado);
end;

function funcVerificaCPFCNPJ(c_CPF_CNPJ: String): String;
begin
  Result := 'N';
  if (Length(c_CPF_CNPJ) = 11) then
    Result := 'CPF'
  else if (Length(c_CPF_CNPJ) = 14) then
    Result := 'CNPJ';
end;

function funcAjustarCPFCNPJ(c_CPF_CNPJ: String): String;
var
  c_Auxiliar: String;
begin
  c_Auxiliar := StringReplace(c_CPF_CNPJ, '.', '', [rfReplaceAll]);
  c_Auxiliar := StringReplace(c_Auxiliar, '-', '', [rfReplaceAll]);
  c_Auxiliar := StringReplace(c_Auxiliar, '/', '', [rfReplaceAll]);
  Result := c_Auxiliar;
end;

function funcInsereMascaraCPFCNPJ(c_CPF_CNPJ: String): String;
var
  b_EhCPF: Boolean;
  c_CPF_CNPJ_Ajustado: String;
  c_CPF_CNPJ_Nenhum: String;

  // CNPJ
  C_CNPJ_A: String;
  C_CNPJ_B: String;
  C_CNPJ_C: String;
  C_CNPJ_D: String;
  C_CNPJ_E: String;

  // CPF
  C_CPF_A: String;
  C_CPF_B: String;
  C_CPF_C: String;
  C_CPF_D: String;
begin
  { ********************************* }
  // CNPJ
  // 97.430.003/0001-05
  // 9 7 4 3 0 0 0 3 0 0 0 1 0 5
  // 1 2 3 4 5 6 7 8 9 0 1 2 3 4

  // 97.430.003/0001-05
  // 97   = (C_CNPJ_A)
  // 430  = (C_CNPJ_B)
  // 003  = (C_CNPJ_C)
  // 0001 = (C_CNPJ_D)
  // 05   = (C_CNPJ_E)
  { ********************************* }

  { ********************************* }
  // CPF
  // 597.183.740-00
  // 5 9 7 1 8 3 7 4 0 0 0
  // 1 2 3 4 5 6 7 8 9 0 1

  // 597.183.740-00
  // 597 = (C_CPF_A)
  // 183 = (C_CPF_B)
  // 740 = (C_CPF_C)
  // 00  = (C_CPF_D)
  { ********************************* }

  { *******************************
    INICIALIZAÇÃO RESULT DA FUNÇÃO
    ******************************** }
  Result := 'N';
  { ****************************** }

  { *******************************
    INICIALIZAÇÃO DAS VARIÁVEIS
    ******************************** }
  // CNPJ
  C_CNPJ_A := EmptyStr;
  C_CNPJ_B := EmptyStr;
  C_CNPJ_C := EmptyStr;
  C_CNPJ_D := EmptyStr;
  C_CNPJ_E := EmptyStr;
  // CPF
  C_CPF_A := EmptyStr;
  C_CPF_B := EmptyStr;
  C_CPF_C := EmptyStr;
  C_CPF_D := EmptyStr;
  { ****************************** }

  // AJUSTADO O CPF OU CNPJ (REMOVENDO PONTO, TRAÇO E BARRA)
  c_CPF_CNPJ_Ajustado := funcAjustarCPFCNPJ(c_CPF_CNPJ);

  // VERIFICA SE O CPF AJUSTADO É CPF, CNPJ E NENHUM
  c_CPF_CNPJ_Nenhum := funcVerificaCPFCNPJ(c_CPF_CNPJ_Ajustado);

  // SE FOR NENHUM SAI DA ROTINA
  if (c_CPF_CNPJ_Nenhum = 'N') then
    Exit;

  // SE FOR CPF
  if (c_CPF_CNPJ_Nenhum = 'CPF') then
  begin
    // SE O CPF É INVÁLIDO SAI DA ROTINA
    if (not(funcValidaCPF(c_CPF_CNPJ_Ajustado))) then
      Exit;

    strTipoPessoa := C_TP_PES_FISICA;

    // 597.183.740-00
    // 597 = (C_CPF_A) 1,3
    // 183 = (C_CPF_B) 4,3
    // 740 = (C_CPF_C) 7,3
    // 00  = (C_CPF_D) 10,2
    C_CPF_A := copy(c_CPF_CNPJ_Ajustado, 1, 3);
    C_CPF_B := copy(c_CPF_CNPJ_Ajustado, 4, 3);
    C_CPF_C := copy(c_CPF_CNPJ_Ajustado, 7, 3);
    C_CPF_D := copy(c_CPF_CNPJ_Ajustado, 10, 2);

    // 597.183.740-00  //ADICIONA MASCARA CPF
    Result := C_CPF_A + '.' + C_CPF_B + '.' + C_CPF_C + '-' + C_CPF_D;

  end
  else if (c_CPF_CNPJ_Nenhum = 'CNPJ') then // SE FOR CNPJ
  begin
    // SE O CNPJ É INVÁLIDO SAI DA ROTINA
    if (not(IsValidCNPJ(c_CPF_CNPJ_Ajustado))) then
      Exit;

    strTipoPessoa := C_TP_PES_JURIDICA;

    // 97.430.003/0001-05
    // 97   = (C_CNPJ_A)
    // 430  = (C_CNPJ_B)
    // 003  = (C_CNPJ_C)
    // 0001 = (C_CNPJ_D)
    // 05   = (C_CNPJ_E)
    C_CNPJ_A := copy(c_CPF_CNPJ_Ajustado, 1, 2);
    C_CNPJ_B := copy(c_CPF_CNPJ_Ajustado, 3, 3);
    C_CNPJ_C := copy(c_CPF_CNPJ_Ajustado, 6, 3);
    C_CNPJ_D := copy(c_CPF_CNPJ_Ajustado, 9, 4);
    C_CNPJ_E := copy(c_CPF_CNPJ_Ajustado, 13, 2);

    // 97.430.003/0001-05  //ADICIONA MASCARA CNPJ
    Result := C_CNPJ_A + '.' + C_CNPJ_B + '.' + C_CNPJ_C + '/' + C_CNPJ_D + '-'
      + C_CNPJ_E;
  end;

end;

Function Crypt(Action, Src: String): String;
Label Fim;
var
  KeyLen: integer;
  KeyPos: integer;
  OffSet: integer;
  Dest, Key: String;
  SrcPos: integer;
  SrcAsc: integer;
  TmpSrcAsc: integer;
  Range: integer;
begin
  if (Src = '') Then
  begin
    Result := '';
    Goto Fim;
  end;
  Key := 'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt(copy(Src, 1, 2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt(copy(Src, SrcPos, 2));
      if (KeyPos < KeyLen) Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;
  Result := Dest;
Fim:
end;

function Encripta(const S: String; Key: Word): String;
const
  C1 = 52845;
  C2 = 22719;
var
  i: Byte;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := Char(Byte(S[i]) xor (Key shr 8));
    Key := (Byte(Result[i]) + Key) * C1 + C2;
  end;
end;

function Decripta(const S: String; Key: Word): String;
const
  C1 = 52845;
  C2 = 22719;
var
  i: Byte;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := Char(Byte(S[i]) xor (Key shr 8));
    Key := (Byte(S[i]) + Key) * C1 + C2;
  end;
end;

Function Criptografa(texto: string; chave: integer): String;
var
  cont: integer;
  retorno: string;
begin
  if (trim(texto) = EmptyStr) or (chave = 0) then
    Result := texto
  else
  begin
    retorno := EmptyStr;
    for cont := 1 to Length(texto) do
      retorno := retorno + Chr(AsciiToInt(texto[cont]) + chave);

    Result := retorno;
  end;
end;

Function DesCriptografa(texto: string; chave: integer): String;
var
  cont: integer;
  retorno: string;
begin
  if (trim(texto) = EmptyStr) or (chave = 0) then
  begin
    Result := texto;
  end
  else
  begin
    retorno := '';
    for cont := 1 to Length(texto) do
    begin
      retorno := retorno + Chr(AsciiToInt(texto[cont]) - chave);
    end;
    Result := retorno;
  end;
end;

function funcObterQuery(ASQL: String): TFDQuery;
var
  QryAux: TFDQuery;
begin
  QryAux := TFDQuery.Create(nil);
  QryAux.Connection := dmConexaoBanco.fdcConexaoBancoFB;
  QryAux.Close;
  if (ASQL <> EmptyStr) then
  begin
    QryAux.SQL.Clear;
    QryAux.SQL.Text := ASQL;
    QryAux.Open;
  end;
  Result := QryAux;
end;

function funcOberProximoID(ASequencial: String): integer;
var
  QryAux: TFDQuery;
begin
  QryAux := funcObterQuery('SELECT GEN_ID(' + ASequencial +
    ', 1) PROXIMO_ID FROM RDB$DATABASE;');
  Result := QryAux.FieldByName('PROXIMO_ID').AsInteger;
end;

end.
