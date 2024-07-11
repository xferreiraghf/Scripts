-- vw_tarifador source

CREATE VIEW vw_tarifador AS
WITH tarifador_principal_ranked AS (
    SELECT 
        tp."NumNF",
        tp."MesRef",
        tp."telefones",
        tf.cnpj,
        tf.fatura,
        tp."Valor_Total",
        tf.valor_fatura AS valor_fatura_com_imposto,
        tf.valor_nf AS valor_nf_sem_imposto,
        tp.centro_custo,
        ROW_NUMBER() OVER (PARTITION BY tp."NumNF" ORDER BY tp."telefones") AS row_num,
        COUNT(tp.centro_custo) OVER (PARTITION BY tp."NumNF") AS centro_custo_count -- Conta os centro_custo por NumNF
    FROM 
        vw_tarifador_principal tp
    LEFT JOIN 
        tarifador_fatura tf ON tp."NumNF" = tf.num_nf 
    LEFT JOIN 
        tarifador_custo tc ON tp."telefones" = tc.telefone
)
SELECT 
    "NumNF",
    "MesRef",
    "telefones",
    cnpj,
    fatura,
    CASE WHEN SUM("Valor_Total") <> 0 THEN SUM("Valor_Total") ELSE NULL END AS total_valor,
    MAX(CASE WHEN row_num = 1 THEN valor_fatura_com_imposto ELSE NULL END) AS valor_fatura_com_imposto,
    MAX(CASE WHEN row_num = 1 THEN valor_nf_sem_imposto ELSE NULL END) AS valor_nf_sem_imposto,
    centro_custo,
    valor_nf_sem_imposto / centro_custo_count AS valor_centro_custo, -- Divide o valor_nf_sem_imposto pelo número de centro_custo
    CASE WHEN cnpj IN ('40.432.544/0191-66', '40.432.544/0101-00') THEN -1 * MAX(CASE WHEN row_num = 1 THEN valor_nf_sem_imposto ELSE NULL END) ELSE MAX(CASE WHEN row_num = 1 THEN valor_fatura_com_imposto ELSE NULL END) - MAX(CASE WHEN row_num = 1 THEN valor_nf_sem_imposto ELSE NULL END) END AS valor_lancamento
FROM 
    tarifador_principal_ranked
GROUP BY 
    "NumNF",
    "MesRef",
    "telefones",
    cnpj,
    fatura,
    centro_custo,
    centro_custo_count
HAVING 
    CASE WHEN SUM("Valor_Total") <> 0 THEN SUM("Valor_Total") ELSE NULL END IS NOT NULL;
