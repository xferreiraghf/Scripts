/* Clientes com Pedidos em aberto - Zona franca de Manaus */

select
a.t$bpid as "Parceiro",
a.t$ctit as "Título",
a.t$nama as "Razão social",
b.t$orno as "Ordem",
b.t$refa as "Pedido",
TO_CHAR(b.t$odat, 'DD/MM/YYYY') AS "Data ordem",
d.t$insu$l as "Suframa",
c.t$ccty as "País",
c.t$cste as "Estado",
c.t$dsca as "Cidade",
c.t$fovn$l as "Entidade",
e.t$prep$c AS "Cod. representante",
f.t$dsca  as "Representante",

decode(b.t$stov$c,
1, 'Analise Comercial',
2, 'Analise Financeira',
3, 'Analise ADM de Vendas',
4, 'Expedição',
5, 'Expedição em Atendimento',
6, 'Faturamento',
7, 'Faturado',
8, 'Faturado Parcial',
9, 'Cancelado',
10, 'Devolução') as "Situação"

from 
igrppr.ttccom100001 a, /* Parceiros de negócios */
igrppr.ttdsls400001 b, /* Ordens de vendas */
igrppr.ttccom130001 c, /* Endereço */
igrppr.ttccom966001 d, /* Complemento Fiscal */
igrppr.ttdzbr003001 e, /* Cadastro de atendimento */
igrppr.ttcmcs065001 f  /* Departamento */


where a.t$bpid = b.t$ofbp
and a.t$cadr = c.t$cadr
and a.t$nama = c.t$nama
and c.t$fovn$l = d.t$fovn$l
and b.t$stov$c in ('1', '2', '3', '4', '5', '6') /* Situação do Pedido */
and c.t$cste in ('AM', 'AC', 'RO', 'RR', 'AP')   /* UFs Zona Franca de Manaus */
and a.t$ctit like '001' /* Título puxando por Cliente */
and  substr(b.t$orno,1,1)  in ('1','2','3','4','5','6')
and a.t$bpid = e.t$bpid$c
and e.t$ativ$c LIKE '1'
and e.t$styp$C LIKE '002' /* Cadastro de Atendimento aos Clientes */
and f.t$cwoc = e.t$repr$c /* Departamentos */
and b.t$odat BETWEEN (SELECT SYSDATE FROM DUAL) -7 AND (SELECT SYSDATE FROM DUAL) -1  /* Busca semana anterior */

order by a.t$bpid

/* By Ferreira - Atualizado:
15/08/2023: Buscar pedidos somente da semana anterior / Ajuste no formato da data*/