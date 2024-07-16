SELECT
    pn.t$bpid AS "Parceiro",
    pn.t$nama AS "Razão social",
    ov.t$reln$c AS "Cod. Representante",
    dv.t$dsca AS "Representante",
    ov.t$orno AS "Ordem",
    ov.t$pofv$c AS "Pedido",
    DECODE(ov.t$stov$c,
        1, 'Analise Comercial',
        2, 'Analise Financeira',
        3, 'Analise ADM Vendas',
        4, 'Expedição',
        5, 'Expedição em Atendimento',
        6, 'Faturamento',
        7, 'Faturado',
        8, 'Faturado Parcial',
        9, 'Cancelado',
        10, 'Devolvido'
    ) AS "Situação da Ordem",
    pj.t$cprj AS "Coleção",
    ov.t$cpls AS "Cod. Lista preço",
    lp.t$dsca AS "Desc. Lista preço",
    TO_CHAR(ov.t$odat, 'DD/MM/YYYY') AS "Data ordem",
    TO_CHAR(ov.t$ddat, 'DD/MM/YYYY') AS "Data de faturamento",
    ov.t$oamt AS "Valor da ordem",
    SUM(ri.t$qoor$c) AS "Total Quantidade Ordenada",
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM igrppr.ttdsls400001 ov_ant
            JOIN igrppr.ttcmcs034001 lp1 ON ov_ant.t$cpls = lp1.t$cplt
            WHERE ov_ant.t$ofbp = pn.t$bpid  /* Mesmo cliente */
              AND ov_ant.t$orno <> ov.t$orno  /* Pedidos diferentes */
              AND lp1.t$cprj$c <> '3.2024'  /* Coleção diferente de '2.2024' */
              AND ov_ant.t$stov$c IN ('1', '2', '3', '4', '5', '6', '7', '8')  /* Situações de ordem recorrente */
              AND ov_ant.t$stov$c NOT IN ('9', '10')  /* Não considerar Cancelados e Devolvidos */
              AND ov_ant.t$styp$c IN ('002', '102')  /* Apenas segmentos 002 e 102 */
              AND ov_ant.t$cpay <> '172'  /* Condição de pagamento válida */
        ) THEN 'Recorrente'
        WHEN EXISTS (
            SELECT 1
            FROM igrppr.ttdsls400001 ov_ant
            JOIN igrppr.ttcmcs034001 lp1 ON ov_ant.t$cpls = lp1.t$cplt
            WHERE ov_ant.t$ofbp = pn.t$bpid  /* Mesmo cliente */
              AND ov_ant.t$orno <> ov.t$orno  /* Pedidos diferentes */
              AND lp1.t$cprj$c = '3.2024'  /* Coleção '2.2024' */
              AND ov_ant.t$stov$c IN ('9', '10')  /* Situações de ordem nova */
              AND ov_ant.t$styp$c IN ('002', '102')  /* Apenas segmentos 002 e 102 */
              AND ov_ant.t$cpay <> '172'  /* Condição de pagamento válida */
        ) THEN 'Novo'
        ELSE 'Novo' /* Se não se encaixar em nenhuma das condições */
    END AS "Tipo de Cliente"

FROM
    igrppr.ttccom100001 pn  	/* Parceiros de negócios */
    JOIN igrppr.ttdsls400001 ov ON pn.t$bpid = ov.t$ofbp  /* Ordens de vendas */
    JOIN igrppr.ttdzbi401001 ri ON ov.t$orno = ri.t$orno$c  /* Resumo dos itens da ordem */
    JOIN igrppr.ttcmcs034001 lp ON ov.t$cpls = lp.t$cplt  /* Listas de preços */
    JOIN igrppr.ttcmcs052001 pj ON lp.t$cprj$c = pj.t$cprj  /* Projetos */
    JOIN igrppr.ttdsls012001 dv ON ov.t$cofc = dv.t$cofc  /* Departamento de Vendas */

WHERE
    pn.t$ctit = '001'       /* Apenas Clientes */
    AND ov.t$stov$c NOT IN ('9', '10')   /* Situação da Ordem diferente de 'Cancelado' e 'Devolvido' */
    AND ov.t$styp$c IN ('002', '102')    /* Tipo de venda */
    AND ov.t$cpay <> '172'     /* Condição de pagamento */
    AND lp.t$cprj$c = '3.2024'  /* Coleção '2.2024' (Alto Verão 2024) */

GROUP BY
    pn.t$bpid,
    pn.t$nama,
    ov.t$reln$c,
    dv.t$dsca,
    ov.t$orno,
    ov.t$pofv$c,
    ov.t$stov$c,
    pj.t$cprj,
    ov.t$cpls,
    lp.t$dsca,
    ov.t$odat,
    ov.t$ddat,
    ov.t$oamt
