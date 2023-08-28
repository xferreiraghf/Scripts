/* Query - Cadastros saneados na semana */

SELECT DISTINCT a.t$bpid   AS "Parceiro",
                a.t$ctit   AS "Título",
                a.t$nama   AS "Razão Social",
                b.t$ftyp$l AS "Tipo Entidade",
                b.t$fovn$l AS "Entidade Fiscal",
                b.t$ccty   AS "País",
                b.t$cste   AS "Estado",
                b.t$dsca   AS "Cidade",
                TO_CHAR(a.t$crdt, 'DD/MM/YYYY') AS "Data criação",
                a.t$usid   AS "Cod. criado por",
                TO_CHAR(a.t$arfb$c, 'DD/MM/YYYY') AS "Última consulta RFB",
                TO_CHAR(a.t$astg$c, 'DD/MM/YYYY') AS "Última consulta SINTEGRA",
                a.t$code$c AS "Cod. Status",
                c.t$cbrn   AS "Cod. Segmento",
                d.t$prep$c AS "Cod. representante",
                e.t$dsca   as "Representante",
                
                decode(a.t$prst,
                       
                       1,
                       'Cliente Pontecial',
                       2,
                       'Ativo',
                       3,
                       'Inativo',
                       4,
                       'Suspenso',
                       5,
                       'Cancelado',
                       6,
                       'Prospecto') as "Status",
                
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
                       'R00195',
                       'Sul',
                       'R00165',
                       'Sul',
                       'R00048',
                       'Sul',
                       'R00229',
                       'Sul',
                       'R00219',
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
                       'R00078',
                       'São Paulo',
                       'R00118',
                       'São Paulo',
                       'R00208',
                       'São Paulo',
                       'R00003',
                       'São Paulo',
                       'R00202',
                       'São Paulo',
                       'R00095',
                       'São Paulo',
                       'R00188',
                       'São Paulo',
                       'R00192',
                       'São Paulo',
                       'R00134',
                       'São Paulo',
                       'R00112',
                       'São Paulo',
                       'R00191',
                       'São Paulo',
                       'R00186',
                       'São Paulo',
                       'R00224',
                       'São Paulo',
                       'R00111',
                       'São Paulo',
                       'R00204',
                       'Brás',
                       'R00060',
                       'Brás',
                       'R00058',
                       'Sul',
                       'R00060',
                       'São Paulo',
                       'R00061',
                       'Centro Norte',
                       'R00062',
                       'Nordeste',
                       'R00064',
                       'Exportação',
                       'R00145',
                       'SP Interior',
                       'R00059',
                       'Sudeste',
                       'R00184',
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
                       'Exportação',
                       'R00136',
                       'Exportação',
                       ' ',
                       'Sem informação') as "Regional",
                
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

  FROM igrppr.ttccom100001 a /* Parceiros de negócios */
  JOIN igrppr.ttccom130001 b
    ON a.t$cadr = b.t$cadr /* Endereços */
  JOIN igrppr.ttccom110001 c
    ON a.t$bpid = c.t$ofbp
   AND a.t$cadr = c.t$cadr /* Parceiros de negócios clientes*/
  LEFT JOIN igrppr.ttdzbr003001 d
    ON a.t$bpid = d.t$bpid$c
   AND d.t$ativ$c LIKE '1'
   AND d.t$styp$C LIKE '002' /* Cadastro de Atendimento aos Clientes */
  JOIN igrppr.ttcmcs065001 e
    ON e.t$cwoc = d.t$repr$c /* Departamentos */

 WHERE a.t$arfb$c BETWEEN (SELECT SYSDATE FROM DUAL) - 7 AND
       (SELECT SYSDATE FROM DUAL) - 1
   AND (d.t$bpid$c IS NULL OR d.t$prep$c IS NOT NULL) /* Inclui clientes sem representantes e clientes com representantes */

 ORDER BY TO_CHAR(a.t$arfb$c, 'DD/MM/YYYY') /*  Ordenar por data de saneamento */

/* By Ferreira  - Atualizado: 
14/08/2023 | Adicionado informação de representante, regional e formatação DATA.
11/04/2023 | Alteração realizada nas condições de status, foi gerado novos status para os PNs*/