SELECT
A.CODIGO_CLIENTE,
A.TIPO_VAREJO,
A.CLIENTE_VAREJO,
A.FILIAL,
A.LIMITE_CREDITO_TOTAL,
A.SALDO_LIMITE,
A.CADASTRAMENTO,
A.DATA_PARA_TRANSFERENCIA,
A.ULTIMA_COMPRA

FROM CLIENTES_VAREJO A
WHERE A.TIPO_VAREJO = 'FUNCIONARIO'
AND A.LIMITE_CREDITO_TOTAL > 0
AND (A.SALDO_LIMITE = 0 OR A.SALDO_LIMITE IS NULL)
AND A.FILIAL IN ('BRANDILI TEXTIL LTDA', 'BRANDILI TEXTIL FILIAL', 'LOJA BRANDILI CAB', 'OTACILIO COSTA', 'MATRIZ', 'MALHAS JN LTDA.')


