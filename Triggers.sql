-- =============================================
-- TRIGGERS - SISTEMA DE INFORMAÇÕES HOSPITALARES
-- =============================================

USE Sistema_Informações_Hospitalares;
GO

-- =============================================
-- 1. TRIGGER: Validar data de saída da internação
-- Ops! Paciente não pode sair antes de entrar no hospital
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_Data_Saida
ON Internacao
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE Data_Saida IS NOT NULL 
        AND Data_Saida < Data_Internacao
    )
    BEGIN
        RAISERROR('Opa! A data de saída não pode ser antes da data de internação. Verifique as datas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 2. TRIGGER: Calcular idade do paciente automaticamente
-- Atualiza a idade com base na data de nascimento
-- =============================================
CREATE OR ALTER TRIGGER trg_Calcular_Idade_Paciente
ON Paciente
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE p
    SET Idade = DATEDIFF(YEAR, i.Data_Nascimento, GETDATE()) -
                CASE 
                    WHEN MONTH(i.Data_Nascimento) > MONTH(GETDATE()) 
                         OR (MONTH(i.Data_Nascimento) = MONTH(GETDATE()) 
                             AND DAY(i.Data_Nascimento) > DAY(GETDATE()))
                    THEN 1
                    ELSE 0
                END
    FROM Paciente p
    INNER JOIN inserted i ON p.Id_Paciente = i.Id_Paciente
    WHERE i.Data_Nascimento IS NOT NULL;
END;
GO

-- =============================================
-- 3. TRIGGER: Calcular ano e mês de internação
-- Preenche automaticamente campos de controle temporal
-- =============================================
CREATE OR ALTER TRIGGER trg_Preencher_Periodo_Internacao
ON Internacao
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE i
    SET Ano_Internacao = YEAR(ins.Data_Internacao),
        Mes_Internacao = MONTH(ins.Data_Internacao)
    FROM Internacao i
    INNER JOIN inserted ins ON i.Id_Internacao = ins.Id_Internacao
    WHERE ins.Data_Internacao IS NOT NULL;
END;
GO

-- =============================================
-- 4. TRIGGER: Validar disponibilidade de leitos
-- Impede internações se não houver leitos disponíveis
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_Disponibilidade_Leitos
ON Internacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Id_Hospital INT;
    DECLARE @Total_Leitos INT;
    DECLARE @Internacoes_Ativas INT;
    
    SELECT @Id_Hospital = Id_Hospital FROM inserted;
    
    -- Total de leitos disponíveis
    SELECT @Total_Leitos = ISNULL(SUM(Leitos_Existentes), 0)
    FROM Leito
    WHERE Id_Hospital = @Id_Hospital;
    
    -- Internações ativas (sem data de saída)
    SELECT @Internacoes_Ativas = COUNT(*)
    FROM Internacao
    WHERE Id_Hospital = @Id_Hospital
    AND Data_Saida IS NULL;
    
    IF @Internacoes_Ativas > @Total_Leitos
    BEGIN
        RAISERROR('Não há leitos disponíveis neste hospital', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 5. TRIGGER: Atualizar total de usuários atendidos
-- Incrementa contador de atendimentos no hospital
-- =============================================
CREATE OR ALTER TRIGGER trg_Atualizar_Total_Atendimentos
ON Atendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Atualiza o registro que acabou de ser inserido
    UPDATE a
    SET Total_Usuarios_Atendidos = (
        SELECT COUNT(*) 
        FROM Atendimento 
        WHERE Id_Hospital = i.Id_Hospital
    )
    FROM Atendimento a
    JOIN inserted i ON a.Id_Atendimento = i.Id_Atendimento;
END;
GO 

-- =============================================
-- 6. TRIGGER: Validar CNES (formato)
-- Garante que CNES tenha exatamente 7 caracteres numéricos
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_CNES
ON Hospital
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE CNES IS NOT NULL 
        AND (LEN(CNES) != 7 OR CNES NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    )
    BEGIN
        RAISERROR('CNES deve conter exatamente 7 dígitos numéricos', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 7. TRIGGER: Calcular permanência hospitalar
-- Atualiza automaticamente dias de permanência
-- =============================================
CREATE OR ALTER TRIGGER trg_Calcular_Permanencia
ON Detalhe_Internacao
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE d
    SET Permanencia_Hospital = DATEDIFF(DAY, i.Data_Internacao, ISNULL(i.Data_Saida, GETDATE()))
    FROM Detalhe_Internacao d
    INNER JOIN inserted ins ON d.Id_Detalhe_Internacao = ins.Id_Detalhe_Internacao
    INNER JOIN Internacao i ON d.Id_Internacao = i.Id_Internacao
    WHERE i.Data_Internacao IS NOT NULL;
END;
GO

-- =============================================
-- 8. TRIGGER: Validar CPF do gestor
-- Verifica formato básico do CPF (11 dígitos)
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_CPF_Gestor
ON Gestor
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE CPF_Gestor IS NOT NULL 
        AND (
            LEN(REPLACE(REPLACE(REPLACE(CPF_Gestor, '.', ''), '-', ''), ' ', '')) != 11
            OR REPLACE(REPLACE(REPLACE(CPF_Gestor, '.', ''), '-', ''), ' ', '') NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        )
    )
    BEGIN
        RAISERROR('CPF deve conter 11 dígitos numéricos', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 9. TRIGGER: Validar CEP
-- Garante formato correto de CEP (8 dígitos)
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_CEP
ON Endereco_Hospital
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE Co_Cep IS NOT NULL 
        AND (LEN(Co_Cep) != 8 OR Co_Cep NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    )
    BEGIN
        RAISERROR('CEP deve conter exatamente 8 dígitos numéricos', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


CREATE OR ALTER TRIGGER trg_Validar_Profissional_Saude
ON Profissional_Saude
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE Nome IS NULL OR LTRIM(RTRIM(Nome)) = ''
    )
    BEGIN
        RAISERROR('O nome do profissional de saúde é obrigatório!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 11. TRIGGER: Registrar data/hora de atendimento automaticamente
-- Preenche timestamp quando não informado
-- =============================================
CREATE OR ALTER TRIGGER trg_Registrar_DataHora_Atendimento
ON Atendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE a
    SET Data_Hora = GETDATE()
    FROM Atendimento a
    INNER JOIN inserted i ON a.Id_Atendimento = i.Id_Atendimento
    WHERE i.Data_Hora IS NULL;
END;
GO

-- =============================================
-- 12. TRIGGER: Validar valores financeiros não negativos
-- Impede lançamento de valores negativos
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_Valores_Financeiros
ON Financeiro
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 FROM inserted 
        WHERE Total_Procedimento < 0 OR Valor_Hospitalar < 0 
           OR Valor_Sadt < 0 OR Valor_Profissional < 0
           OR Valor_Rn < 0 OR Valor_Protese < 0
           OR Valor_Acompanhante < 0 OR Valor_Sangue < 0
           OR Valor_Sadtsr < 0 OR Valor_Analgesico_obstetra < 0
           OR Valor_Pediatria1 < 0 OR Valor_UTI < 0
           OR Valor_Transplante < 0
    )
    BEGIN
        RAISERROR('Valores financeiros não podem ser negativos', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 13. TRIGGER: Atualizar sequência de internação
-- Numera internações do paciente sequencialmente
-- =============================================
CREATE OR ALTER TRIGGER trg_Atualizar_Sequencia_Internacao
ON Internacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE i
    SET Sequencia_Internacao = (
        SELECT COUNT(*) 
        FROM Internacao 
        WHERE Id_Paciente = ins.Id_Paciente 
        AND Id_Internacao <= ins.Id_Internacao
    )
    FROM Internacao i
    INNER JOIN inserted ins ON i.Id_Internacao = ins.Id_Internacao;
END;
GO

-- =============================================
-- 14. TRIGGER: Validar data de validade de recursos
-- Garante que data de validade seja futura
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_Data_Validade_Recurso
ON Recurso_Hospitalar
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE Data_Validade IS NOT NULL 
        AND Data_Validade < GETDATE()
    )
    BEGIN
        RAISERROR('Data de validade deve ser futura', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =============================================
-- 15. TRIGGER: Validar quantidade de recursos
-- Impede quantidades negativas ou zero
-- =============================================
CREATE OR ALTER TRIGGER trg_Validar_Quantidade_Recurso
ON Recurso_Hospitalar
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE Quantidade IS NOT NULL 
        AND Quantidade <= 0
    )
    BEGIN
        RAISERROR('Quantidade de recursos deve ser maior que zero', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

PRINT 'Todas as triggers foram criadas com sucesso!';
GO