SELECT 
ldf.t$fire$l AS "Referência fiscal",
drf.t$docn$l AS "Documento fiscal",
drf.t$bpid$l AS "Parceiro",
drf.t$fids$l AS "Razão social",
ldf.t$item$l AS "Item",
ldf.t$dsca$l AS "Desc. item",
ldf.t$frat$l AS "Classificação fiscal",
ldf.t$itmu$l AS "Cod. Utilização item",
DECODE(ldf.t$itmu$l,
1, 'Industrialização',
3, 'Consumo',
4, 'Ativo fixo',
6, 'Item retornável',
8, 'Não aplicável'
)AS "Utilização item",
ldf.t$sour$l AS "Cod. Origem mercadoria",
DECODE(ldf.t$sour$l,
1, 'Nacional',
2, 'Estrangeiro importação direta',
3, 'Estrangeiro adq. merc. interno',
4, 'Não aplicável',
5, 'Nac. conteudo import. >40 e <=70',
6, 'Nac. processos prod. basicos',
7, 'Nac. conteudo import. <= 40',
8, 'Estrangeiro importação direta-CAMEX',
9, 'Estrangeiro adq. merc. interno-CAMEX',
10, 'Nac. conteudo import. > 70'
)AS "Origem mercadoria",
ldf.t$opor$l AS "Origem operação",
TO_CHAR(drf.t$odat$l, 'DD/MM/YYYY') AS "Data saida"

FROM
igrppr.ttdrec940001 drf, /* Documento recebimento fiscal */
igrppr.ttdrec941001 ldf  /* Linha doc. fiscal */

WHERE drf.t$fire$l = ldf.t$fire$l
AND ldf.t$opor$l IN ('2101', '2116', '2122') /* CFOP */
AND ldf.t$sour$l IN ('2', '3', '8', '9')     /* Origem mercadoria */
AND drf.t$odat$l BETWEEN (SELECT SYSDATE FROM DUAL) - 7 AND (SELECT SYSDATE FROM DUAL) - 1 /* Captura a informação da semana anterior */

ORDER BY drf.t$odat$l /* Data fiscal */


