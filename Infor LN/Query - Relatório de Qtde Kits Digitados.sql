select a.t$orno as "Pedido",
       TRUNC(CAST(from_tz(CAST(a.t$odat AS TIMESTAMP), 'GMT') at TIME ZONE
                  'America/Sao_Paulo' AS DATE)) as "Dia",
       a.t$ofbp as "Cliente",
       b.t$item as "Item",
       d.t$dsca as "Descrição",
       b.t$qoor as "Quantidade",
       b.t$oamt as "Preço"
  from 
  igrppr.ttdsls400001 a, /* Ordens de vendas */
  igrppr.ttdsls401001 b, /* Linhas de ordem de vendas */
  igrppr.twhzbi060001 c, /* Gerenciamento Kits */
  igrppr.ttcibd001001 d  /*Itens - Geral */
  
  
 where a.t$stov$c NOT IN ('9', '10')
   and a.t$orno = b.t$orno
   and b.t$item = c.t$ikit$c
   and b.t$item = d.t$item
   and a.t$odat between to_date('01/01/2022', 'dd/mm/yyyy') and
       to_date('31/12/2050', 'dd/mm/yyyy')
 order by a.t$odat desc

/* By Ferreira 
Atualizado: 16/08/2023 - Inserção do campo 't$dsca' da tabela 'tcibd001001' */

