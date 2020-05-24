unit tipos;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Graphics;

const

  {SIM / NÃO}
  C_TP_SIM     : String = 'SIM';
  C_TP_NAO     : String = 'NAO';
  C_TP_SIM_S   : String = 'S';
  C_TP_NAO_N   : String = 'N';

  {CADASTRO}
  C_TP_CADASTRO   : String = 'C';
  C_TP_IMPORTACAO : String = 'I';
  C_TP_FABRICACAO : String = 'F';

  {TIPOS DE DOCUMENTO}
  C_TP_BOLETO  : String = 'B';

  {OUTROS}
  C_TP_OUTROS  : String = 'O';

  {ATIVO / INATIVO}
  C_TP_ATIVO   : String = 'A';
  C_TP_INATIVO : String = 'I';

  {TIPOS DE MOVIMENTO}
  C_TP_ENTRADA : String = 'E';
  C_TP_SAIDA   : String = 'S';

  {TIPOS DE PESSOA (PERFIL)}
  C_TP_PES_CLIENTES            : String = 'C';
  C_TP_PES_CLIENTES_DESC       : String = 'CLIENTE';
  C_TP_PES_FUNCIONARIOS        : String = 'F';
  C_TP_PES_FUNCIONARIOS_DESC   : String = 'FUNCIONÁRIO';
  C_TP_PES_FORNECEDORES        : String = 'E';
  C_TP_PES_FORNECEDORES_DESC   : String = 'FORNECEDORES';
  C_TP_PES_SISTEMA             : String = 'S';
  C_TP_PES_SISTEMA_DESC        : String = 'SISTEMA';
  C_TP_PES_TRANSPORTADORA      : String = 'T';
  C_TP_PES_TRANSPORTADORA_DESC : String = 'TRANSPORTADORA';
  C_TP_PES_ALUNO               : String = 'A';
  C_TP_PES_ALUNO_DESC          : String = 'ALUNO';
  C_TP_PES_PROFESSOR           : String = 'P';
  C_TP_PES_PROFESSOR_DESC      : String = 'PROFESSOR';


  {TIPO DE PESSOA}
  C_TP_PES_FISICA   : String = 'F';
  C_TP_PES_JURIDICA : String = 'J';

  {GENÊROS}
  C_TP_GEN_FEMININO  : String = 'F';
  C_TP_GEN_MASCULINO : String = 'M';
  C_TP_GEN_OUTROS    : String = 'O';

  {ESTADOS CIVIS}
  C_TP_ESTIPO_ESTADOCIVIL       : String = 'ECV';
  C_TP_ESTIPO_REGIMEDEBENS      : String = 'RBN';
  C_TP_ESTIPO_FRMEMANCIPACAO    : String = 'FME';
  C_TP_TIPO_SOLTEIRO            : String = 'S';
  C_TP_TIPO_CASADO              : String = 'C';
  C_TP_TIPO_VIUVO               : String = 'V';
  C_TP_TIPO_DIVORCIADO          : String = 'D';
  C_TP_TIPO_SEPARADOJUDI        : String = 'J';
  C_TP_TIPO_COMUNHAOPARCIAL     : String = 'CP';
  C_TP_TIPO_COMUNHAOUNIVERSAL   : String = 'CU';
  C_TP_TIPO_PARTICFINALAQUESTOS : String = 'PFA';
  C_TP_TIPO_SEPARACAOBENS       : String = 'SB';
  C_TP_TIPO_CASAMENTO           : String = 'CAS';
  C_TP_TIPO_ATOJUDICIAL         : String = 'AJ';
  {COLACAO DE GRAU EM CURSO DE ENSINO SUPERIOR}
  C_TP_TIPO_CGES                : String = 'CGES';
  {EXERCICIO DE EMPREGO PUBLICO EFETIVO}
  C_TP_TIPO_EEPE                : String = 'EEPE';
  {ESTABELECIMENTO CIVIL OU COMERCIAL, COM ECONOMIA PROPRIA}
  C_TP_TIPO_ECEP                : String = 'ECEP';
  {EXISTENCIA DE RELACAO DE EMPREGO, COM ECONOMIA PROPRIA}
  C_TP_TIPO_EREP                : String = 'EREP';

  {TIPO DE CORRESPONDECIA DE ENDEREÇO}
  C_TP_END_RESIDENCIAL          : String = 'R';
  C_TP_END_COMERCIAL            : String = 'C';

  {TIPO DE PERFIL DO USUÁRIO
   *** LEMBRETE: NÃO ESQUECER DE POPULAR O CDS TODA VEZ QUE CRIAR UM TIPO NOVO
                 CASO O MESMO NÃO SEJA RESTRITO, COMO POR EXEMPLO O DO SISTEMA
  }
  C_TP_PERFILUSU_ADM            : String = 'ADM'; //ADMINISTRADOR
  C_TP_PERFILUSU_DESCADM        : String = 'ADMINISTRADOR';

  C_TP_PERFILUSU_COM            : String = 'COM'; //COMERCIAL
  C_TP_PERFILUSU_DESCCOM        : String = 'COMERCIAL';

  C_TP_PERFILUSU_GER            : String = 'GER'; //GERENTE
  C_TP_PERFILUSU_DESCGER        : String = 'GERENTE';

  C_TP_PERFILUSU_SIS            : String = 'SIS'; //SISTEMA (UTILIZADO PELOS FUNCIONÁRIOS DA EMPRESA DE DESENVOLVIMENTO)
  C_TP_PERFILUSU_DESCSIS        : String = 'SISTEMA';

  C_TP_PERFILUSU_ATE            : String = 'ATE'; //ATENDENTE
  C_TP_PERFILUSU_DESCATE        : String = 'ATENDENTE';

  C_TP_PERFILUSU_FCX            : String = 'FCX'; //FRENTE DE CAIXA
  C_TP_PERFILUSU_DESCFCX        : String = 'FRENTE DE CAIXA';

  C_TP_PERFILUSU_NOR            : String = 'NOR'; //NORMAL (ACESSO A NADA)
  C_TP_PERFILUSU_DESCNOR        : String = 'NORMAL';

  C_TP_PERFILUSU_FIN            : String = 'FIN';
  C_TP_PERFILUSU_DESCFIN        : String = 'FINANCEIRO';

  I_COD_CIDADE_MANDAGUARI       : Integer = 4114203;
  C_SIGLA_PARANA                : String = 'PR';

  I_COD_PAIS_BRASIL             : Integer = 76;
  C_NOME_PAIS_BRASIL            : String = 'BRASIL';

  c_TP_TD_ANUAL                 : String = 'A';
  c_TP_TD_SEMESTRAL             : String = 'S';
  c_TP_TD_MENSAL                : String = 'M';

  C_TP_PER_MATUTINO             : String = 'M';
  C_TP_PER_VESPERTINO           : String = 'V';
  C_TP_PER_NOTURNO              : String = 'N';

  C_TP_GRAU_GRADUACAO           : String = 'G';
  C_TP_GRAU_POSGRADUACAO        : String = 'P';
  C_TP_GRAU_TECNICO             : String = 'T';
  C_TP_GRAU_MESTRADO            : String = 'M';
  C_TP_GRAU_DOUTORADO           : String = 'D';







implementation


end.
