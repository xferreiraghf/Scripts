-- tarifador_custo definition

CREATE TABLE "tarifador_custo" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "unidade" varchar(255) NOT NULL, "usuario" varchar(255) NOT NULL, "centro_custo" integer NOT NULL, "telefone" varchar(20) NOT NULL UNIQUE, "situacao" varchar(10) NOT NULL, "data_registro" datetime NOT NULL);
