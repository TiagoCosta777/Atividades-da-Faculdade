USE SQL_EX;


-- 1. Listagem Simples: Selecione o nome do contato (C: ContactName) e o telefone (C: Phone) de todos os clientes (T: Customers) que moram em Londres.
SELECT ContactName, Phone
FROM Customers
where City = 'London'
;

-- 2. Ordenação: Mostre todos os produtos (T: Products) que estão com o estoque (C: UnitsInStock) zerado, ordenados pelo nome do produto em ordem alfabética (C: ProductName).
SELECT ProductID,
ProductName,
UnitsInStock
FROM Products
where UnitsInStock = 0
order by ProductName asc
;


-- 3. Filtro com Datas: Liste todos os pedidos (T: Orders) que foram feitos no mês de maio de 1997. Ordene os resultados pela data do pedido (C: OrderDate), do mais recente para o mais antigo.
SELECT *
FROM Orders
where OrderDate BETWEEN '1997-05-01' AND '1997-05-31'
Order by OrderDate DESC
;




-- 4. Uso do TOP: Identifique os 5 produtos mais caros da loja. A consulta deve retornar o nome do produto (C: ProductName) e o seu preço (C: UnitPrice).
SELECT TOP (5) ProductName,
UnitPrice
FROM Products
order by UnitPrice desc
;


-- 5. Múltiplos Critérios: Encontre todos os funcionários (T: Employees) que foram contratados (C: HireDate) antes do ano de 1993 e que moram nos EUA (C: Country = 'USA').
SELECT*
FROM Employees
WHERE HireDate < '1993' AND Country = 'USA'
;

--Parte 2: Agregação e Agrupamento (Aggregate Functions, GROUP BY, HAVING)
-- 6. Contagem Simples (COUNT): Quantos produtos ao todo são fornecidos pelo fornecedor (T: Supplier) de ID = 1?
SELECT COUNT(SupplierID) AS QTDE_PRODUTOS
FROM Products
WHERE SupplierID = 1
;


-- 7. Média de Preços (AVG): Qual é o preço médio de todos os produtos cadastrados na tabela T: Products? Dê um nome (alias) para a coluna de resultado como PrecoMedio.
	SELECT 
	AVG(UnitPrice) AS PrecoMedio
	FROM Products
	;

-- 8. Agrupamento (GROUP BY): Crie uma consulta que mostre a quantidade de clientes existentes em cada país (C: Country).
SELECT Country,
COUNT(CustomerID) AS QTDE
FROM Customers
GROUP BY Country
;

-- 9. Soma (SUM) com Agrupamento: Calcule o valor total de itens em estoque (C: UnitsInStock) para cada categoria de pro-- duto (C: CategoryID). A consulta deve mostrar o C: CategoryID e a soma total.
SELECT 
CategoryID,
SUM(UnitPrice)
FROM Products
GROUP BY CategoryID
;

-- 10. Filtro de Grupos (HAVING): Liste todos os países que possuem mais de 7 clientes. A consulta deve mostrar o país e a contagem de clientes.
SELECT Country,
COUNT(CustomerID) AS QUANTIDADE
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 7
;

-- 11. Consulta Complexa com Agregação: Mostre o C: ProductID e o valor total vendido (calculado como C: UnitPrice * C: Quantity) para cada produto na tabela T: Order Details. Liste apenas os produtos cujo valor total vendido ultrapasse $50.000 e ordene do maior para o menor valor.
SELECT ProductID,
SUM(UnitPrice*Quantity) AS VL_TOTAL
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(UnitPrice*Quantity) >= 50000
ORDER BY VL_TOTAL DESC
;


--Parte 3: Subconsultas e Cláusulas Adicionais
-- 12. Uso de DISTINCT: Crie uma consulta que retorne todas as cidades (C: City) únicas para as quais já foram enviados pedidos (T: Orders).
SELECT DISTINCT City
FROM Customers
WHERE CustomerID IN (SELECT 
CustomerID FROM Orders)
;

-- 13. Subconsulta com IN: Liste o nome de todos os produtos (T: Products) que são da categoria 'Beverages'. (Dica: primeiro, use uma subconsulta para encontrar o C: CategoryID de 'Beverages' na tabela T: Categories).
SELECT DISTINCT ProductName
FROM Products
WHERE CategoryID IN (SELECT 
CategoryID FROM Categories
WHERE CategoryName = 'Beverages')
;

-- 14. Subconsulta com Agregação: Mostre todos os produtos cujo preço unitário (C: UnitPrice) é maior que o preço médio de todos os produtos.
SELECT ProductName,
UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice)FROM Products)
;

--Parte 4: Manipulação de Dados (INSERT, UPDATE, DELETE)

-- 15. Inserção (INSERT): Insira uma nova transportadora (T: Shipper) na sua tabela T: Shippers_Copia. O nome da empresa (C: CompanyName) deve ser "Loggi" e o telefone (C: Phone) "(11) 99999-9999".

INSERT INTO Shippers_Copia (CompanyName, Phone)
VALUES ('Loggi', '(11) 88888-8888'); 

-- 16. Atualização (UPDATE): O telefone da "Loggi" mudou. Atualize o registro na tabela T: Shippers_Copia para o novo telefone "(11) 88888-8888".
UPDATE Shippers_Copia
SET Phone = '(11) 88888-8888'
WHERE CompanyName = 'Loggi'
;


-- 17. Exclusão (DELETE): Exclua a transportadora chamada "Speedy Express" da sua tabela T: Shippers_Copia.
--Parte 5: Criação e Alteração de Estruturas (DDL e Constraints)
DELETE FROM Shippers_Copia
WHERE CompanyName = 'Speedy Express'
;
-- 18. Criação de Tabela (CREATE TABLE): Crie uma nova tabela chamada T: Auditoria com as seguintes colunas: C: LogID, C: NomeTabela, C: DataModificacao.
CREATE TABLE Auditoria(
LogID INT,
NomeTabela VARCHAR(50),
DataModificacao DATE
);


-- 19. Adição de Constraints: Recrie a tabela T: Auditoria adicionando as restrições: PRIMARY KEY, NOT NULL e DEFAULT.
CREATE TABLE Auditoria(
LogID INT PRIMARY KEY,
NomeTabela VARCHAR(50) NOT NULL,
DataModificacao DATE NOT NULL DEFAULT GETDATE() 
);

-- 20. Alteração de Tabela (ALTER TABLE): Adicione uma nova coluna na tabela T: Auditoria chamada C: Usuario do tipo VARCHAR(50). Em seguida, remova esta mesma coluna da tabela.
ALTER TABLE Auditoria
ADD Usuario VARCHAR(50);

ALTER TABLE Auditoria
DROP COLUMN Usuario;