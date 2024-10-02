/* QUERY - Clientes Prospects */

SELECT 
pn.t$bpid AS "Parceiro",
pn.t$ctit AS "Título",
pn.t$nama AS "Razão social",
ad.t$ftyp$l AS "Tipo entidade",
ad.t$fovn$l AS "Entidade",
ad.t$cste AS "UF",
ad.t$dsca AS "Cidade",
ad.t$ddd1$c AS "DDD",
ad.t$telp AS "Telefone",
ad.t$info AS "E-mail principal",
ad.t$enfe$l AS "E-mail NFE",
pc.t$cbrn AS "Cod. segmento",
pn.t$code$c AS "Cod. status",
        DECODE(pn.t$prst,
        2, 'Ativo',
        3, 'Inativo',
        4, 'Suspenso',
        5, 'Cancelado'
        ) AS "Status",
        
 CASE 
  WHEN pn.t$code$c = 1
   AND pn.t$prst = 2 THEN 'CLIENTE ATIVO PRÓXIMO (X)'
   
  WHEN pn.t$code$c = 1
   AND pn.t$prst = 5 THEN 'CLIENTE FECHOU A LOJA (X)'
   
  WHEN pn.t$code$c = 2
   AND pn.t$prst = 2 THEN 'NAO VAI COMPRAR'
   
  WHEN pn.t$code$c = 2
   AND pn.t$prst = 5 THEN 'CLIENTE MUDOU DE RAMO. (X)'   
   
  WHEN pn.t$code$c = 4
   AND pn.t$prst = 2 THEN 'INADIMPLENTE'
   
  WHEN pn.t$code$c = 4
   AND pn.t$prst = 5 THEN 'CLIENTE PROXIMO (X)'

  WHEN pn.t$code$c = 5
   AND pn.t$prst = 2 THEN 'PEDIDO MINIMO MUITO ALTO'
   
  WHEN pn.t$code$c = 5
   AND pn.t$prst = 5 THEN 'INAPTO NA RECEITA FEDERAL.'
   
  WHEN pn.t$code$c = 6
   AND pn.t$prst = 2 THEN 'NÃO POSSUI LOJA FÍSICA'
   
  WHEN pn.t$code$c = 6
   AND pn.t$prst = 5 THEN 'BAIXADO NA RECEITA FEDERAL.'  
   
  WHEN pn.t$code$c = 9
   AND pn.t$prst = 2 THEN 'PROBLEMAS FINANCEIROS'
   
  WHEN pn.t$code$c = 9
   AND pn.t$prst = 5 THEN 'DESLIGOU-SE DA EMPRESA. (X)'
   
  WHEN pn.t$code$c = 41
   AND pn.t$prst = 2 THEN '180 DIAS SEM COMPRA'
   
  WHEN pn.t$code$c = 41
   AND pn.t$prst = 4 THEN 'FINANCEIRO (RESTRICAO DE CREDITO).'   
   
   
  WHEN pn.t$code$c = 2  THEN 'NAO VAI COMPRAR'
  WHEN pn.t$code$c = 2  THEN 'CLIENTE MUDOU DE RAMO (X)'
  WHEN pn.t$code$c = 3  THEN 'QUERIA INFORMAÇAO'
  WHEN pn.t$code$c = 4  THEN 'INADIMPLENTE'
  WHEN pn.t$code$c = 4  THEN 'CLIENTE PROXIMO (X)'
  WHEN pn.t$code$c = 5  THEN 'PEDIDO MINIMO MUITO ALTO'
  WHEN pn.t$code$c = 5  THEN 'INAPTO NA RECEITA FEDERAL'
  WHEN pn.t$code$c = 6  THEN 'NÃO POSSUI LOJA FÍSICA'
  WHEN pn.t$code$c = 6  THEN 'BAIXADO NA RECEITA FEDERAL'
  WHEN pn.t$code$c = 9  THEN 'PROBLEMAS FINANCEIROS'
  WHEN pn.t$code$c = 9  THEN 'DESLIGOU-SE DA EMPRESA (X)'
  WHEN pn.t$code$c = 10 THEN 'NAO CONVEM COMO CLIENTE (X)'
  WHEN pn.t$code$c = 11 THEN 'SEM RETORNO'
  WHEN pn.t$code$c = 11 THEN 'ATIVO'
  WHEN pn.t$code$c = 12 THEN 'CNPJ DUPLICADO.' 
  WHEN pn.t$code$c = 13 THEN 'INATIVO (NÃO ENVIAR P/ TELEVENDAS)'
  WHEN pn.t$code$c = 15 THEN 'ATIVO EXCETO TELEVENDAS'
  WHEN pn.t$code$c = 20 THEN '2 COLEÇÕES SEM COMPRA'
  WHEN pn.t$code$c = 21 THEN '3 COLEÇÕES SEM COMPRA'
  WHEN pn.t$code$c = 25 THEN 'SOLICITADO PELO COMERCIAL (X)'
  WHEN pn.t$code$c = 30 THEN 'FALTA DE INF. COMERCIAIS (X)'
  WHEN pn.t$code$c = 35 THEN 'SOLICITADO PELO REPRESENTANTE'
  WHEN pn.t$code$c = 37 THEN 'SEM FATURAMENTO A MAIS DE 365 DIAS'
  WHEN pn.t$code$c = 38 THEN 'OUTROS'
  WHEN pn.t$code$c = 39 THEN '270 DIAS SEM COMPRA'
  WHEN pn.t$code$c = 40 THEN 'FINANCEIRO (ANTECIPADO NAO PAGO)'
  WHEN pn.t$code$c = 41 THEN '180 DIAS SEM COMPRA'
  WHEN pn.t$code$c = 41 THEN 'FINANCEIRO (RESTRICAO DE CREDITO)'
  WHEN pn.t$code$c = 43 THEN 'CADASTRO (SINTEGRA, NAO HABILITADO)'
  WHEN pn.t$code$c = 44 THEN 'CADASTRO (SUFRAMA, NAO HABILITADO)'
  WHEN pn.t$code$c = 45 THEN 'COMERCIAL (DESACORDO COML)'
  WHEN pn.t$code$c = 46 THEN 'COMERCIAL (DEVOLUCAO DE MERCADORIA, SEM MOTIVO)'
  WHEN pn.t$code$c = 49 THEN 'CADASTRO (ENDEREÇO DIVERGENTE=RF)'
  WHEN pn.t$code$c = 50 THEN 'CADASTRO (CNPJ NÃO OK PARA GERAÇÃO DO  PIN)'
  WHEN pn.t$code$c = 51 THEN 'NÃO EFETUOU PAGAMENTO IMPOSTO'
  WHEN pn.t$code$c = 52 THEN 'CLIENTE INADIMPLENTE'
  WHEN pn.t$code$c = 55 THEN 'FECHOU LOJA - VERIFICADO/TELEVENDAS'
  WHEN pn.t$code$c = 60 THEN 'MUDOU DE RAMO - VERIFICADO/TELEVENDAS'
  WHEN pn.t$code$c = 62 THEN 'NÃO EFETUOU PAGAMENTO PEDIDO ANTECIPADO'
  WHEN pn.t$code$c = 70 THEN 'PERDAS FINANCEIRAS (X)'
  WHEN pn.t$code$c = 72 THEN 'COMPRA POR OUTRO CNPJ'
  WHEN pn.t$code$c = 80 THEN 'DESISTIU DO PEDIDO'
  WHEN pn.t$code$c = 82 THEN 'NÃO DEVE SER ABORDADO PELO TELEVENDAS'
  WHEN pn.t$code$c = 91 THEN 'NÃO TRABALHA MAIS COMA MARCA (X)'
  WHEN pn.t$code$c = 92 THEN 'STATUS NÃO DEFINIDO (X)'
  WHEN pn.t$code$c = 93 THEN 'DESTINATÁRIO BLOQUEADO NA UF'
  WHEN pn.t$code$c = 97 THEN 'ATIVO PELO TELEVENDAS'
  WHEN pn.t$code$c = 98 THEN 'ATIVO (CONTAS A RECEBER)'
  WHEN pn.t$code$c = 99 THEN 'ATIVO'
  WHEN pn.t$code$c = 8 THEN 'CLIENTE FECHOU A LOJA.'
  WHEN pn.t$code$c = 14 THEN 'CLIENTE MUDOU DE RAMO.'
  WHEN pn.t$code$c = 16 THEN 'CLIENTE PROXIMO'
  WHEN pn.t$code$c = 17 THEN 'DESLIGOU-SE DA EMPRESA.'
  WHEN pn.t$code$c = 18 THEN 'NAO CONVEM COMO CLIENTE.'
  WHEN pn.t$code$c = 19 THEN 'INAPTO NA RECEITA FEDERAL.'
  WHEN pn.t$code$c = 22 THEN 'SOLICITADO PELO COMERCIAL.'
  WHEN pn.t$code$c = 23 THEN 'FALTA DE INF. COMERCIAIS.'
  WHEN pn.t$code$c = 24 THEN 'SUSPENSO NA RECEITA FEDERAL.'
  WHEN pn.t$code$c = 31 THEN 'PERDAS FINANCEIRAS'
  WHEN pn.t$code$c = 33 THEN 'NÃO TRABALHA MAIS COM A MARCA'
  WHEN pn.t$code$c = 34 THEN 'STATUS NÃO DEFINIDO'
      
       ELSE NULL
     END AS "Motivo Status",
     
	decode (pc.t$cbrn, 
	11001, 'VAREJO MULTIMARCA',
	11002, 'MULTIMARCA QUALIFICADO',
	11003, 'ATACADO (X)',
	11004, 'REDE ESTRUTURADA',
	11005, 'REDE DE VALOR',
	11006, 'MONOMARCA BRANDILI',
	11007, 'E-COMMERCE (X)',
	11008, 'EXPORTAÇÃO',
	11009, 'FRANQUIA',
	11010, 'DISTRIBUIDOR',
	11011, 'HIPERMERCADO',
	11012, 'REPRESENTANTE',
	11013, 'OUTLET',
	11014, 'BRANDILI MAIS',
	11015, 'GOs - GRANDES ORGANIZAÇÕES',
	11016, 'PESSOA FÍSICA',
	11017, 'VENDEDOR AUTÔNOMO',
	11018, 'KEYACCOUNT',
	20000, 'IMPORTAÇÃO',
	22000, 'ATACADO',
	22001, 'REDE',
	22002, 'SUPERMERCADO',
	22003, 'E-COMMERCE',
	22004, 'VAR.MULT.- EMPREENDA BRANDILI',
	22005, 'VAR.MULT.- LOJA INFANTIL A/B/C',
	22006, 'VAR.MULT.- LOJA INFANTIL C/D/E',
	22007, 'VAR.MULT.- LOJA FAMÍLIA A/B/C',
	22008, 'VAR.MULT.- LOJA FAMÍLIA C/D/E',
	22009, 'MAGAZINE',
	22010, 'PORTA A PORTA',
	50000, 'SEM INFORMAÇÃO',
	60000, 'FORNECEDOR',
	600010, 'P.L.',
	70000, 'FACÇÃO',
	70001, 'FACÇÃO - NOVO GERFAC',
	70020, 'FACÇÃO - BORDADO',
	70021, 'FACÇÃO - ESTAMPA',
	70022, 'FACÇÃO - LAVANDERIA',
	70023, 'PROSPECT',
	70024, 'COMERCIAL EXPORTADORA',
	70025, 'PREPOSTO',
	70026, 'FILIAL BRANDILI',
	' ',   'FALTA INFORMACAO'
	) as "Segmento"       

FROM
igrppr.ttccom100001 pn, 	/* Parceiro de negócios */
igrppr.ttccom130001 ad,		/* Endereços */
igrppr.ttccom110001 pc		/* Parceiro de negócios cliente	*/

WHERE pn.t$cadr = ad.t$cadr
AND pn.t$bpid = pc.t$ofbp
AND pn.t$cadr = pc.t$cadr
AND pn.t$ctit = '008'



