/* Query - Clientes cadastrados sem segmento */

select a.t$bpid as "Parceiro",
       a.t$ctit as "Título",
       a.t$nama as "Razão Social",
       c.t$cste as "Estado",
       c.t$namf as "Cidade",
       a.t$usid as "Cód. criado por",
       TO_CHAR(a.t$crdt, 'DD/MM/YYYY') as "Data criação",
       
       decode(b.t$cbrn, ' ', 'Sem informação') as "Segmento",
       
       decode(substr(a.t$coda$c, 1, 2),
              'SF',
              'SalesForce',
              'TB',
              'IBTech',
              'Outros') as "Origem"

  from igrppr.ttccom100001 a, /* Parceiro de Negócios */
       igrppr.ttccom110001 b, /* Parceiro de Negócios - Cliente*/
       igrppr.ttccom130001 c /* Endereços */

 where a.t$cadr = b.t$cadr
   and b.t$cadr = c.t$cadr
   and b.t$cbrn like ' ' /* Puxar apenas clientes sem segmento */

 Order by a.t$crdt /*Ordenar por Data de Criação */

/*By FERREIRA */
