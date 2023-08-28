|******************************************************************************
|* tczbrc111  0  VRC B61C a7 bdl0
|* Cadastro de Erros Retorno Saneamento Cadastral
|* Rogerio Morgante                                                                                                        
|* 2012-05-15
|******************************************************************************
|* Main table tczbr011 Cadastro de Erros Retorno Saneamento Cadastral, Form Type 1
|******************************************************************************
|* TIM.442, Tiago Mira, 2014-09-25, B61U_a_prd0
|* CRVE096.
|******************************************************************************
                                                                                
|****************************** declaration section ***************************
declaration:
#ident "@(#)TIM.442, Tiago Mira, 2014-09-25, B61U_a_prd0"

	table	ttczbr011	|* Cadastro de Erros Retorno Saneamento
	table	ttczbr003

|****************************** field section *********************************
field.tczbr011.moti.c: * CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
before.zoom:
	on case tczbr011.acao.c /* CAMPO - AÇÃO (tczbr011.acao.c) */
	case tczbr.reto.c.canc:
		query.extend.where.in.zoom("tczbr003._index1 = { tccom.prst.cancel }")
		break
	case tczbr.reto.c.susp:
		query.extend.where.in.zoom("tczbr003._index1 = { tccom.prst.suspended }")
		break
	endcase

field.tczbr003.desc.c: /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
before.display:
	on case tczbr011.acao.c /* CAMPO - AÇÃO (tczbr011.acao.c) */
	case tczbr.reto.c.canc:
		select	tczbr003.desc.c /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
		from	tczbr003
		where	tczbr003._index1 = { tccom.prst.cancel,
					     :tczbr011.moti.c } /* CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
		as set with 1 rows
		selectdo
		selectempty
			db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
		endselect
		break
	case tczbr.reto.c.susp:
		select	tczbr003.desc.c /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
		from	tczbr003
		where	tczbr003._index1 = { tccom.prst.suspended,
					     :tczbr011.moti.c } /* CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
		as set with 1 rows
		selectdo
		selectempty
			db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
		endselect
		break
	default:
		db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
	endcase
