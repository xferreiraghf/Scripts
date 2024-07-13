-- vw_tarifador_principal source

CREATE VIEW vw_tarifador_principal AS
SELECT
    tp.NumNF,
    tp.MesRef,
    (SELECT GROUP_CONCAT(NumAcs, ', ')
     FROM (
         SELECT DISTINCT tp2.NumAcs
         FROM tarifador_principal tp2
         JOIN tarifador_custo tc2 ON tp2.NumAcs = tc2.telefone
         WHERE tp2.NumNF = tp.NumNF 
           AND tp2.MesRef = tp.MesRef 
           AND tc2.centro_custo = tc.centro_custo
     )) AS Telefones,
    COUNT(DISTINCT tp.NumAcs) AS quantidade_telefone,
    SUM(tp.Valor) AS Valor_Total,
    strftime('%Y-%m-%d %H:%M:%S', 'now') AS data_registro,
    tc.centro_custo
FROM tarifador_principal tp
JOIN tarifador_custo tc ON tp.NumAcs = tc.telefone
GROUP BY tp.NumNF, tp.MesRef, tc.centro_custo;
