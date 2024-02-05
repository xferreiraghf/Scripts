SELECT 
    pn.t$bpid AS "Parceiro",
    pn.t$ctit AS "Cod. título",
    DECODE(
        pn.t$ctit,
        '001', 'Cliente',
        '002', 'Fornecedor',
        '003', 'Representante',
        '004', 'Transportadora',
        '005', 'Preposto',
        '006', 'Facção',
        '008', 'Prospect',
        '009', 'Funcionário',
        '010', 'Exterior',
        '011', 'Consumidor',
        '012', 'Cliente/Fornecedor',
        ' ', 'Sem informação'
    ) AS "Título",
    pn.t$nama AS "Razão social",
    e.t$ftyp$l AS "Tipo entidade",
    e.t$fovn$l AS "Entidade",
    e.t$ccty AS "País",
    e.t$cste AS "Parceiro UF",
    cf.t$cste$l AS "Fiscal UF",
    e.t$dsca AS "Cidade",
    DECODE(
        pn.t$prst,
        2, 'Ativo',
        3, 'Inativo',
        4, 'Suspenso',
        5, 'Cancelado'
    ) AS "Status",
    pn.t$code$c AS "Cod. Status",
    
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
	  WHEN pn.t$code$c = 22 THEN 'SOLICITADO PELO COMERCIAL.'
	  WHEN pn.t$code$c = 23 THEN 'FALTA DE INF. COMERCIAIS.'
	  WHEN pn.t$code$c = 31 THEN 'PERDAS FINANCEIRAS'
	  WHEN pn.t$code$c = 33 THEN 'NÃO TRABALHA MAIS COM A MARCA'
	  WHEN pn.t$code$c = 34 THEN 'STATUS NÃO DEFINIDO'	
        ELSE null
    END AS "Motivo Status"
FROM
    igrppr.ttccom100001 pn
JOIN
    igrppr.ttccom130001 e ON pn.t$cadr = e.t$cadr
JOIN
    igrppr.ttccom966001 cf ON e.t$fovn$l = cf.t$fovn$l AND e.t$cste != cf.t$cste$l;
	
	
/* By Ferreira */	