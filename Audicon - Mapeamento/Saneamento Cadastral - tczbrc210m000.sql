|******************************************************************************
|* tczbrc210  0  VRC B61C a7 bdl0
|* Saneamento cadastral
|* Developer customization 05                                                                                              
|* 2012-08-24
|******************************************************************************
|* Form Type 4
|******************************************************************************
|* TIM.442, Tiago Mira, 2014-09-24, B61U_a_prd0
|* Customização reescrita.
|* CRVE096.
|*
|* I15197312, Wellington Almeida, 2021-03-04
|* Filtrar PN a partir de um arquivo texto 
|* 
|* BDL.106196, Wellington Almeida, 2021-10-07
|* So permitir uma execucao por vez da sessao.
|* 
|******************************************************************************
                                                                             
|****************************** declaration section ***************************
declaration:
#ident "@(#)TIM.442, Tiago Mira, 2014-09-24, B61U_a_prd0"
#ident "@(#)I15197312, Wellington Almeida, 2021-03-04, B61U_a_prd0"
#ident "@(#)BDL.106196, Wellington Almeida, 2021-10-07, B61U_a_prd0"

	table	ttccom100	|* Parceiros de negócios
	table	ttccom130	|* Addresses
	table	ttczbr012	|* Saneamento Cadastral
	table	ttczbr013	|* Inconsistencias Cadastrais
	table	ttczbr014	|* Parceiro de Negócios com Restrições
|* Cadastrais.
	table	ttdsls400	|* Ordens de vendas
	table	ttczbr000	|* Parametros customizados Brandili
	
	extern	domain	tccom.bpid		bpid.f.c	fixed
	extern	domain	tccom.bpid		bpid.t.c	fixed
	extern	domain	tcdate			crdt.f.c
	extern	domain	tcdate			crdt.t.c
	extern	domain	tcdate			stdt.f.c
	extern	domain	tcdate			stdt.t.c
	extern	domain	tcdate			odat.f.c
	extern	domain	tcdate			odat.t.c
	extern	domain	tcdate			ddat.f.c
	extern	domain	tcdate			ddat.t.c
	extern	domain	tcyesno			f.ejob.c
	extern	domain	tcyesno			f.udma.c
	extern	domain	tcyesno			f.arqu.c	|#I15197312.sn
	extern	domain	tcmcs.str100		f.cami.c	
			long			ret.file.c
			string			regi.c(1000)	|#I15197312.en
			long			i

	#include "itccom0000"	|* Multicurrency variables and handling
	#include <bic_desktop>					|#I15197312.n

|****************************** program section *******************************
before.program:
	e = tcmcs.dll0095.read.parm("tczbr000")
| 	e = appl.set(logname$, APPL.EXCL) 			|#BDL.106196.o
	if application.lock.c() then 				|#BDL.106196.sn
		exit()
	endif							|#BDL.106196.en

|****************************** group section *********************************
group.1:
init.group:
	get.screen.defaults()

choice.cont.process:
on.choice:
	clean.mess()
	compor.tabela.para.saneamento.c()
	if f.ejob.c = tcyesno.no then
		start.session(MODAL, "tczbrc520m000", "prog.name$", "")
		|* Saneamento Cadastral
	else
		tczbr.dllc003.processar.saneamento.cadastral.c("")
	endif
	mess("tccom99988", 0)
	|* Processamento completo.

|****************************** field section *********************************
field.bpid.f.c:
when.field.changes:
	bpid.t.c = bpid.f.c

field.crdt.f.c:
when.field.changes:
	crdt.t.c = crdt.f.c

field.stdt.f.c:
when.field.changes:
	stdt.t.c = stdt.f.c

field.odat.f.c:
when.field.changes:
	odat.t.c = odat.f.c

field.ddat.f.c:
when.field.changes:
	ddat.t.c = ddat.f.c
	
field.f.arqu.c:
when.field.changes:
	if f.arqu.c = tcyesno.yes then 
		enable.fields("f.cami.c")
		disable.fields("bpid.f.c")
		disable.fields("bpid.t.c")
	else
		disable.fields("f.cami.c")
		enable.fields("bpid.f.c")
		enable.fields("bpid.t.c")
	endif 

|****************************** function section ******************************
functions:
/* Funções são blocos de código que podem ser chamados em outras partes do programa para executar uma tarefa específica. */
function compor.tabela.para.saneamento.c()
{
	domain	tfgld.date	l.data.c
	
	e = create.progress.indicator(form.text$("tccom99989"))
	/* A variável l.data.c é inicializada para conter o valor resultante da subtração entre o valor retornado por date.num() (que provavelmente retorna uma representação numérica da data atual) e o valor da variável tczbr000.ccad.c. */
	l.data.c = date.num() - tczbr000.ccad.c /* Campo - Prazo máximo de dias */
	
	db.retry.point()
	select	tczbr012.* /* Saneamento cadastral */
	from	tczbr012 for update
	selectdo
								|#BDL.106196.so
| 		if not appl.set(tczbr012.logn.c, APPL.EXCL) > 0 then 
								|#BDL.106196.eo
		select	tczbr013.* /* Inconsistencias cadastrais */
		from	tczbr013 for update
		where	tczbr013._index1 = { :tczbr012.bpid.c } /* Campo - Parceiro de Negócios */
		selectdo
			db.delete(ttczbr013, db.retry)
		endselect
	
		select	tczbr014.* /* Parceiro de negócios com Restrição Cadastral */
		from	tczbr014 for update
		where	tczbr014._index1 = { :tczbr012.bpid.c } /* Campo - Parceiro de Negócios */
		selectdo
			db.delete(ttczbr014, db.retry)
		endselect
	
		db.delete(ttczbr012, db.retry)
		e = appl.delete(tczbr012.logn.c) /* Campo - Usuário */
| 		endif 						|#BDL.106196.o
	endselect
	commit.transaction()
	
	e = change.progress.indicator(0, "Selecionando PN's para saneamento...")
	
	if f.arqu.c = tcyesno.yes then 				|#I15197312.sn
		abre.arquivo.c(l.data.c)
	else
	/* Se a condição anterior não for atendida, a função executar.saneamento.c é chamada com três argumentos: bpid.f.c, bpid.t.c, e l.data.c. */
		executar.saneamento.c(
				bpid.f.c,
				bpid.t.c, 
				l.data.c)
	endif							|#I15197312.en
	
| 	db.retry.point()					|#I15197312.so
| 	select	tccom100.* /* Parceiros de Negócios */
| 	from	tccom100,
| 		tccom130
| 	where	tccom100._index1 inrange { :bpid.f.c } and { :bpid.t.c } /* Campo -  Parceiro de negócios */
| 	and	tccom100.crdt    inrange { :crdt.f.c } and { :crdt.t.c } /* Campo - data criação */
| 	and	tccom100.stdt    inrange { :stdt.f.c } and { :stdt.t.c } /* Campo - data inicial */
| 	and	tccom100.prst <> tccom.prst.cancel /* Campo - Status parceiro de negócios */
| 	and	tccom130._index1 = { tccom100.cadr } /* Campo - Código de endereço */
| 	and	tccom130.cste <> "EX"
| 	selectdo
| 		if tccom100.arfb.c > l.data.c and /* Campo - última consulta RFB */
| 		   tccom100.astg.c > l.data.c and /* Campo - última consulta Sintegra */
| 		   tccom100.asuf.c > l.data.c then /* Campo - última consulta Suframa */
| 			continue
| 		endif
| 	
| 		select	tdsls400.* /* Ordens de venda */
| 		from	tdsls400
| 		where	tdsls400._index2 = { :tccom100.bpid } /* Campo - Parceiro de negócios */
| 		selectdo
| 			if odat.f.c <> 0 then
| 				if tdsls400.odat < odat.f.c or /* Campo -  Data da ordem*/
| 				   tdsls400.odat > odat.t.c then 
| 					continue
| 				endif
| 			endif
| 			if ddat.f.c <> 0 then
| 				if tdsls400.ddat < ddat.f.c or /* Campo - data de entrega planejada */
| 				   tdsls400.ddat > ddat.t.c then 
| 					continue
| 				endif
| 			endif
| 			tczbr.dllc003.saneamento.necessario.c(tccom100.bpid, /* Campo - Parceiro de negócios */
| 							      l.data.c,
| 							      f.udma.c)
| 			i = i + 1
| 			break
| 		selectempty
| 			if odat.f.c = 0 and odat.t.c = 0 and /* Campo -  Data da ordem*/
| 			   ddat.f.c = 0 and ddat.t.c = 0 then
| 				tczbr.dllc003.saneamento.necessario.c(
| 								tccom100.bpid,
| 								l.data.c,
| 								f.udma.c)
| 				i = i + 1
| 			endif
| 		endselect
| 	
| 		if i > 1000 then
| 			commit.transaction()
| 			i = 0
| 		endif
| 	endselect
| 	commit.transaction()					|#I15197312.eo
	
	destroy.progress.indicator()
}

function executar.saneamento.c(					|#I15197312.sn
				domain	 tccom.bpid	i.bpid.f.c, /* Campo - Parceiro de negócios */
				domain	 tccom.bpid	i.bpid.t.c,
				domain	tfgld.date	i.data.c)
{
	db.retry.point()
	select	tccom100.*  /* Parceiro de negócios */
	from	tccom100,
		tccom130
	where	tccom100._index1 inrange { :i.bpid.f.c } and { :i.bpid.t.c }
	and	tccom100.crdt    inrange { :crdt.f.c } and { :crdt.t.c } /* Campo -  Data criação */
	and	tccom100.stdt    inrange { :stdt.f.c } and { :stdt.t.c } /* Campo - Data inicial */
	and	tccom100.prst <> tccom.prst.cancel /* Campo - Status parceiro de negócios */
	and	tccom130._index1 = { tccom100.cadr } /* Campo - Código de endereço */
	and	tccom130.cste <> "EX" /* Campo - Estado/Província */
	selectdo
		if tccom100.arfb.c > i.data.c and
		   tccom100.astg.c > i.data.c and
		   tccom100.asuf.c > i.data.c then
			continue
		endif
	
		select	tdsls400.*  /* Ordens de venda */
| 		from	tdsls400
		from	tdsls400
		where	tdsls400._index2 = { :tccom100.bpid } /* Campo - Parceiro de negócios */
		selectdo 
			if odat.f.c <> 0 then
				if tdsls400.odat < odat.f.c or /* Campo -  Data da ordem*/
				   tdsls400.odat > odat.t.c then
					continue
				endif
			endif
			if ddat.f.c <> 0 then
				if tdsls400.ddat < ddat.f.c or /* Campo - data de entrega planejada */
				   tdsls400.ddat > ddat.t.c then
					continue
				endif
			endif
			tczbr.dllc003.saneamento.necessario.c(tccom100.bpid,
							      i.data.c,
							      f.udma.c)
			i = i + 1
			break
		selectempty
			if odat.f.c = 0 and odat.t.c = 0 and /* Campo -  Data da ordem*/
			   ddat.f.c = 0 and ddat.t.c = 0 then
				tczbr.dllc003.saneamento.necessario.c(
								tccom100.bpid,
								i.data.c,
								f.udma.c)
				i = i + 1
			endif
		endselect
	
		if i > 1000 then
			commit.transaction()
			i = 0
		endif
	endselect
	commit.transaction()
}

function abre.arquivo.c(	domain	tfgld.date	i.data.c)
{
	domain 	tccom.bpid	l.bpid.c
	
	if isspace(f.cami.c) then
		message("Arquivo inválido.")
		return
	endif	

	ret.file.c = client2server(f.cami.c, "./arquivo.tmp", false)
	
	if ret.file.c < 0 then
		message("Erro ao transferir arquivo para o servidor.")
		return
	endif
	
	ret.file.c = seq.open("./arquivo.tmp", "r")
	
	while seq.gets(regi.c, 200, ret.file.c) = 0
		string.scan(regi.c, "%s", l.bpid.c)
			executar.saneamento.c(
					l.bpid.c,
					l.bpid.c,
					i.data.c)
	endwhile
}								|#I15197312.en

function boolean application.lock.c()				|#BDL.106196.sn
{
	domain	tclogn 	l.user 
	
	if appl.set(prog.name$, APPL.EXCL) <> 0 then
		appl.get.user(prog.name$, l.user)
		message("O usuário " & trim$(l.user) & " esta utilizando a sessão", 1)
		return(true)
	endif
	return(false)
}								|#BDL.106196.en

|****************************** end program ***********************************
