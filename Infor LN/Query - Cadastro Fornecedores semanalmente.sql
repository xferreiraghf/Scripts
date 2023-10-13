/* Query - Cadastro de fornecedores */

select a.t$bpid   as "Parceiro",
       a.t$ctit   as "Título",
       a.t$nama   as "Razão social",
       b.t$ftyp$l as "Tipo entidade",
       b.t$fovn$l as "Entidade fiscal",
       b.t$ccty   as "País",
       b.t$cste   as "UF",
       b.t$dsca   as "Cidade",
       b.t$ddd1$c as "DDD",
       b.t$telp   as "Telefone",
       b.t$info   as "E-mail",
       b.t$enfe$l as "E-mail NFE",
       a.t$usid   as "Criado por",
       TO_CHAR(a.t$crdt, 'DD/MM/YYYY') AS "Data criação",
       a.t$code$c as "Cod. status",
       c.t$cbrn   as "Cod. segmento",
       
       decode(a.t$prst,
              2,
              'Ativo',
              3,
              'Inativo',
              4,
              'Suspenso',
              5,
              'Cancelado') as "Status",
       
       CASE
         WHEN a.t$code$c = 1 AND a.t$prst = 2 THEN
          'CLIENTE ATIVO PRÓXIMO (X)'
       
         WHEN a.t$code$c = 1 AND a.t$prst = 5 THEN
          'CLIENTE FECHOU A LOJA (X)'
       
         WHEN a.t$code$c = 2 AND a.t$prst = 2 THEN
          'NAO VAI COMPRAR'
       
         WHEN a.t$code$c = 2 AND a.t$prst = 5 THEN
          'CLIENTE MUDOU DE RAMO. (X)'
       
         WHEN a.t$code$c = 4 AND a.t$prst = 2 THEN
          'INADIMPLENTE'
       
         WHEN a.t$code$c = 4 AND a.t$prst = 5 THEN
          'CLIENTE PROXIMO (X)'
       
         WHEN a.t$code$c = 5 AND a.t$prst = 2 THEN
          'PEDIDO MINIMO MUITO ALTO'
       
         WHEN a.t$code$c = 5 AND a.t$prst = 5 THEN
          'INAPTO NA RECEITA FEDERAL.'
       
         WHEN a.t$code$c = 6 AND a.t$prst = 2 THEN
          'NÃO POSSUI LOJA FÍSICA'
       
         WHEN a.t$code$c = 6 AND a.t$prst = 5 THEN
          'BAIXADO NA RECEITA FEDERAL.'
       
         WHEN a.t$code$c = 9 AND a.t$prst = 2 THEN
          'PROBLEMAS FINANCEIROS'
       
         WHEN a.t$code$c = 9 AND a.t$prst = 5 THEN
          'DESLIGOU-SE DA EMPRESA. (X)'
       
         WHEN a.t$code$c = 41 AND a.t$prst = 2 THEN
          '180 DIAS SEM COMPRA'
       
         WHEN a.t$code$c = 41 AND a.t$prst = 4 THEN
          'FINANCEIRO (RESTRICAO DE CREDITO).'
       
         WHEN a.t$code$c = 2 THEN
          'NAO VAI COMPRAR'
         WHEN a.t$code$c = 2 THEN
          'CLIENTE MUDOU DE RAMO (X)'
         WHEN a.t$code$c = 3 THEN
          'QUERIA INFORMAÇAO'
         WHEN a.t$code$c = 4 THEN
          'INADIMPLENTE'
         WHEN a.t$code$c = 4 THEN
          'CLIENTE PROXIMO (X)'
         WHEN a.t$code$c = 5 THEN
          'PEDIDO MINIMO MUITO ALTO'
         WHEN a.t$code$c = 5 THEN
          'INAPTO NA RECEITA FEDERAL'
         WHEN a.t$code$c = 6 THEN
          'NÃO POSSUI LOJA FÍSICA'
         WHEN a.t$code$c = 6 THEN
          'BAIXADO NA RECEITA FEDERAL'
         WHEN a.t$code$c = 7 THEN
          'SUSPENSO NA RECEITA FEDERAL.'
         WHEN a.t$code$c = 9 THEN
          'PROBLEMAS FINANCEIROS'
         WHEN a.t$code$c = 9 THEN
          'DESLIGOU-SE DA EMPRESA (X)'
         WHEN a.t$code$c = 10 THEN
          'NAO CONVEM COMO CLIENTE (X)'
         WHEN a.t$code$c = 11 THEN
          'SEM RETORNO'
         WHEN a.t$code$c = 11 THEN
          'ATIVO'
         WHEN a.t$code$c = 12 THEN
          'CNPJ DUPLICADO.'
         WHEN a.t$code$c = 13 THEN
          'INATIVO (NÃO ENVIAR P/ TELEVENDAS)'
         WHEN a.t$code$c = 15 THEN
          'ATIVO EXCETO TELEVENDAS'
         WHEN a.t$code$c = 20 THEN
          '2 COLEÇÕES SEM COMPRA'
         WHEN a.t$code$c = 21 THEN
          '3 COLEÇÕES SEM COMPRA'
         WHEN a.t$code$c = 25 THEN
          'SOLICITADO PELO COMERCIAL (X)'
         WHEN a.t$code$c = 30 THEN
          'FALTA DE INF. COMERCIAIS (X)'
         WHEN a.t$code$c = 35 THEN
          'SOLICITADO PELO REPRESENTANTE'
         WHEN a.t$code$c = 37 THEN
          'SEM FATURAMENTO A MAIS DE 365 DIAS'
         WHEN a.t$code$c = 38 THEN
          'OUTROS'
         WHEN a.t$code$c = 39 THEN
          '270 DIAS SEM COMPRA'
         WHEN a.t$code$c = 40 THEN
          'FINANCEIRO (ANTECIPADO NAO PAGO)'
         WHEN a.t$code$c = 41 THEN
          '180 DIAS SEM COMPRA'
         WHEN a.t$code$c = 41 THEN
          'FINANCEIRO (RESTRICAO DE CREDITO)'
         WHEN a.t$code$c = 43 THEN
          'CADASTRO (SINTEGRA, NAO HABILITADO)'
         WHEN a.t$code$c = 44 THEN
          'CADASTRO (SUFRAMA, NAO HABILITADO)'
         WHEN a.t$code$c = 45 THEN
          'COMERCIAL (DESACORDO COML)'
         WHEN a.t$code$c = 46 THEN
          'COMERCIAL (DEVOLUCAO DE MERCADORIA, SEM MOTIVO)'
         WHEN a.t$code$c = 49 THEN
          'CADASTRO (ENDEREÇO DIVERGENTE=RF)'
         WHEN a.t$code$c = 50 THEN
          'CADASTRO (CNPJ NÃO OK PARA GERAÇÃO DO  PIN)'
         WHEN a.t$code$c = 51 THEN
          'NÃO EFETUOU PAGAMENTO IMPOSTO'
         WHEN a.t$code$c = 52 THEN
          'CLIENTE INADIMPLENTE'
         WHEN a.t$code$c = 55 THEN
          'FECHOU LOJA - VERIFICADO/TELEVENDAS'
         WHEN a.t$code$c = 60 THEN
          'MUDOU DE RAMO - VERIFICADO/TELEVENDAS'
         WHEN a.t$code$c = 62 THEN
          'NÃO EFETUOU PAGAMENTO PEDIDO ANTECIPADO'
         WHEN a.t$code$c = 70 THEN
          'PERDAS FINANCEIRAS (X)'
         WHEN a.t$code$c = 72 THEN
          'COMPRA POR OUTRO CNPJ'
         WHEN a.t$code$c = 80 THEN
          'DESISTIU DO PEDIDO'
         WHEN a.t$code$c = 82 THEN
          'NÃO DEVE SER ABORDADO PELO TELEVENDAS'
         WHEN a.t$code$c = 91 THEN
          'NÃO TRABALHA MAIS COMA MARCA (X)'
         WHEN a.t$code$c = 92 THEN
          'STATUS NÃO DEFINIDO (X)'
         WHEN a.t$code$c = 93 THEN
          'DESTINATÁRIO BLOQUEADO NA UF'
         WHEN a.t$code$c = 97 THEN
          'ATIVO PELO TELEVENDAS'
         WHEN a.t$code$c = 98 THEN
          'ATIVO (CONTAS A RECEBER)'
         WHEN a.t$code$c = 99 THEN
          'ATIVO'
         WHEN a.t$code$c = 8 THEN
          'CLIENTE FECHOU A LOJA.'
         WHEN a.t$code$c = 14 THEN
          'CLIENTE MUDOU DE RAMO.'
         WHEN a.t$code$c = 16 THEN
          'CLIENTE PROXIMO'
         WHEN a.t$code$c = 17 THEN
          'DESLIGOU-SE DA EMPRESA.'
         WHEN a.t$code$c = 18 THEN
          'NAO CONVEM COMO CLIENTE.'
         WHEN a.t$code$c = 19 THEN
          'INAPTO NA RECEITA FEDERAL.'
         WHEN a.t$code$c = 22 THEN
          'SOLICITADO PELO COMERCIAL.'
         WHEN a.t$code$c = 23 THEN
          'FALTA DE INF. COMERCIAIS.'
         WHEN a.t$code$c = 24 THEN
          'SUSPENSO NA RECEITA FEDERAL.'
         WHEN a.t$code$c = 31 THEN
          'PERDAS FINANCEIRAS'
         WHEN a.t$code$c = 33 THEN
          'NÃO TRABALHA MAIS COM A MARCA'
         WHEN a.t$code$c = 34 THEN
          'STATUS NÃO DEFINIDO'
       
         ELSE
          null
       END AS "Motivo Status",
       
       decode(c.t$cbrn,
              11001,
              'VAREJO MULTIMARCA',
              11002,
              'MULTIMARCA QUALIFICADO',
              11003,
              'ATACADO (X)',
              11004,
              'REDE ESTRUTURADA',
              11005,
              'REDE DE VALOR',
              11006,
              'MONOMARCA BRANDILI',
              11007,
              'E-COMMERCE (X)',
              11008,
              'EXPORTAÇÃO',
              11009,
              'FRANQUIA',
              11010,
              'DISTRIBUIDOR',
              11011,
              'HIPERMERCADO',
              11012,
              'REPRESENTANTE',
              11013,
              'OUTLET',
              11014,
              'BRANDILI MAIS',
              11015,
              'GOs - GRANDES ORGANIZAÇÕES',
              11016,
              'PESSOA FÍSICA',
              11017,
              'VENDEDOR AUTÔNOMO',
              11018,
              'KEYACCOUNT',
              20000,
              'IMPORTAÇÃO',
              22000,
              'ATACADO',
              22001,
              'REDE',
              22002,
              'SUPERMERCADO',
              22003,
              'E-COMMERCE',
              22004,
              'VAR.MULT.- EMPREENDA BRANDILI',
              22005,
              'VAR.MULT.- LOJA INFANTIL A/B/C',
              22006,
              'VAR.MULT.- LOJA INFANTIL C/D/E',
              22007,
              'VAR.MULT.- LOJA FAMÍLIA A/B/C',
              22008,
              'VAR.MULT.- LOJA FAMÍLIA C/D/E',
              22009,
              'MAGAZINE',
              22010,
              'PORTA A PORTA',
              50000,
              'SEM INFORMAÇÃO',
              60000,
              'FORNECEDOR',
              600010,
              'P.L.',
              70000,
              'FACÇÃO',
              70001,
              'FACÇÃO - NOVO GERFAC',
              70020,
              'FACÇÃO - BORDADO',
              70021,
              'FACÇÃO - ESTAMPA',
              70022,
              'FACÇÃO - LAVANDERIA',
              70023,
              'PROSPECT',
              70024,
              'COMERCIAL EXPORTADORA',
              70025,
              'PREPOSTO',
              70026,
              'FILIAL BRANDILI',
              ' ',
              'FALTA INFORMACAO') as "Segmento"

  from igrppr.ttccom100001 a, /* Parceiros de negócios */
       igrppr.ttccom130001 b, /* Endereços */
       igrppr.ttccom120001 c /* Parceiros de negócios fornecedores */

 where a.t$cadr = b.t$cadr
   and a.t$cadr = c.t$cadr
   and a.t$ctit = '002' /*fornecedor*/
   and a.t$crdt BETWEEN (SELECT SYSDATE FROM DUAL) - 7 AND
       (SELECT SYSDATE FROM DUAL) - 1 /* Busca semana anterior */

 order by TO_CHAR(a.t$crdt, 'DD/MM/YYYY') /* Ordenar por data de criação*/

/* By Ferreira  - Atualizado: 
15/08/2023 -  Formato da data*/
