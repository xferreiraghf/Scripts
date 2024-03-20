SELECT 
    l.t$worn AS Kit, 
    l.t$shpm AS Expedição,  
    ltrim(l.t$item) AS SKU, 
    k.t$ikit$c AS Kit,
    i_dsca.DescriçãoKit,
    SUM(l.t$qshp) AS Qtde
FROM igrppr.twhinh431001 l
JOIN igrppr.ttcibd001001 i ON i.t$item = l.t$item
JOIN igrppr.twhzbi062001 k ON l.t$worn = k.t$ornt$c
JOIN igrppr.twhinh200001 o ON o.t$orno = k.t$ornt$c
LEFT JOIN (
    SELECT t$item, MAX(t$dsca) AS DescriçãoKit
    FROM igrppr.ttcibd001001
    GROUP BY t$item
) i_dsca ON k.t$ikit$c = i_dsca.t$item
WHERE 
    l.t$worg = 72
    AND k.t$orno$c = ' ' 
    AND o.t$oorg = 72 /* ordem armazenamento */
    AND o.t$hsta = 60 /* Recebido */
    AND l.t$qshp <> 0
GROUP BY 
    l.t$worn, l.t$shpm, l.t$item, k.t$ikit$c, i_dsca.DescriçãoKit
ORDER BY 
    l.t$worn, l.t$shpm, l.t$item
	
/* By Ferreira */
