SELECT
  a.t$pofv$c as "Pedido",
  a.t$bpid$c as "Parceiro",
  b.t$nama as "Razão social",
  TO_CHAR(a.t$edat$c, 'DD/MM/YYYY') AS "Data emissão",
  TO_CHAR(a.t$dfat$c, 'DD/MM/YYYY') AS "Data faturamento",
  a.t$dtin$c as "Data inclusão",
  a.t$cpls$c as "Lista de preços",
  a.t$reln$c as "Representante",
  a.t$vtot$c as "Valor pedido",
  decode(a.t$stat$c,
    1, 'Aberto',
    2, 'Processado',
    3, 'Erro',
    4, 'Pronto',
    5, 'Em processamento'
  ) as "Status",
  a.t$erro$c as "Mensagem erro",
  decode(b.t$prst,
    2, 'Ativo',
    3, 'Inativo',
    4, 'Suspenso',
    5, 'Cancelado'
  ) as "Status PN"
FROM
  igrppr.ttdzbi180001 a, /* Pedido - Força Venda Ibtech */
  igrppr.ttccom100001 b  /* Parceiros de negócios */
WHERE
  a.t$bpid$c = b.t$bpid
  AND a.t$stat$c = '3' /* Status de erro */
  AND b.t$prst in ('4','5') /* Somente clientes com o status 'suspenso' e 'cancelado' */
  AND (a.t$pofv$c IS NOT NULL OR b.t$nama IS NOT NULL);