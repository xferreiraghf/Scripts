/* Clientes cadastrados como E-commerce */

select a.t$bpid   as "Parceiro",
       a.t$ctit   as "Título",
       a.t$nama   as "Razão social",
       c.t$fovn$l as "Entidade fiscal",
       b.t$cbrn   as "Segmento",
       c.t$cste   as "Estado",
       c.t$dsca	  as "Cidade",
       a.t$usid   as "Criado por",
       TO_CHAR(a.t$crdt, 'DD/MM/YYYY') AS "Data criação",
       c.t$inet   as "Site",
       d.t$repr$c as "Cód.Rep",
       e.t$dsca   as "Representante",
       
       /* Regional */
       
       decode(d.t$repr$c,
		'R00035',
		'Sul',
		'R00158',
		'Sul',
		'R00159',
		'Sul',
		'R00038',
		'Sul',
		'R00036',
		'Sul',
		'R00032',
		'Sul',
		'R00129',
		'Sul',
		'R00203',
		'Sul',
		'R00201',
		'Sul',
		'R00236',
		'Sul',
		'R00072',
		'Sul',
		'R00041',
		'Sul',
		'R00232',
		'Sul',
		'R00253',
		'Sul',
		'R00229',
		'Sul',
		'R00219',
		'Sul',
		'R00058',
		'Sul',
	      	'R00149',
              'Centro',
              'R00223',
              'Centro',
              'R00050',
              'Centro',
              'R00226',
              'Centro',
              'R00077',
              'Centro',
              'R00199',
              'Centro',
              'R00260',
              'Centro',
              'R00234',
              'Centro',
              'R00205',
              'Centro',
              'R00210',
              'Centro',
              'R00211',
              'Centro',
              'R00087',
              'Centro',
              'R00235',
              'Centro',
              'R00239',
              'Centro',
              'R00103',
              'Centro',
              'R00250',
              'Centro',
              'R00061',
              'Centro',
              'R00051',
              'Norte/Nordeste',
              'R00092',
              'Norte/Nordeste',
              'R00133',
              'Norte/Nordeste',
              'R00193',
              'Norte/Nordeste',
              'R00140',
              'Norte/Nordeste',
              'R00012',
              'Norte/Nordeste',
              'R00120',
              'Norte/Nordeste',
              'R00242',
              'Norte/Nordeste',
              'R00123',
              'Norte/Nordeste',
              'R00013',
              'Norte/Nordeste',
              'R00213',
              'Norte/Nordeste',
              'R00209',
              'Norte/Nordeste',
              'R00262',
              'Norte/Nordeste',
              'R00263',
              'Norte/Nordeste',
              'R00261',
              'Norte/Nordeste',
              'R00264',
              'Norte/Nordeste',
              'R00247',
              'Norte/Nordeste',
              'R00062',
              'Norte/Nordeste',
              'R00048',
              'São Paulo',
              'R00078',
              'São Paulo',
              'R00118',
              'São Paulo',
              'R00208',
              'São Paulo',
              'R00003',
              'São Paulo',
              'R00202',
              'São Paulo',
              'R00095',
              'São Paulo',
              'R00188',
              'São Paulo',
              'R00192',
              'São Paulo',
              'R00134',
              'São Paulo',
              'R00112',
              'São Paulo',
              'R00191',
              'São Paulo',
              'R00186',
              'São Paulo',
              'R00111',
              'São Paulo',
              'R00073',
              'São Paulo',
              'R00060',
              'São Paulo',
              'R00204',
              'Brás',
              'R00064',
              'Exportação',
              'R00059',
              'Sudeste',
              'R00184',
              'Key Account',
              'R00079',
              'Key Account',
              'R00063',
              'Direto',
              'R99999',
              'Direto',
              'R00127',
              'Direto',
              'R99996',
              'Direto',
              'R00196',
              'PL',
              'R00056',
              'Exportação',
              'R00136',
              'Exportação',
              ' ',
              'Sem informação') as "Regional",
       
       /* Origem do Pedido */
       
       decode(substr(a.t$coda$c, 1, 2),
              'SF',
              'SalesForce',
              'TB',
              'IBTech',
              'Outros') as "Origem"

  from 
  		igrppr.ttccom100001 a, /* Parceiros de negócios */
       	igrppr.ttccom110001 b, /* Parceiros de negócios clientes */
       	igrppr.ttccom130001 c, /* Endereços */
       	igrppr.ttdzbr003001 d, /* Cadastro de Atendimento aos Clientes */
       	igrppr.ttcmcs065001 e /* Departamentos */

 where 
 	a.t$cadr = b.t$cadr
   and b.t$cadr = c.t$cadr
   and e.t$cwoc = d.t$repr$c
   and d.t$bpid$c = a.t$bpid
   and d.t$ativ$c = '1' /* Busca apenas Representantes Ativo */
   and d.t$styp$C = '002' /* Confecção */
   and b.t$cbrn = '22003' /* Segmento definido */
   and c.t$inet like ' '

 Order by TO_CHAR(a.t$crdt, 'DD/MM/YYYY')  /* Ordenar por Data de Criação */
 

/* By Ferreira */
 
/* Atualizado: 14/08/2023 | Atualização na busca de novos representantes */ 
/* Atualizado: 16/09/2024 | Atualização na busca de novos representantes */ 
/* Atualizado: 02/12/2024 | Substituição do campo 'NAMF' pelo campo 'DSCA', relacionado à descrição da cidade. */ 
 
 
