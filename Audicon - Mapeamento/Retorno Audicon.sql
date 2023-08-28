function tczbr.dllc003.atualizar.dados.retorno.consulta()
{	/*db.retry.point(): Inicia um ponto de recuperação para possíveis retries em operações de banco de 	dados.*/
	db.retry.point()
	
	/*select tccom100.* from tccom100 for update where tccom100._index1 = { :tczbr012.bpid.c }: Seleciona todos os campos da tabela tccom100 onde o valor da coluna _index1 corresponde ao valor contido na variável tczbr012.bpid.c. A cláusula for update indica que a seleção bloqueará as linhas selecionadas para atualizações subsequentes.*/
	
	
	select	tccom100.*
	from	tccom100 for update
	where	tccom100._index1 = { :tczbr012.bpid.c } /*CAMPO - PARCEIRO DE NEGÓCIOS (tczbr012.bpid.c )*/
	
	/*A partir daqui, começa um loop que percorrerá as linhas selecionadas na consulta anterior usando a cláusula "selectdo". Dentro desse loop, modificações serão feitas em cada registro.*/
	/*selectdo: Inicia um bloco de código que será executado para cada linha selecionada na consulta anterior.*/
	selectdo
	
	/*e = dal.change.object("tccom100"): Inicia a modificação dos dados do objeto tccom100 usando um mecanismo chamado dal (Data Access Layer).*/
	
		e = dal.change.object("tccom100") /* TABELA - PARCEIRO DE NEGÓCIOS */
		
	/*O bloco on case trim$(tdzbi001.codc.c) inicia uma estrutura de decisão com base no valor da variável "tdzbi001.codc.c"*/	
	
		on case trim$(tdzbi001.codc.c) /* DADOS DE RETORNO RFB - CÓDIGO CONSULTA */
		
	/*Em cada CASE (1, 3, 4 e 7), a função modifica diferentes campos da tabela tccom100 com base nos valores de tdzbi001 e tcyesno.*/	
		case "1":
			dal.set.field("tccom100.astg.c", date.num()) /*CAMPO - ULTIMA CONSULTA SINTEGRA*/
			dal.set.field("tccom100.ssin.c", tcyesno.no) /*CAMPO - SINTEGRA (FLAG)*/
			break
		case "3":
			dal.set.field("tccom100.nama", tdzbi001.desa.c) /*CAMPO -'NOME DO PN' (tccom100.nama) | CAMPO - NOME EMPRESARIAL (tdzbi001.desa.c)*/
			if isspace(tdzbi001.bpid.c) then /*CAMPO - CÓDIGO PN*/
				dal.set.field("tccom100.cmid", tdzbi001.desa.c) /*CAMPO - IDENTIFICAÇÃO COMERCIAL (tccom100.cmid)| CAMPO - NOME EMPRESARIAL (tdzbi001.desa.c)*/
			else
				dal.set.field("tccom100.cmid", tdzbi001.bpid.c) /*CAMPO - IDENTIFICAÇÃO COMERCIAL (tccom100.cmid)| CAMPO - NOME FANTASIA (tdzbi001.bpid.c)*/
			endif
			dal.set.field("tccom100.arfb.c", date.num()) /*CAMPO - ÚLTIMA CONSULTA RFB (tccom100.arfb.c)*/
			dal.set.field("tccom100.srfb.c", tcyesno.no) /*CAMPO - RECEITA FEDERAL (FLAG) (tccom100.srfb.c)*/
			break
		case "4":
			dal.set.field("tccom100.arfb.c", date.num()) /*CAMPO - ÚLTIMA CONSULTA RFB (tccom100.arfb.c)*/
			dal.set.field("tccom100.srfb.c", tcyesno.no) /*CAMPO - RECEITA FEDERAL (FLAG) (tccom100.srfb.c)*/
			break
		case "7":
			dal.set.field("tccom100.tpis.o", tdzbi001.tpis.c) /* TIPO DE INCENTIVO (tccom100.tpis.o) | TIPO DE INCENTIVO (tdzbi001.tpis.c)*/
			dal.set.field("tccom100.asuf.c", date.num()) /*CAMPO - ÚLTIMA CONSULTA SUFRAMA (tccom100.asuf.c)*/
			dal.set.field("tccom100.ssuf.c", tcyesno.no) /*CAMPO - SUFRAMA (FLAG) (tccom100.ssuf.c)*/
			break
		endcase
	
		if tccom100.srfb.c = tcyesno.yes or /*CAMPO - RECEITA FEDERAL (FLAG) (tccom100.srfb.c)*/
		   tccom100.ssin.c = tcyesno.yes or /*CAMPO - SINTEGRA (FLAG) (tccom100.ssin.c)*/
		   tccom100.ssuf.c = tcyesno.yes then /*CAMPO - SUFRAMA (FLAG) (tccom100.ssuf.c)*/
			dal.set.field("tccom100.btbv", tcyesno.yes) /*CAMPO - A SER VERIFICADO (FLAG) (tccom100.btbv)*/
		else
			dal.set.field("tccom100.btbv", tcyesno.no) /*CAMPO - A SER VERIFICADO (FLAG) (tccom100.btbv)*/
		endif
	/*e = dal.save.object("tccom100"): Salva as modificações feitas no objeto tccom100.*/
		e = dal.save.object("tccom100") /* PARCEIRO DE NEGÓCIOS */
		
		select	tccom130.*
		from	tccom130 for update
		where	tccom130._index1 = { :tccom100.cadr } /*CAMPO - CÓDIGO DE ENDEREÇO */
		selectdo
	/*O objeto dal.change.object("tccom130") é modificado, provavelmente indicando que o objeto tccom130 será alterado.*/
			e = dal.change.object("tccom130")
			
			on case trim$(tdzbi001.codc.c) /* DADOS DE RETORNO RFB - CÓDIGO CONSULTA */
			case "3":
				dal.set.field("tccom130.nama", tdzbi001.desa.c) /* CAMPO - 'NOME PN' (tccom130.nama) | CAMPO - NOME EMPRESARIAL (tdzbi001.desa.c)*/
				dal.set.field("tccom130.namc", tdzbi001.namc.c) /* CAMPO - RUA (tccom130.namc) | CAMPO - LOGRADOURO (tdzbi001.namc.c)*/
				dal.set.field("tccom130.hono", tdzbi001.hono.c) /* CAMPO - NÚMERO LOCAL (tccom130.hono) | CAMPO - NÚMERO (tdzbi001.hono.c)*/
								|#051223.so
				|dal.set.field("tccom130.bldg", tdzbi001.bldg.c)/* CAMPO - PRÉDIO (tccom130.bldg) | CAMPO - COMPLEMENTO (tdzbi001.bldg.c)*/
								|#051223.so
								|#051223.sn
				dal.set.field("tccom130.namd", tdzbi001.xcpl.c) /* CAMPO - ENDEREÇO 2 (tccom130.namd) | CAMPO - COMPLEMENTO (tdzbi001.xcpl.c)*/
								|#051223.en
				dal.set.field("tccom130.dist.l", tdzbi001.dist.c) /* CAMPO - BAIRRO (tccom130.dist.l) | CAMPO - BAIRRO (tdzbi001.dist.c)*/
				dal.set.field("tccom130.ccit", tdzbi001.ccit.c) /* CAMPO - CÓDIGO CIDADE (tccom130.ccit) | CAMPO - MUNICIPIO (tdzbi001.ccit.c)*/
				dal.set.field("tccom130.cste", tdzbi001.cste.c) /* CAMPO - UF (tccom130.cste) | CAMPO - UF (tdzbi001.cste.c)*/
				dal.set.field("tccom130.pstc", tdzbi001.pstc.c) /* CAMPO - CÓDIGO POSTAL (tccom130.cste) | CAMPO - CEP (tdzbi001.pstc.c)*/
				break
			endcase	
								|#051223.so
								|#040219.sn
			|dal.set.field("tccom130.xcpl.l", tdzbi001.xcpl.c) /* CAMPO - COMPLEMENTO DE NFE(tccom130.xcpl.l) | */	
								|#040219.en
								|#051223.eo
								
	/*e = dal.save.object("tccom130"): Salva as modificações feitas no objeto tccom130.*/							
			e = dal.save.object("tccom130") /* ENDEREÇOS */
			
			select	tccom938.*
			from	tccom938 for update
			where	tccom938._index1 = { :tccom130.ftyp.l, :tccom130.fovn.l } /* CAMPO - TIPO IDENTIFICADOR FISCAL (tccom130.ftyp.l) | ENTIDADE FISCAL (tccom130.fovn.l)*/	
			selectdo
				e = dal.change.object("tccom938") /* ENTIDADE FISCAL */
	/*Dependendo do valor de tdzbi001.codc.c, diferentes ações são executadas:*/
				on case trim$(tdzbi001.codc.c)
	/*Se tdzbi001.codc.c for igual a "1", uma nova consulta é feita na tabela tccom120 com algumas condições, e um conjunto de colunas dessa tabela é selecionado. Se houver resultados, algumas modificações são feitas na tabela tccom938.*/			
				case "1":			|#023237.sn
					select	tccom120.*
					from	tccom120
					where	tccom120._index1 = { :tccom100.bpid } /*CAMPO - PARCEIRO DE NEGÓCIOS (tccom100.bpid)*/
					and	tccom120.cbtp = :tczbr000.crps.c /*CAMPO - TIPO PARCEIRO DE NEGÓCIOS (tccom120.cbtp) = REPRESENTANTE SEM IE (tczbr000.crps.c)*/
					as set with 1 rows
					selectdo
						dal.set.field("tccom938.ficu.l", /*CAMPO - CONSUMIDOR FINAL (tccom938.ficu.l)*/
									tcyesno.yes)
					endselect
					break			|#023237.en
	/*Se tdzbi001.codc.c for igual a "3", várias colunas da tabela tccom938 são atualizadas com os valores de colunas da tabela tdzbi001.*/				
				case "3":
					dal.set.field("tccom938.desa.l", tdzbi001.desa.c) /*CAMPO - RAZÃO SOCIAL (tccom938.ficu.l) | NOME EMPRESARIAL (tdzbi001.desa.c) */
					dal.set.field("tccom938.dtfu.c", /*CAMPO - DATA DA FUNDAÇÃO (tccom938.ficu.l)*/
						inputstr.to.date(utc.to.input( 
						tdzbi001.dtfu.c, "%u002"), "%D002")) /*CAMPO - DATA DE ABERTURA (tdzbi001.dtfu.c)*/
					dal.set.field("tccom938.srfb.c",tdzbi001.srfb.c) /*CAMPO - SITUAÇÃO RFB (tccom938.srfb.c) | SITUAÇÃO RFB (tdzbi001.srfb.c)*/
					dal.set.field("tccom938.drfb.c",tdzbi001.drfb.c) /*CAMPO - DATA SITUAÇÃO CADASTRAL (tccom938.drfb.c) | DATA SITUAÇÃO RFB (tdzbi001.drfb.c)*/
					dal.set.field("tccom938.serf.c",tdzbi001.serf.c) /*CAMPO - SITUAÇÃO ESPECIAL RFB (tccom938.drfb.c) | SITUAÇÃO ESPECIAL RFB (tdzbi001.serf.c)*/
					dal.set.field("tccom938.dsrf.c",tdzbi001.dsrf.c) /*CAMPO - DATA SITUAÇÃO ESPCECIAL (tccom938.dsrf.c) | DATA SITUAÇÃO ESPCECIAL (tdzbi001.dsrf.c)*/
					break
	/*Se tdzbi001.codc.c for igual a "4", algumas colunas da tabela tccom938 são atualizadas com valores específicos.*/				
				case "4":
					dal.set.field("tccom938.ficu.l", tcyesno.yes)		|#023237.n /*CAMPO - CONSUMIDOR FINAL (tccom938.ficu.l)*/
					dal.set.field("tccom938.srfb.c", tdzbi001.srfb.c) /*CAMPO - SITUAÇÃO RFB (tccom938.srfb.c) | SITUAÇÃO RFB (tdzbi001.srfb.c)*/
					dal.set.field("tccom938.drfb.c", tdzbi001.drfb.c) /*CAMPO - DATA SITUAÇÃO CADASTRAL (tccom938.drfb.c) | DATA SITUAÃO RFB (tdzbi001.drfb.c)*/
					break
				endcase
				
	/*e = dal.save.object("tccom938"): Salva as modificações feitas no objeto tccom938.*/			
				e = dal.save.object("tccom938")
			endselect
		
			select	tccom966.*
			from	tccom966 for update
			where	tccom966._index1 = { :tccom130.comp.d } /*CAMPO - COMPLEMENTO FISCAL (tccom130.comp.d)*/
			selectdo
				e = dal.change.object("tccom966") /* COMPLEMENTO FISCAL */
				
				on case trim$(tdzbi001.codc.c) /* DADOS DE RETORNO RFB - CÓDIGO CONSULTA */
				case "1":
					dal.set.field("tccom966.stin.d", tdzbi001.stin.c) /*CAMPO - INSCRIÇÃO ESTADUAL (tccom966.stin.d) | INSCRIÇÃO ESTADUAL (tdzbi001.stin.c)*/
					dal.set.field("tccom966.ssin.c", tdzbi001.ssin.c) /*CAMPO - SITUAÇÃO SINTEGRA (tccom966.ssin.c) | SITUAÇÃO CADASTRAL VIGENTE (tdzbi001.ssin.c)*/
					dal.set.field("tccom966.dtsi.c", tdzbi001.dtsi.c) /*CAMPO - DATA SITUAÇÃO SINTEGRA (tccom966.dtsi.c) | DATA DESSA SITUAÇÃO CADASTRAL (tdzbi001.dtsi.c)*/
								|#021561.sn
					if isspace(tccom966.stin.d) then
						dal.set.field("tccom966.cicm.l", tcyesno.no) /*CAMPO - CONTRIBUINTE DE ICMS (tccom966.cicm.l)*/
 						|#BDL.113667.sn	|#BDL.114830.so
| 						set.all.entities.to.CSI.c(
| 								tccom100.bpid)
 						|#BDL.113667.en	|#BDL.114830.eo
					else
						dal.set.field("tccom966.cicm.l", tcyesno.yes) /*CAMPO - CONTRIBUINTE DE ICMS (tccom966.cicm.l)*/
 						|#BDL.113667.sn	|#BDL.114830.so
| 						set.all.entities.to.CFN.c(
| 								tccom100.bpid)
 						|#BDL.113667.en	|#BDL.114830.eo
					endif			|#021561.en
					break
				case "3":
| 					dal.set.field("tccom966.desa.l", tdzbi001.desa.c)	|#021561.o
					dal.set.field("tccom966.desa.d", tdzbi001.desa.c)	|#021561.n  /*CAMPO - DESCRIÇÃO (tccom966.desa.d) | NOME EMPRESARIAL (tdzbi001.desa.c) */
					dal.set.field("tccom966.cnae.l", tdzbi001.cena.c) /*CAMPO - CNAE FISCAL (tccom966.cnae.l) | CNAE FISCAL (tdzbi001.cena.c) */
					dal.set.field("tccom966.ntjd.c", tdzbi001.ntjd.c) /*CAMPO - NATUREZA JURIDICA (tccom966.ntjd.c) | NATUREZA JURIDICA (tdzbi001.ntjd.c )*/
					break
				case "7":
					dal.set.field("tccom966.ssuf.l", tdzbi001.ssuf.c) /*CAMPO - SITUAÇÃO SUFRAMA (tccom966.ssuf.l) | SITUAÇÃO CADASTRAL SUFRAMA (tdzbi001.ssuf.c)*/
					dal.set.field("tccom966.insu.l", tdzbi001.insu.c) /*CAMPO - INSCRIÇÃO SUFRAMA (tccom966.insu.l) | INSCRIÇÃO SUFRAMA (tdzbi001.insu.c)*/
					dal.set.field("tccom966.dsuf.c", tdzbi001.dvsu.c) /*CAMPO - DATA DE VALIDADE DO SUFRAMA (tccom966.dsuf.c) | DATA DE VALIDADE (tdzbi001.dvsu.c) */
					break
				endcase
								|#BDL.114830.sn
				if tccom100.ctit = tczbr000.idcl.c then /*CAMPO - TÍTULO (tccom100.ctit) = IDENTIFICAÇÃO CLIENTE (tczbr000.idcl.c)*/
					define.entities.c()
				endif 				|#BDL.114830.en
	/*e = dal.save.object("tccom966"): Salva as modificações feitas no objeto tccom966.*/			
				e = dal.save.object("tccom966")
			endselect
		endselect
	endselect

	on case trim$(tdzbi001.codc.c) /* DADOS DE RETORNO RFB - CÓDIGO CONSULTA */
	/* Verifica se o valor do campo tdzbi001.codc.c é igual a "3". Se for o caso, entra no bloco case "3"*/
	case "3":
		select	tccom133.*
		from	tccom133
		where	tccom133._index1 = { :tczbr012.bpid.c } /*CAMPO - PARCEIRO DE NEGÓCIOS (tczbr012.bpid.c)*/
		selectdo
			select	tccom130.*
			from	tccom130 for update
			where	tccom130._index1 = { :tccom133.cadr } /*CAMPO - ENDEREÇO (tccom133.cadr)*/
			selectdo
				e = dal.change.object("tccom130")  /* ADDRESSES */
				
	/*dal.set.field(...): Essas instruções definem valores para diferentes campos do objeto tccom130 usando os dados vindos de várias fontes, como tdzbi001.desa.c, tczbr000.coaf.c, tdzbi001.xcpl.c, etc.*/			
				dal.set.field("tccom938.desa.l", tdzbi001.desa.c)           /*CAMPO - RAZÃO SOCIAL (tccom938.desa.l) | NOME EMPRESARIAL (tdzbi001.desa.c)*/
				dal.set.field("tccom130.coaf", tczbr000.coaf.c)             /*CAMPO - FORMATO DE ENDEREÇO (tccom130.coaf) | FORMATO DE ENDEREÇO (tczbr000.coaf.c) */
				dal.set.field("tccom130.afal", tczbr000.coaf.c)	|#021561.n  /*CAMPO - FORMATO DE ENDEREÇO P/ LINHA (tccom130.afal) | FORMATO DE ENDEREÇO (tczbr000.coaf.c)*/
				
	/*tccom.dll4030.read.city.dsca(...): Esta parece ser uma chamada de função que lê informações relacionadas à cidade e formata essas informações para serem usadas.*/			
				e = tccom.dll4030.read.city.dsca(
							tccom130.ccty, /*CAMPO - COUNTRY (tccom130.ccty)*/
							tccom130.cste, /*CAMPO - ESTADO/PROVÍNCIA (tccom130.cste)*/
							tccom130.ccit, /*CAMPO - CIDADE (tccom130.ccit)*/
							tccom130.dsca) /*CAMPO - DESCRIÇÃO DA CIDADE (tccom130.dsca)*/
							
	/*tccom.dll4035.format.address(...): Esta é outra chamada de função que formata o endereço e o armazena em diferentes campos do objeto tccom130*/			
				tccom.dll4035.format.address(tccom130.cadr,
							10, sline, "", true)
				dal.set.field("tccom130.ln01", sline(1,1)) /*CAMPO - LINHA DE ENDEREÇO 1 (tccom130.ln01)*/
				dal.set.field("tccom130.ln02", sline(1,2)) /*CAMPO - LINHA DE ENDEREÇO 2 (tccom130.ln02)*/
				dal.set.field("tccom130.ln03", sline(1,3)) /*CAMPO - LINHA DE ENDEREÇO 3 (tccom130.ln03)*/
				dal.set.field("tccom130.ln04", sline(1,4)) /*CAMPO - LINHA DE ENDEREÇO 4 (tccom130.ln04)*/
				dal.set.field("tccom130.ln05", sline(1,5)) /*CAMPO - LINHA DE ENDEREÇO 5 (tccom130.ln05)*/
				dal.set.field("tccom130.ln06", sline(1,6)) /*CAMPO - LINHA DE ENDEREÇO 6 (tccom130.ln06)*/
								|#040219.sn
				dal.set.field("tccom130.xcpl.l", tdzbi001.xcpl.c)	/*CAMPO - COMPLEMENT FOR NFE(tccom130.xcpl.l) | COMPLEMENTO (tdzbi001.xcpl.c)*/
								|#040219.en
								
	/*e = dal.save.object("tccom130"): Salva as modificações feitas no objeto tccom130.*/								
				e = dal.save.object("tccom130")
			endselect
		endselect
		break
	endcase

	select	tczbr012.*
	from	tczbr012 for update
	where	tczbr012._index1 = { :tczbr012.bpid.c } /*CAMPO - PARCEIRO DE NEGÓCIOS (tczbr012.bpid.c)*/
	selectdo
		on case trim$(tdzbi001.codc.c) /* DADOS DE RETORNO RFB - CÓDIGO CONSULTA */
		case "1":
			tczbr012.csin.c = tcyesno.no /*CAMPO - SINTEGRA (tczbr012.csin.c) (FLEG)*/
			break
		case "3":
		case "4":
			tczbr012.crfb.c = tcyesno.no /*CAMPO - RECEITA FEDERAL (tczbr012.crfb.c)(FLEG) */
			break
		case "7":
			tczbr012.csuf.c = tcyesno.no /*CAMPO - SUFRAMA (tczbr012.csuf.c) (FLEG)*/
			break
		endcase
	
		if tczbr012.pend.c = tcyesno.no and /* OUTRAS PENDENCIAS (tczbr012.pend.c)*/
		   tczbr012.crfb.c = tcyesno.no and /* RFB (tczbr012.crfb.c)*/
		   tczbr012.csin.c = tcyesno.no and /* SIN (tczbr012.csin.c)*/
		   tczbr012.csuf.c = tcyesno.no then /* SUF (tczbr012.csuf.c)*/
			select	tczbr013.*
			from	tczbr013 for update
			where	tczbr013._index1 = { :tczbr012.bpid.c } /*CAMPO - PARCEIRO DE NEGÓCIOS (tczbr012.bpid.c)*/
			selectdo
				db.delete(ttczbr013, db.retry)
			endselect
		
			select	tczbr014.*
			from	tczbr014 for update
			where	tczbr014._index1 = { :tczbr012.bpid.c } /*CAMPO - PARCEIRO DE NEGÓCIOS (tczbr012.bpid.c)*/
			selectdo
				db.delete(ttczbr014, db.retry)
			endselect
		
			tczbr012.verf.c = tcyesno.yes  /*SANEADO (tczbr012.verf.c)*/
		endif
	
		db.update(ttczbr012, db.retry)
	endselect
	
	/*commit.transaction(): Confirma a transação, indicando que todas as alterações realizadas no banco de dados devem ser permanentes.*/
	commit.transaction()
}
