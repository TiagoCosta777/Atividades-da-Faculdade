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

 CREATE TABLE Endereco_Hospital(
 Id_Endereco INT PRIMARY KEY NOT NULL,
 No_Logadouro VARCHAR(250),
 Nu_Endereco VARCHAR(20),
 No_Complemento VARCHAR(100),
 No_Bairro VARCHAR(100),
 Co_Cep CHAR(8),
 Nu_Telefone VARCHAR(20),
 No_Email VARCHAR(255)
 )

 CREATE TABLE Hospital(
CNES CHAR(7) PRIMARY KEY NOT NULL,
Id_Municipio INT NOT NULL,
Id_Natureza_Juridica INT NOT NULL,
Id_Uf INT NOT NULL,
Id_Endereco INT NOT NULL,
Nome_Hospital VARCHAR(200) NOT NULL,
Tipo_Gestao VARCHAR(100) NOT NULL,
Razao_Social VARCHAR(200) NOT NULL,
CNPJ CHAR(14) NOT NULL,
Complexidade_Hospitalar INT NOT NULL,
Contato VARCHAR(200) NOT NULL,
CNAER INT NOT NULL,
CBOR INT NOT NULL,
Qt_Diaria_Acomp INT 
FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio),
FOREIGN KEY (Id_Natureza_Juridica) REFERENCES Natureza_Juridica(Id_Natureza_Juridica),
FOREIGN KEY (Id_Uf) REFERENCES UF(Id_Uf),
FOREIGN KEY (Id_Endereco) REFERENCES Endereco_Hospital(Id_Endereco)
)

CREATE TABLE Leito(
Id_Leito INT PRIMARY KEY NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Tipo_Leito INT NOT NULL,
Quantidade_Existentes INT, 
Quantidade_Sus INT,
Leitos_SUS NUMERIC(6, 0),
Leitos_Existentes NUMERIC(6, 0)
FOREIGN KEY(CNES) REFERENCES Hospital(CNES),
FOREIGN KEY(Id_Tipo_Leito) REFERENCES Tipo_Leito(Id_Tipo_Leito)
)


CREATE TABLE Profissional_Saude(
Id_Profissional_Saude INT PRIMARY KEY NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Especialidade INT NOT NULL,
Nome VARCHAR(100),
Cargo_Funcao VARCHAR(100)
FOREIGN KEY(CNES) REFERENCES Hospital(CNES),
FOREIGN KEY(Id_Especialidade) REFERENCES Especialidade_Medica(Id_Especialidade)
)

CREATE TABLE Recurso_Hospitalar(
Id_Recurso_Hospitalar INT PRIMARY KEY NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Tipo_Recurso INT NOT NULL,
Nome VARCHAR(100),
Descricao VARCHAR(250),
Quantidade INT,
Valor_Alocado DECIMAL(10, 2),
Data_Validade DATE,
Orgao_Responsavel CHAR(2),
Versao INT,
Periodo_Vigencia DATE,
Estado_Conservacao VARCHAR(100),
Fornecedor VARCHAR(100)
FOREIGN KEY(CNES) REFERENCES Hospital(CNES),
FOREIGN KEY(Id_Tipo_Recurso) REFERENCES Tipo_Recurso(Id_Tipo_Recurso)
)

CREATE TABLE Demanda_Hospitalar(
Id_Demanda INT PRIMARY KEY NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Tipo_Demanda INT,
Data DATE,
Qt_Solicitacao INT,
Tempo_Medio_Espera TIME
FOREIGN KEY(CNES) REFERENCES Hospital(CNES),
FOREIGN KEY(Id_Tipo_Demanda) REFERENCES Tipo_Demanda(Id_Tipo_Demanda)
)

CREATE TABLE Indicador_Qualidade(
Id_Indicador_Qualidade INT NOT NULL,
CNES CHAR(7) NOT NULL,
Metodo_Calculo VARCHAR(250),
Meta DECIMAL(10, 2),
Descricao VARCHAR(250)
FOREIGN KEY (CNES) REFERENCES Hospital(CNES)
)

CREATE TABLE Servico_Saude(
Id_Servico_Saude INT NOT NULL,
CNES CHAR(7) NOT NULL, 
Nome VARCHAR(100),
Descricao VARCHAR(250)
FOREIGN KEY (CNES) REFERENCES Hospital(CNES)
)

CREATE TABLE Paciente(
Id_Paciente INT PRIMARY KEY NOT NULL,
Id_Municipio INT NOT NULL,
Id_Raca INT NOT NULL,
Id_Escolaridade INT NOT NULL,
Nomes_Semelhantes BIT,
Idade INT,
Etnia VARCHAR(100),
Nacionalidade VARCHAR(50),
Data_Nascimento DATE,
Sexo CHAR(1),
Num_Filhos INT
FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio),
FOREIGN KEY (Id_Raca) REFERENCES Raca_Cor(Id_Raca),
FOREIGN KEY (Id_Escolaridade) REFERENCES Nivel_De_Escolaridade(Id_Escolaridade)
)

CREATE TABLE Atendimento(
Id_Atendimento INT PRIMARY KEY NOT NULL,
Id_Paciente INT NOT NULL,
CNES CHAR(7) NOT NULL,
Id_Class_Risco INT NOT NULL,
Id_Tipo_Atendimento INT NOT NULL,
Data_Hora DATE,
Inscricao_Paciente VARCHAR(250),
Total_Usuarios_Atendidos INT
FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente),
FOREIGN KEY (CNES) REFERENCES Hospital(CNES),
FOREIGN KEY (Id_Class_Risco) REFERENCES Classificacao_Risco(Id_Class_Risco),
FOREIGN KEY (Id_Tipo_Atendimento) REFERENCES Tipo_Atendimento(Id_Tipo_Atendimento)
)
CREATE TABLE Procedimento_Medico(
Id_Procedimento_Medico INT PRIMARY KEY NOT NULL,
Descricao VARCHAR(250),
Val_Sh DECIMAL(15, 2),
Val_Sp DECIMAL(15, 2),
Val_Sadt DECIMAL(15, 2),
Val_Tot DECIMAL(15, 2)
)

CREATE TABLE Internacao(
Id_Internacao INT PRIMARY KEY NOT NULL,
Id_Paciente INT NOT NULL,
CNES CHAR(7) NOT NULL,
Sequencia_Internacao INT,
Data_Internacao DATE,
Data_Saida DATE,
Morte BIT,
Indetificacao_internacao CHAR(6),
Especialidade_Leito CHAR(14),
Cobranca VARCHAR(100),
Gestao_De_Risco BIT,
Procedimento_Solicitado INT,
Diaria_Acompanhante INT,
Ano_Internacao INT,
Mes_Internacao CHAR(12)
FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente),
FOREIGN KEY (CNES) REFERENCES Hospital(CNES)
)

CREATE TABLE Procedimento_Internacao(
Id_Procedimento_internacao INT PRIMARY KEY NOT NULL,
Id_Internacao INT NOT NULL,
Id_Procedimento_Medico INT NOT NULL,
Val_Sh_Fed DECIMAL(15, 2),
Val_Sp_Fed DECIMAL(15, 2),
Val_Sp_Ges DECIMAL(15, 2),
Val_Uci DECIMAL(15, 2),
Val_Sh_Ges DECIMAL(15, 2),
Procedimento_Realizado INT
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao),
FOREIGN KEY (Id_Procedimento_Medico) REFERENCES Procedimento_Medico(Id_Procedimento_Medico)
)

CREATE TABLE Detalhe_Internacao(
Id_Detalhe_Internacao INT PRIMARY KEY NOT NULL,
Id_Internacao INT NOT NULL,
Tipo_Diag_Secun INT,
Diag_Adicionais INT,
Permanencia_Hospital INT,
Cobranca VARCHAR(100),
Complexidade VARCHAR(50)
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao)
)

CREATE TABLE UTI(
Id_UTI INT PRIMARY KEY NOT NULL,
Id_Internacao INT NOT NULL,
Tipo_UTI INT,
Qtd_Internacoes_Uti_Mes INT,
Qtd_Internacoes_Uti_Total INT,
Qtd_Internacoes_Periodo INT,
Qtd_Internacoes_Ate_Alta INT,
Qtd_Internacoes_Ano INT,
Total_Internacao INT
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao)
)

CREATE TABLE Saude_Reprodutiva(
Id_Saude_Reprodutiva INT PRIMARY KEY NOT NULL,
Id_Internacao INT,
Exame_Vdrl BIT,
Contraceptivo_1 VARCHAR(100),
Contraceptivo_2 VARCHAR(100),
Num_Filhos INT
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao)
)

CREATE TABLE Condicoes_Saude(
Id_Condicoes_Saude INT PRIMARY KEY NOT NULL,
Id_Saude_Reprodutiva INT NOT NULL,
Exame_Vdrl BIT,
Gestacao_Risco BIT,
Infeccao_Hospitalar BIT
FOREIGN KEY (Id_Saude_Reprodutiva) REFERENCES Saude_Reprodutiva (Id_Saude_Reprodutiva)
)

CREATE TABLE Financeiro(
Id_Financeiro INT PRIMARY KEY NOT NULL,
Id_Internacao INT NOT NULL,
Tipo_de_financiamento INT,
Fonte_Financiamento INT,
Total_Procedimento DECIMAL(15, 2),
Valor_Hospitalar DECIMAL(15,2),
Valor_Sadt DECIMAL(15, 2),
Valor_Profissional DECIMAL(15, 2),
Valor_Rn DECIMAL(15, 2),
Valor_Protese DECIMAL (15, 2),
Valor_Acompanhante DECIMAL(15, 2),
Valor_Sangue DECIMAL(15, 2),
Valor_Sadtsr DECIMAL(15, 2),
Valor_Analgesico_obstetra DECIMAL(15, 2),
Valor_Pediadra1 DECIMAL(15, 2),
Valor_UTI DECIMAL(15, 2),
Valor_Transplante DECIMAL(15, 2),
Numero_Procedimentos INT
FOREIGN KEY (Id_Internacao) REFERENCES Internacao(Id_Internacao)
)

CREATE TABLE Gestor(
Id_Gestor INT PRIMARY KEY NOT NULL,
Id_Financeiro INT NOT NULL,
Tipo_Gestor INT,
CPF_Gestor CHAR(14),
Data_Gestao DATE,
Remessa_Arquivos VARCHAR(3)
FOREIGN KEY (Id_Financeiro) REFERENCES Financeiro(Id_Financeiro)
)