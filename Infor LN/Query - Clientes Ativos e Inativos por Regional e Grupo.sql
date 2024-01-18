/* Query - Clientes ativos e Inativos por Regional e Grupo */

select 
a.t$bpid as "Parceiro",
a.t$ctit as "T�tulo",
a.t$nama as "Raz�o Social",
b.t$ftyp$l as "Tipo Entidade",
b.t$fovn$l as "Entidade Fiscal",
b.t$ccty as "Pa�s",
b.t$cste as "Estado",
b.t$dsca as "Cidade",
TO_CHAR(a.t$crdt, 'DD/MM/YYYY') AS "Data cria��o",
a.t$usid as "C�d.criado por",
TO_CHAR(a.t$arfb$c, 'DD/MM/YYYY') AS "�ltima consulta RFB",
TO_CHAR(a.t$astg$c, 'DD/MM/YYYY') AS "�ltima consulta SINTEGRA",
a.t$code$c as "Cod.Status",
c.t$cbrn as "Cod.Segmento",
d.t$repr$c as "C�d.Rep",
e.t$dsca   as "Representante",
f.t$cogr$c as "Cod.Grupo",
t$desc$c as "Descri��o Grupo",

decode(a.t$prst,

  1, 'Cliente Pontecial',
  2, 'Ativo',
  3, 'Inativo',
  4, 'Suspenso',
  5, 'Cancelado',
  6, 'Prospecto') as "Status",
  
  
decode(d.t$repr$c,
              'R00035',
              'Sul',
              'R00158',
              'Sul',
              'R00159',
              'Sul',
              'R00038',
              'Sul',
              'R00126',
              'Sul',
              'R00036',
              'Sul',
              'R00032',
              'Sul',
              'R00129',
              'Sul',
              'R00203',
              'Sul',
              'R00201',
              'Sul',
              'R00040',
              'Sul',
              'R00072',
              'Sul',
              'R00041',
              'Sul',
              'R00232',
              'Sul',
              'R00165',
              'Sul',
              'R00048',
              'Sul',
              'R00229',
              'Sul',
              'R00219',
              'Sul',
              'R00058',
              'Sul',
              'R00149',
              'Centro',
              'R00223',
              'Centro',
              'R00050',
              'Centro',
              'R00225',
              'Centro',
              'R00226',
              'Centro',
              'R00198',
              'Centro',
              'R00077',
              'Centro',
              'R00199',
              'Centro',
              'R00197',
              'Centro',
              'R00215',
              'Centro',
              'R00205',
              'Centro',
              'R00210',
              'Centro',
              'R00211',
              'Centro',
              'R00087',
              'Centro',
              'R00163',
              'Centro',
              'R00216',
              'Centro',
              'R00214',
              'Centro',
              'R00103',
              'Centro',
              'R00061',
              'Norte/Nordeste',
              'R00051',
              'Norte/Nordeste',
              'R00092',
              'Norte/Nordeste',
              'R00133',
              'Norte/Nordeste',
              'R00193',
              'Norte/Nordeste',
              'R00140',
              'Norte/Nordeste',
              'R00012',
              'Norte/Nordeste',
              'R00120',
              'Norte/Nordeste',
              'R00206',
              'Norte/Nordeste',
              'R00123',
              'Norte/Nordeste',
              'R00013',
              'Norte/Nordeste',
              'R00227',
              'Norte/Nordeste',
              'R00213',
              'Norte/Nordeste',
              'R00209',
              'Norte/Nordeste',
              'R00062',
              'S�o Paulo',
              'R00078',
              'S�o Paulo',
              'R00118',
              'S�o Paulo',
              'R00208',
              'S�o Paulo',
              'R00003',
              'S�o Paulo',
              'R00202',
              'S�o Paulo',
              'R00095',
              'S�o Paulo',
              'R00188',
              'S�o Paulo',
              'R00192',
              'S�o Paulo',
              'R00134',
              'S�o Paulo',
              'R00112',
              'S�o Paulo',
              'R00191',
              'S�o Paulo',
              'R00186',
              'S�o Paulo',
              'R00224',
              'S�o Paulo',
              'R00111',
              'S�o Paulo',
              'R00060',
              'Br�s',
              'R00204',
              'Exporta��o',
              'R00064',
              'Key Account',
              'R00079',
              'Key Account',
              'R00063',
              'Direto',
              'R99999',
              'Direto',
              'R00127',
              'Direto',
              'R99996',
              'Direto',
              'R00196',
              'PL',
              'R00056',
              ' ',
              'Sem informa��o') as "Regional",


  
CASE 
  WHEN a.t$code$c = 1
   AND a.t$prst = 2 THEN 'CLIENTE ATIVO PR�XIMO (X)'
   
  WHEN a.t$code$c = 1
   AND a.t$prst = 5 THEN 'CLIENTE FECHOU A LOJA (X)'
   
  WHEN a.t$code$c = 2
   AND a.t$prst = 2 THEN 'NAO VAI COMPRAR'
   
  WHEN a.t$code$c = 2
   AND a.t$prst = 5 THEN 'CLIENTE MUDOU DE RAMO. (X)'   
   
  WHEN a.t$code$c = 4
   AND a.t$prst = 2 THEN 'INADIMPLENTE'
   
  WHEN a.t$code$c = 4
   AND a.t$prst = 5 THEN 'CLIENTE PROXIMO (X)'

  WHEN a.t$code$c = 5
   AND a.t$prst = 2 THEN 'PEDIDO MINIMO MUITO ALTO'
   
  WHEN a.t$code$c = 5
   AND a.t$prst = 5 THEN 'INAPTO NA RECEITA FEDERAL.'
   
  WHEN a.t$code$c = 6
   AND a.t$prst = 2 THEN 'N�O POSSUI LOJA F�SICA'
   
  WHEN a.t$code$c = 6
   AND a.t$prst = 5 THEN 'BAIXADO NA RECEITA FEDERAL.'  
   
  WHEN a.t$code$c = 9
   AND a.t$prst = 2 THEN 'PROBLEMAS FINANCEIROS'
   
  WHEN a.t$code$c = 9
   AND a.t$prst = 5 THEN 'DESLIGOU-SE DA EMPRESA. (X)'
   
  WHEN a.t$code$c = 41
   AND a.t$prst = 2 THEN '180 DIAS SEM COMPRA'
   
  WHEN a.t$code$c = 41
   AND a.t$prst = 4 THEN 'FINANCEIRO (RESTRICAO DE CREDITO).'   
   
   
  WHEN a.t$code$c = 2  THEN 'NAO VAI COMPRAR'
  WHEN a.t$code$c = 2  THEN 'CLIENTE MUDOU DE RAMO (X)'
  WHEN a.t$code$c = 3  THEN 'QUERIA INFORMA�AO'
  WHEN a.t$code$c = 4  THEN 'INADIMPLENTE'
  WHEN a.t$code$c = 4  THEN 'CLIENTE PROXIMO (X)'
  WHEN a.t$code$c = 5  THEN 'PEDIDO MINIMO MUITO ALTO'
  WHEN a.t$code$c = 5  THEN 'INAPTO NA RECEITA FEDERAL'
  WHEN a.t$code$c = 6  THEN 'N�O POSSUI LOJA F�SICA'
  WHEN a.t$code$c = 6  THEN 'BAIXADO NA RECEITA FEDERAL'
  WHEN a.t$code$c = 9  THEN 'PROBLEMAS FINANCEIROS'
  WHEN a.t$code$c = 9  THEN 'DESLIGOU-SE DA EMPRESA (X)'
  WHEN a.t$code$c = 10 THEN 'NAO CONVEM COMO CLIENTE (X)'
  WHEN a.t$code$c = 11 THEN 'SEM RETORNO'
  WHEN a.t$code$c = 11 THEN 'ATIVO'
  WHEN a.t$code$c = 12 THEN 'CNPJ DUPLICADO.' 
  WHEN a.t$code$c = 13 THEN 'INATIVO (N�O ENVIAR P/ TELEVENDAS)'
  WHEN a.t$code$c = 15 THEN 'ATIVO EXCETO TELEVENDAS'
  WHEN a.t$code$c = 20 THEN '2 COLE��ES SEM COMPRA'
  WHEN a.t$code$c = 21 THEN '3 COLE��ES SEM COMPRA'
  WHEN a.t$code$c = 25 THEN 'SOLICITADO PELO COMERCIAL (X)'
  WHEN a.t$code$c = 30 THEN 'FALTA DE INF. COMERCIAIS (X)'
  WHEN a.t$code$c = 35 THEN 'SOLICITADO PELO REPRESENTANTE'
  WHEN a.t$code$c = 37 THEN 'SEM FATURAMENTO A MAIS DE 365 DIAS'
  WHEN a.t$code$c = 38 THEN 'OUTROS'
  WHEN a.t$code$c = 39 THEN '270 DIAS SEM COMPRA'
  WHEN a.t$code$c = 40 THEN 'FINANCEIRO (ANTECIPADO NAO PAGO)'
  WHEN a.t$code$c = 41 THEN '180 DIAS SEM COMPRA'
  WHEN a.t$code$c = 41 THEN 'FINANCEIRO (RESTRICAO DE CREDITO)'
  WHEN a.t$code$c = 43 THEN 'CADASTRO (SINTEGRA, NAO HABILITADO)'
  WHEN a.t$code$c = 44 THEN 'CADASTRO (SUFRAMA, NAO HABILITADO)'
  WHEN a.t$code$c = 45 THEN 'COMERCIAL (DESACORDO COML)'
  WHEN a.t$code$c = 46 THEN 'COMERCIAL (DEVOLUCAO DE MERCADORIA, SEM MOTIVO)'
  WHEN a.t$code$c = 49 THEN 'CADASTRO (ENDERE�O DIVERGENTE=RF)'
  WHEN a.t$code$c = 50 THEN 'CADASTRO (CNPJ N�O OK PARA GERA��O DO  PIN)'
  WHEN a.t$code$c = 51 THEN 'N�O EFETUOU PAGAMENTO IMPOSTO'
  WHEN a.t$code$c = 52 THEN 'CLIENTE INADIMPLENTE'
  WHEN a.t$code$c = 55 THEN 'FECHOU LOJA - VERIFICADO/TELEVENDAS'
  WHEN a.t$code$c = 60 THEN 'MUDOU DE RAMO - VERIFICADO/TELEVENDAS'
  WHEN a.t$code$c = 62 THEN 'N�O EFETUOU PAGAMENTO PEDIDO ANTECIPADO'
  WHEN a.t$code$c = 70 THEN 'PERDAS FINANCEIRAS (X)'
  WHEN a.t$code$c = 72 THEN 'COMPRA POR OUTRO CNPJ'
  WHEN a.t$code$c = 80 THEN 'DESISTIU DO PEDIDO'
  WHEN a.t$code$c = 82 THEN 'N�O DEVE SER ABORDADO PELO TELEVENDAS'
  WHEN a.t$code$c = 91 THEN 'N�O TRABALHA MAIS COMA MARCA (X)'
  WHEN a.t$code$c = 92 THEN 'STATUS N�O DEFINIDO (X)'
  WHEN a.t$code$c = 93 THEN 'DESTINAT�RIO BLOQUEADO NA UF'
  WHEN a.t$code$c = 97 THEN 'ATIVO PELO TELEVENDAS'
  WHEN a.t$code$c = 98 THEN 'ATIVO (CONTAS A RECEBER)'
  WHEN a.t$code$c = 99 THEN 'ATIVO'
  WHEN a.t$code$c = 8 THEN 'CLIENTE FECHOU A LOJA.'
  WHEN a.t$code$c = 14 THEN 'CLIENTE MUDOU DE RAMO.'
  WHEN a.t$code$c = 16 THEN 'CLIENTE PROXIMO'
  WHEN a.t$code$c = 17 THEN 'DESLIGOU-SE DA EMPRESA.'
  WHEN a.t$code$c = 18 THEN 'NAO CONVEM COMO CLIENTE.'
  WHEN a.t$code$c = 22 THEN 'SOLICITADO PELO COMERCIAL.'
  WHEN a.t$code$c = 23 THEN 'FALTA DE INF. COMERCIAIS.'
  WHEN a.t$code$c = 31 THEN 'PERDAS FINANCEIRAS'
  WHEN a.t$code$c = 33 THEN 'N�O TRABALHA MAIS COM A MARCA'
  WHEN a.t$code$c = 34 THEN 'STATUS N�O DEFINIDO'
      
       ELSE null
     END AS "Motivo Status",
   
  
decode (c.t$cbrn, 
11001, 'VAREJO MULTIMARCA',
11002, 'MULTIMARCA QUALIFICADO',
11003, 'ATACADO (X)',
11004, 'REDE ESTRUTURADA',
11005, 'REDE DE VALOR',
11006, 'MONOMARCA BRANDILI',
11007, 'E-COMMERCE (X)',
11008, 'EXPORTA��O',
11009, 'FRANQUIA',
11010, 'DISTRIBUIDOR',
11011, 'HIPERMERCADO',
11012, 'REPRESENTANTE',
11013, 'OUTLET',
11014, 'BRANDILI MAIS',
11015, 'GOs - GRANDES ORGANIZA��ES',
11016, 'PESSOA F�SICA',
11017, 'VENDEDOR AUT�NOMO',
11018, 'KEYACCOUNT',
20000, 'IMPORTA��O',
22000, 'ATACADO',
22001, 'REDE',
22002, 'SUPERMERCADO',
22003, 'E-COMMERCE',
22004, 'VAR.MULT.- EMPREENDA BRANDILI',
22005, 'VAR.MULT.- LOJA INFANTIL A/B/C',
22006, 'VAR.MULT.- LOJA INFANTIL C/D/E',
22007, 'VAR.MULT.- LOJA FAM�LIA A/B/C',
22008, 'VAR.MULT.- LOJA FAM�LIA C/D/E',
22009, 'MAGAZINE',
22010, 'PORTA A PORTA',
50000, 'SEM INFORMA��O',
60000, 'FORNECEDOR',
600010, 'P.L.',
70000, 'FAC��O',
70001, 'FAC��O - NOVO GERFAC',
70020, 'FAC��O - BORDADO',
70021, 'FAC��O - ESTAMPA',
70022, 'FAC��O - LAVANDERIA',
70023, 'PROSPECT',
70024, 'COMERCIAL EXPORTADORA',
70025, 'PREPOSTO',
70026, 'FILIAL BRANDILI',
' ',   'FALTA INFORMACAO'
) as "Segmento"   
   
   
from 
     igrppr.ttccom100001 a
     INNER JOIN igrppr.ttccom130001 b ON a.t$cadr = b.t$cadr
     INNER JOIN igrppr.ttccom110001 c ON a.t$bpid = c.t$ofbp and a.t$cadr = c.t$cadr
     INNER JOIN igrppr.ttdzbr003001 d ON d.t$bpid$c = a.t$bpid
     INNER JOIN igrppr.ttcmcs065001 e ON e.t$cwoc = d.t$repr$c
     LEFT JOIN igrppr.ttdzbr002001 f ON a.t$bpid = f.t$bpid$c
     LEFT JOIN igrppr.ttdzbr030001 g ON f.t$cogr$c = g.t$cogr$c

where 
  d.t$ativ$c like '1'         /* Busca apenas Representantes Ativos */
  and a.t$ctit like '001'     /* Buscar apenas por Clientes */
  and a.t$prst in ('2','3')   /* Buscar apenas pelo Status do Parceiro */
  and d.t$styp$C like '002'   /* Confec��o */
  and (f.t$cogr$c like 'GC%' or f.t$cogr$c is null)  /* Incluindo clientes sem grupo */

order by a.t$bpid;

/* By Ferreira */