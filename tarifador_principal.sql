-- tarifador_principal definition

CREATE TABLE "tarifador_principal" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "NumNF" varchar(100) NOT NULL, "MesRef" varchar(100) NOT NULL, "NumAcs" varchar(100) NOT NULL, "Valor" decimal NOT NULL);
