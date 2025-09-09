CREATE DATABASE Sistema_Informações_Hospitalares
GO

USE Sistema_Informações_Hospitalares
GO


CREATE TABLE Regiao(
Id_Regiao INT PRIMARY KEY IDENTITY(1,1),
Nome VARCHAR(200) NOT NULL
);
GO

CREATE TABLE Nivel_de_Escolaridade(
Id_Escolaridade INT PRIMARY KEY IDENTITY(1,1),
Descrição_Escolaridade VARCHAR(250)
);
GO
 
CREATE TABLE Tipo_Unidade(
Id_Tipo_Unidade INT PRIMARY KEY IDENTITY(1,1),
Ds_Tipo_Unidade VARCHAR(200) NULL
);
GO

CREATE TABLE Tipo_Atendimento(
Id_tipo_Atendimento INT PRIMARY KEY IDENTITY(1,1),
Descricao VARCHAR(250) NULL
);
GO

CREATE TABLE Tipo_Leito(
Id_Tipo_Leito INT PRIMARY KEY IDENTITY(1,1),
Descricao VARCHAR(250) NULL,
Categoria VARCHAR(50) NULL
);
GO

CREATE TABLE CID10(
Id_CID10 INT PRIMARY KEY IDENTITY(1,1),
Descricao VARCHAR(250) NULL,
Notificacao_Compulsoria INT NULL,
Capitulo VARCHAR(100) NULL
 );
 GO

 CREATE TABLE Especialidade_Medica(
 Id_Especialidade INT PRIMARY KEY IDENTITY(1,1),
 Nome VARCHAR(100) NOT NULL,
 Descricao VARCHAR(250) NULL
 );
 GO
  
 CREATE TABLE Classificacao_Risco(
 Id_Class_Risco INT PRIMARY KEY IDENTITY(1,1),
 Descricao VARCHAR(250) NULL
 );
 GO

 CREATE TABLE Tipo_Recurso(
 Id_Tipo_Recurso INT PRIMARY KEY NOT NULL,
 Descricao VARCHAR(250)
 );
 GO

 CREATE TABLE Tipo_Demanda(
 Id_Tipo_Demanda INT PRIMARY KEY IDENTITY(1,1),
 Descricao VARCHAR(250) NULL
 );
 GO

 CREATE TABLE Faixa_Etaria(
 Id_Faixa_Etaria INT PRIMARY KEY IDENTITY(1,1),
 Descricao VARCHAR(50) NULL,
 Min_Idade INT NULL,
 Max_Idade INT NULL
 );
 GO

 CREATE TABLE RACA_COR(
 Id_raca INT PRIMARY KEY IDENTITY(1,1),
 Descricao VARCHAR(20) NULL
 );
 GO

 CREATE TABLE Natureza_Juridica(
 Id_Natureza_Juridica INT PRIMARY KEY IDENTITY(1,1),
 Tipo INT NULL,
 Justificativas_AUD VARCHAR(250) NULL,
 Justificativas_SIS VARCHAR(250) NULL,
 Descricao VARCHAR(250) NULL
 );
 GO

 CREATE TABLE UF(
 Id_Uf INT PRIMARY KEY IDENTITY(1,1),
 Id_Regiao INT NOT NULL,
 Sigla CHAR(2) NOT NULL,
 Nome VARCHAR(100) NOT NULL
 FOREIGN KEY(Id_Regiao) REFERENCES Regiao(Id_Regiao) ON DELETE CASCADE
 );
 GO
 --OBSERVACÃO A POPULAÇÃO ESTIMADA NÃO FAZ SENTIDO SER INT
 CREATE TABLE Municipio(
 Id_Municipio INT PRIMARY KEY IDENTITY(1,1),
 Id_Uf INT NOT NULL,
 Nome VARCHAR(100) NOT NULL,
 Populacao_Estimada INT NULL
 FOREIGN KEY(Id_Uf)  REFERENCES UF(Id_Uf) ON DELETE CASCADE
 );
 GO

 CREATE TABLE Endereco_Hospital(
 Id_Endereco INT PRIMARY KEY IDENTITY(1,1),
 No_Logadouro VARCHAR(250) NOT NULL,
 Nu_Endereco VARCHAR(20) NULL,
 No_Complemento VARCHAR(100) NOT NULL,
 No_Bairro VARCHAR(100) NOT NULL,
 Co_Cep CHAR(8) NULL,
 Nu_Telefone VARCHAR(20) NULL,
 No_Email VARCHAR(255) NOT NULL
 );
 GO

 CREATE TABLE Hospital(
CNES CHAR(7) PRIMARY KEY NOT NULL,
Id_Municipio INT NOT NULL,
Id_Natureza_Juridica INT NOT NULL,
Id_Uf INT NOT NULL,
Id_Endereco INT NOT NULL,
Nome_Hospital VARCHAR(200) NOT NULL,
Tipo_Gestao VARCHAR(100) NULL,
Razao_Social VARCHAR(200) NOT NULL,
CNPJ CHAR(14) NOT NULL,
Complexidade_Hospitalar INT NOT NULL,
Contato VARCHAR(200) NOT NULL,
CNAER INT NOT NULL,
CBOR INT NOT NULL,
Qt_Diaria_Acomp INT 
FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio) ON DELETE CASCADE,
FOREIGN KEY (Id_Natureza_Juridica) REFERENCES Natureza_Juridica(Id_Natureza_Juridica) ON DELETE CASCADE,
FOREIGN KEY (Id_Uf) REFERENCES UF(Id_Uf) ON DELETE CASCADE,
FOREIGN KEY (Id_Endereco) REFERENCES Endereco_Hospital(Id_Endereco) ON DELETE CASCADE
);
GO

CREATE TABLE Leito(
Id_Leito INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL,
Id_Tipo_Leito INT NOT NULL,
Quantidade_Existentes INT NULL, 
Quantidade_Sus INT NULL,
Leitos_SUS NUMERIC(6, 0) NULL,
Leitos_Existentes NUMERIC(6, 0) NULL
FOREIGN KEY(CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE,
FOREIGN KEY(Id_Tipo_Leito) REFERENCES Tipo_Leito(Id_Tipo_Leito) ON DELETE CASCADE
);
GO

CREATE TABLE Profissional_Saude(
Id_Profissional_Saude INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL,
Id_Especialidade INT NOT NULL,
Nome VARCHAR(100) NOT NULL,
Cargo_Funcao VARCHAR(100) NULL
FOREIGN KEY(CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE,
FOREIGN KEY(Id_Especialidade) REFERENCES Especialidade_Medica(Id_Especialidade) ON DELETE CASCADE
);

GO
-- OBS A VERSÃO DEVERIA SER INT?

CREATE TABLE Recurso_Hospitalar(
Id_Recurso_Hospitalar INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL,
Id_Tipo_Recurso INT NOT NULL,
Nome VARCHAR(100) NOT NULL,
Descricao VARCHAR(250) NULL,
Quantidade INT NULL,
Valor_Alocado DECIMAL(10, 2) NULL,
Data_Validade DATE NULL,
Orgao_Responsavel CHAR(2) NULL,
Versao INT NULL,
Periodo_Vigencia DATE NULL,
Estado_Conservacao VARCHAR(100) NULL,
Fornecedor VARCHAR(100) NULL
FOREIGN KEY(CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE,
FOREIGN KEY(Id_Tipo_Recurso) REFERENCES Tipo_Recurso(Id_Tipo_Recurso) ON DELETE CASCADE
);
GO

CREATE TABLE Demanda_Hospitalar(
Id_Demanda INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL,
Id_Tipo_Demanda INT NOT NULL,
Data DATE NULL,
Qt_Solicitacao INT NULL,
Tempo_Medio_Espera TIME NULL
FOREIGN KEY(CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE,
FOREIGN KEY(Id_Tipo_Demanda) REFERENCES Tipo_Demanda(Id_Tipo_Demanda) ON DELETE CASCADE
);
GO

CREATE TABLE Indicador_Qualidade(
Id_Indicador_Qualidade INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL,
Metodo_Calculo VARCHAR(250) NULL,
Meta DECIMAL(10, 2) NULL,
Descricao VARCHAR(250) NULL
FOREIGN KEY (CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE
);
GO

CREATE TABLE Servico_Saude(
Id_Servico_Saude INT PRIMARY KEY IDENTITY(1,1),
CNES CHAR(7) NOT NULL, 
Nome VARCHAR(100) NOT NULL,
Descricao VARCHAR(250) NULL
FOREIGN KEY (CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE
);
GO

CREATE TABLE Paciente(
Id_Paciente INT PRIMARY KEY IDENTITY(1,1),
Id_Municipio INT NOT NULL,
Id_Raca INT NOT NULL,
Id_Escolaridade INT NOT NULL,
Nomes_Semelhantes BIT NULL,
Idade INT NULL,
Etnia VARCHAR(100) NULL,
Nacionalidade VARCHAR(50) NULL,
Data_Nascimento DATE NULL,
Sexo CHAR(1) NULL,
Num_Filhos INT NULL
FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio) ON DELETE CASCADE,
FOREIGN KEY (Id_Raca) REFERENCES Raca_Cor(Id_Raca) ON DELETE CASCADE,
FOREIGN KEY (Id_Escolaridade) REFERENCES Nivel_De_Escolaridade(Id_Escolaridade) ON DELETE CASCADE
);
GO


CREATE TABLE Atendimento(
Id_Atendimento INT PRIMARY KEY IDENTITY(1,1),
Id_Paciente INT NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Class_Risco INT NOT NULL,
Id_Tipo_Atendimento INT NOT NULL,
Data_Hora DATE NULL,
Inscricao_Paciente VARCHAR(250) NULL,
Total_Usuarios_Atendidos INT NULL
FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente) ON DELETE CASCADE,
FOREIGN KEY (CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE,
FOREIGN KEY (Id_Class_Risco) REFERENCES Classificacao_Risco(Id_Class_Risco) ON DELETE CASCADE,
FOREIGN KEY (Id_Tipo_Atendimento) REFERENCES Tipo_Atendimento(Id_Tipo_Atendimento) ON DELETE CASCADE
);
GO

CREATE TABLE Procedimento_Medico(
Id_Procedimento_Medico INT PRIMARY KEY IDENTITY(1,1),
Descricao VARCHAR(250) NULL,
Val_Sh DECIMAL(15, 2) NULL,
Val_Sp DECIMAL(15, 2) NULL,
Val_Sadt DECIMAL(15, 2) NULL,
Val_Tot DECIMAL(15, 2) NULL
);
GO

CREATE TABLE Internacao(
Id_Internacao INT PRIMARY KEY IDENTITY(1,1),
Id_Paciente INT NOT NULL,
CNES CHAR(7) NOT NULL,
Sequencia_Internacao INT NULL,
Data_Internacao DATE NULL,
Data_Saida DATE NULL,
Morte BIT NULL,
Indetificacao_internacao CHAR(6) NULL,
Especialidade_Leito CHAR(14) NULL,
Cobranca VARCHAR(100) NULL,
Gestao_De_Risco BIT NULL,
Procedimento_Solicitado INT NULL,
Diaria_Acompanhante INT NULL,
Ano_Internacao INT NULL,
Mes_Internacao CHAR(12) NULL
FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente) ON DELETE CASCADE,
FOREIGN KEY (CNES) REFERENCES Hospital(CNES) ON DELETE CASCADE
);

GO
CREATE TABLE Procedimento_Internacao(
Id_Procedimento_internacao INT PRIMARY KEY IDENTITY(1,1),
Id_Internacao INT NOT NULL,
Id_Procedimento_Medico INT NOT NULL,
Val_Sh_Fed DECIMAL(15, 2) NULL,
Val_Sp_Fed DECIMAL(15, 2) NULL,
Val_Sp_Ges DECIMAL(15, 2) NULL,
Val_Uci DECIMAL(15, 2) NULL,
Val_Sh_Ges DECIMAL(15, 2) NULL,
Procedimento_Realizado INT NULL
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao) ON DELETE CASCADE,
FOREIGN KEY (Id_Procedimento_Medico) REFERENCES Procedimento_Medico(Id_Procedimento_Medico) ON DELETE CASCADE
);
GO

--obs no modelo fisico tinha algumas fk que não existem 
CREATE TABLE Detalhe_Internacao(
Id_Detalhe_Internacao INT PRIMARY KEY IDENTITY(1,1),
Id_Internacao INT NOT NULL,
Tipo_Diag_Secun INT NULL,
Diag_Adicionais INT NULL,
Permanencia_Hospital INT NULL,
Cobranca VARCHAR(100) NULL,
Complexidade VARCHAR(50) NULL
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao) ON DELETE CASCADE
);
GO

CREATE TABLE UTI(
Id_UTI INT PRIMARY KEY IDENTITY(1,1),
Id_Internacao INT NOT NULL,
Tipo_UTI INT NULL,
Qtd_Internacoes_Uti_Mes INT NULL,
Qtd_Internacoes_Uti_Total INT NULL,
Qtd_Internacoes_Periodo INT NULL,
Qtd_Internacoes_Ate_Alta INT NULL,
Qtd_Internacoes_Ano INT NULL,
Total_Internacao INT NULL
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao) ON DELETE CASCADE
);
GO

CREATE TABLE Saude_Reprodutiva(
Id_Saude_Reprodutiva INT PRIMARY KEY IDENTITY(1,1),
Id_Internacao INT NOT NULL,
Exame_Vdrl BIT NULL,
Contraceptivo_1 VARCHAR(100) NULL,
Contraceptivo_2 VARCHAR(100) NULL,
Num_Filhos INT NULL
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao) ON DELETE CASCADE
);
GO


CREATE TABLE Condicoes_Saude(
Id_Condicoes_Saude INT PRIMARY KEY IDENTITY(1,1),
Id_Saude_Reprodutiva INT NOT NULL,
Exame_Vdrl BIT NULL,
Gestacao_Risco BIT NULL,
Infeccao_Hospitalar BIT NULL
FOREIGN KEY (Id_Saude_Reprodutiva) REFERENCES Saude_Reprodutiva (Id_Saude_Reprodutiva) ON DELETE CASCADE
);
GO

CREATE TABLE Financeiro(
Id_Financeiro INT PRIMARY KEY IDENTITY(1,1),
Id_Internacao INT NOT NULL,
Tipo_de_financiamento INT NULL,
Fonte_Financiamento INT NULL,
Total_Procedimento DECIMAL(15, 2) NULL,
Valor_Hospitalar DECIMAL(15,2) NULL,
Valor_Sadt DECIMAL(15, 2) NULL,
Valor_Profissional DECIMAL(15, 2) NULL,
Valor_Rn DECIMAL(15, 2) NULL,
Valor_Protese DECIMAL (15, 2) NULL,
Valor_Acompanhante DECIMAL(15, 2) NULL,
Valor_Sangue DECIMAL(15, 2) NULL,
Valor_Sadtsr DECIMAL(15, 2) NULL,
Valor_Analgesico_obstetra DECIMAL(15, 2) NULL,
Valor_Pediadra1 DECIMAL(15, 2) NULL,
Valor_UTI DECIMAL(15, 2) NULL,
Valor_Transplante DECIMAL(15, 2) NULL,
Numero_Procedimentos INT NULL
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao) ON DELETE CASCADE
);
GO

CREATE TABLE Gestor(
Id_Gestor INT PRIMARY KEY IDENTITY(1,1),
Id_Financeiro INT NOT NULL,
Tipo_Gestor INT NULL,
CPF_Gestor CHAR(14) NULL,
Data_Gestao DATE NULL,
Remessa_Arquivos VARCHAR(3) NULL
FOREIGN KEY (Id_Financeiro) REFERENCES Financeiro(Id_Financeiro) ON DELETE CASCADE
);
GO
