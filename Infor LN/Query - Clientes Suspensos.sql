SELECT 
    parceiro."Parceiro",
    parceiro."Título",
    parceiro."Razão social",
    parceiro."Tipo entidade",
    parceiro."Entidade",
    parceiro."UF",
    parceiro."Cidade",
    parceiro."Data criação",
    parceiro."Data modificação",
    parceiro."Status",
    parceiro."Cod. status",
    parceiro."Motivo Status",
    parceiro."Regional",
    parceiro."Cód.Rep",
    parceiro."Representante"
FROM (
    SELECT 
        pn.t$bpid AS "Parceiro",
        pn.t$ctit AS "Título",
        pn.t$nama AS "Razão social",
        e.t$ftyp$l AS "Tipo entidade",
        e.t$fovn$l AS "Entidade",
        e.t$cste AS "UF",
        e.t$dsca AS "Cidade",
        pn.t$crdt AS "Data criação",
        ha.t$date$c AS "Data modificação",

        DECODE(pn.t$prst,
        2, 'Ativo',
        3, 'Inativo',
        4, 'Suspenso',
        5, 'Cancelado'
        ) AS "Status",

        pn.t$code$c AS "Cod. status",

        DECODE(cc.t$repr$c,
                      'R00035', 'Sul',
		      'R00158', 'Sul',
		      'R00159', 'Sul',					  
		      'R00038', 'Sul',					  
		      'R00126', 'Sul',					  
                      'R00036', 'Sul',					  
                      'R00032', 'Sul',					  
                      'R00129', 'Sul',					  
                      'R00203', 'Sul',					  
                      'R00201', 'Sul',					  
                      'R00040', 'Sul',
                      'R00072', 'Sul',
                      'R00041', 'Sul',
                      'R00232', 'Sul',
                      'R00165', 'Sul',
                      'R00048', 'Sul',					  
                      'R00229', 'Sul',
                      'R00219', 'Sul',
		      'R00058', 'Sul',					  
                      'R00149', 'Centro',
                      'R00223', 'Centro',
                      'R00050', 'Centro',
                      'R00225', 'Centro',
                      'R00226', 'Centro',
                      'R00198', 'Centro',
                      'R00077', 'Centro',
                      'R00199', 'Centro',
                      'R00197', 'Centro',
                      'R00234', 'Centro',
                      'R00205', 'Centro',
                      'R00210', 'Centro',
                      'R00211', 'Centro',
                      'R00087', 'Centro',
                      'R00235', 'Centro',
                      'R00214', 'Centro',
                      'R00103', 'Centro',
                      'R00061', 'Centro',
                      'R00051', 'Norte/Nordeste',
                      'R00092', 'Norte/Nordeste',
                      'R00133', 'Norte/Nordeste',
                      'R00193', 'Norte/Nordeste',
                      'R00140', 'Norte/Nordeste',
                      'R00012', 'Norte/Nordeste',
                      'R00120', 'Norte/Nordeste',
                      'R00206', 'Norte/Nordeste',
                      'R00123', 'Norte/Nordeste',
                      'R00013', 'Norte/Nordeste',
                      'R00227', 'Norte/Nordeste',
                      'R00213', 'Norte/Nordeste',
                      'R00209', 'Norte/Nordeste',
                      'R00062', 'Norte/Nordeste',
		      'R00204', 'Brás',
                      'R00078', 'São Paulo',
                      'R00118', 'São Paulo',
                      'R00208', 'São Paulo',
                      'R00003', 'São Paulo',
                      'R00202', 'São Paulo',
                      'R00095', 'São Paulo',
                      'R00188', 'São Paulo',
                      'R00192', 'São Paulo',
                      'R00134', 'São Paulo',
                      'R00112', 'São Paulo',
                      'R00191', 'São Paulo',
                      'R00186', 'São Paulo',
                      'R00224', 'São Paulo',
                      'R00111', 'São Paulo',
                      'R00060', 'São Paulo',
		      'R00145', 'São Paulo',
                      'R00064', 'Exportação',
		      'R00070', 'Exportação',
		      'R00154', 'Exportação',
		      'R00056', 'Exportação',
		      'R00059', 'Sudeste (Não utilizado)',
                      'R00184', 'Key Account',
		      'R00228', 'Key Account',
		      'R00196', 'Key Account',
		      'R00094', 'Key Account',
		      'R99999', 'Direto',
		      'R00063', 'Direto',
		      'R00127', 'Direto',
                      ' ', 'Sem informação') AS "Regional",
                      
        cc.t$repr$c AS "Cód.Rep",
        dp.t$dsca   AS "Representante",
        
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
        ROW_NUMBER() OVER (PARTITION BY pn.t$bpid ORDER BY ha.t$date$c DESC) AS row_num
    FROM
        igrppr.ttccom100001 pn
    INNER JOIN igrppr.ttccom130001 e ON pn.t$cadr = e.t$cadr
    INNER JOIN igrppr.ttczbr023001 ha ON pn.t$bpid = ha.t$bpid$c
    LEFT JOIN igrppr.ttdzbr003001 cc ON cc.t$bpid$c = pn.t$bpid
    LEFT JOIN igrppr.ttcmcs065001 dp ON dp.t$cwoc = cc.t$repr$c
    WHERE 
        cc.t$ativ$c LIKE '1' 
        AND cc.t$styp$C LIKE '002'
        AND pn.t$prst = '4'
) parceiro
WHERE parceiro.row_num = 1;

/* By Ferreira */
