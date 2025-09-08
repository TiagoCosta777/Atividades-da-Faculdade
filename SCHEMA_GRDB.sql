CREATE DATABASE Sistema_Informações_Hospitalares
GO

USE Sistema_Informações_Hospitalares
GO


CREATE TABLE Regiao(
Id_Regiao INT PRIMARY KEY NOT NULL,
Nome VARCHAR(200) NOT NULL
)

CREATE TABLE Nivel_de_Escolaridade(
Id_Escolaridade INT PRIMARY KEY NOT NULL,
Descrição_Escolaridade VARCHAR(250)
)

CREATE TABLE Tipo_Unidade(
Id_Tipo_Unidade INT PRIMARY KEY NOT NULL,
Ds_Tipo_Unidade VARCHAR(200)
)

CREATE TABLE Tipo_Atendimento(
Id_tipo_Atendimento INT PRIMARY KEY NOT NULL,
Descricao VARCHAR(250)
)

CREATE TABLE Tipo_Leito(
Id_Tipo_Leito INT PRIMARY KEY NOT NULL,
Descricao VARCHAR(250),
Categoria VARCHAR(50)
)


CREATE TABLE CID10(
Id_CID10 INT PRIMARY KEY NOT NULL,
Descricao VARCHAR(250),
Notificacao_Compulsoria INT,
Capitulo VARCHAR(100)
 )

 CREATE TABLE Especialidade_Medica(
 Id_Especialidade INT PRIMARY KEY NOT NULL,
 Nome VARCHAR(100),
 Descricao VARCHAR(250)
 )

 CREATE TABLE Classificacao_Risco(
 Id_Class_Risco INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(250)
 )

 CREATE TABLE Tipo_Recurso(
 Id_Tipo_Recurso INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(250)
 )

 CREATE TABLE Tipo_Demanda(
 Id_Tipo_Demanda INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(250)
 )

 CREATE TABLE Faixa_Etaria(
 Id_Faixa_Etaria INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(50),
 Min_Idade INT,
 Max_Idade INT
 )

 CREATE TABLE RACA_COR(
 Id_raca INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(20)
 )

 CREATE TABLE Natureza_Juridica(
 Id_Natureza_Juridica INT PRIMARY KEY NOT NULL,
 Tipo INT,
 Justificativas_AUD VARCHAR(250),
 Justificativas_SIS VARCHAR(250),
 Descricao VARCHAR(250)
 )

 CREATE TABLE UF(
 Id_Uf INT PRIMARY KEY NOT NULL,
 Id_Regiao INT NOT NULL,
 Sigla CHAR(2),
 Nome VARCHAR(100)
 FOREIGN KEY(Id_Regiao) REFERENCES Regiao(Id_Regiao)
 )
 --OBSERVACÃO A POPULAÇÃO ESTIMADA NÃO FAZ SENTIDO SER INT
 CREATE TABLE Municipio(
 Id_Municipio INT PRIMARY KEY NOT NULL,
 Id_Uf INT NOT NULL,
 Nome VARCHAR(100),
 Populacao_Estimada INT
 FOREIGN KEY(Id_Uf)  REFERENCES UF(Id_Uf)
 )

