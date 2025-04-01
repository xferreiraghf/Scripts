/* Query - Pedidos com Divergência na Condição de Pagamento */

SELECT
    DECODE(ov.t$corg,
        3, 'EDI',
        4, 'Manual',
        5, 'Telefone',
        6, 'Fax',
        30, 'Planejamento',
        200, 'B2B',
        201, 'B2C',
        202, 'Inside Sales',
        203, 'Representante',
        205, 'Salesforce B2B',
        206, 'Salesforce Inside Sales',
        207, 'Salesforce Representante' 
    ) AS "Origem",
    ov.t$orno AS "Ordem",
    ov.t$pofv$c AS "Pedido",
    ov.t$ofbp AS "Parceiro",
    pn.t$nama AS "Descrição",
    TO_CHAR(ov.t$odat, 'DD/MM/YYYY') AS "Data ordem",
    TO_CHAR(ov.t$ddat, 'DD/MM/YYYY') AS "Data de entrega",
    ov.t$cofc AS "Departamento de venda",
    dp.t$dsca AS "Descrição Departamento",
    ov.t$oamt AS "Valor da ordem",
    ov.t$cpls AS "Lista de preços",
    ov.t$cpay AS "Cond. Pagamento CAPA",
    lo.t$pono AS "Linha",
    TRIM(lo.t$item) AS "Item",
    lo.t$cpay AS "Cond. Pagamento LINHAS",
    DECODE(ov.t$stov$c,
        1, 'Análise Comercial',
        2, 'Análise Financeira',
        3, 'Análise ADM Vendas/Comprometimento',
        4, 'Expedição',
        5, 'Expedição em Atendimento',
        6, 'Faturamento',
        7, 'Faturado',
        8, 'Faturado Parcial',
        9, 'Cancelado',
        10, 'Devolvido'
    ) AS "Situação ordem",
    DECODE(ov.t$styp$c,
        2, 'Confecção',
        3, 'Saldo',
        10, 'Brindes',
        102, 'Confecção Adulto',
        103, 'Saldo Adulto'
    ) AS "Tipo venda"
FROM
    igrppr.ttdsls400001 ov  -- Ordens de venda
JOIN igrppr.ttdsls401001 lo ON ov.t$orno = lo.t$orno  -- Linhas da ordem de venda
JOIN igrppr.ttdsls012001 dp ON ov.t$cofc = dp.t$cofc  -- Departamento
JOIN igrppr.ttccom100001 pn ON ov.t$ofbp = pn.t$bpid  -- Parceiro de negócios
WHERE 
    ov.t$stov$c NOT IN (7, 8, 9, 10)  -- Excluir situações do pedido
    AND ov.t$cpay <> lo.t$cpay  -- Divergência na condição de pagamento
    AND lo.t$clyn = '2'  -- Linhas canceladas
ORDER BY 
    ov.t$orno,
    lo.t$pono;
