****************************** field section *********************************
field.tczbr011.moti.c: /* CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
before.zoom:
	on case tczbr011.acao.c /* CAMPO - AÇÃO (tczbr011.acao.c) */
	case tczbr.reto.c.canc:
/* Uma cláusula query.extend.where.in.zoom é usada para estender a cláusula WHERE de uma consulta. */	
/* A condição adicionada à consulta é que tczbr003._index1 seja igual a tccom.prst.cancel, valor predefinido para o status 'cancelado'.*/		
		query.extend.where.in.zoom("tczbr003._index1 = { tccom.prst.cancel }")
		break
	case tczbr.reto.c.susp:
/*A condição adicionada à consulta é que tczbr003._index1 seja igual a tccom.prst.suspended, valor predefinido para o status 'suspenso'.*/
		query.extend.where.in.zoom("tczbr003._index1 = { tccom.prst.suspended }")
		break
	endcase

field.tczbr003.desc.c: /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
before.display:
	on case tczbr011.acao.c /* CAMPO - AÇÃO (tczbr011.acao.c) */
	case tczbr.reto.c.canc:
		select	tczbr003.desc.c /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
		from	tczbr003
/* A condição WHERE da consulta é que tczbr003._index1 seja igual a tccom.prst.cancel e tczbr011.moti.c. */		
		where	tczbr003._index1 = { tccom.prst.cancel,
					     :tczbr011.moti.c } /* CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
/* O resultado da consulta é esperado que tenha uma única linha (as set with 1 rows). */						 
		as set with 1 rows
		selectdo
		selectempty
			db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
		endselect
		break
	case tczbr.reto.c.susp:
		select	tczbr003.desc.c /* CAMPO - DESCRIÇÃO (tczbr003.desc.c ) */
		from	tczbr003
/* A condição WHERE da consulta é que tczbr003._index1 seja igual a tccom.prst.suspended e tczbr011.moti.c. */		
		where	tczbr003._index1 = { tccom.prst.suspended,
					     :tczbr011.moti.c } /* CAMPO - MOTIVO DE STATUS (tczbr011.moti.c) */
/* O resultado da consulta é esperado que tenha uma única linha (as set with 1 rows). */						 
		as set with 1 rows
		selectdo
		selectempty
			db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
		endselect
		break
	default:
		db.set.to.default(ttczbr003) /* TABELA - CADASTRO DE MOTIVOS DE STATUS PARA PARCEIRO DE NEGÓCIOS */
	endcase
