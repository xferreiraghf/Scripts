-- tarifador_fatura definition

CREATE TABLE "tarifador_fatura" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "fatura" varchar(100) NOT NULL, "num_nf" varchar(100) NOT NULL, "cnpj" varchar(20) NOT NULL, "valor_fatura" decimal NOT NULL, "valor_nf" decimal NOT NULL);
