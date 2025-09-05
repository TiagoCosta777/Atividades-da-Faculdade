USE SQL_EX;


-- 1. Listagem Simples: Selecione o nome do contato (C: ContactName) e o telefone (C: Phone) de todos os clientes (T: Customers) que moram em Londres.
SELECT ContactName, Phone
FROM Customers
where City = 'London'
;

-- 2. Ordena��o: Mostre todos os produtos (T: Products) que est�o com o estoque (C: UnitsInStock) zerado, ordenados pelo nome do produto em ordem alfab�tica (C: ProductName).
SELECT ProductID,
ProductName,
UnitsInStock
FROM Products
where UnitsInStock = 0
order by ProductName asc
;


-- 3. Filtro com Datas: Liste todos os pedidos (T: Orders) que foram feitos no m�s de maio de 1997. Ordene os resultados pela data do pedido (C: OrderDate), do mais recente para o mais antigo.
SELECT *
FROM Orders
where OrderDate BETWEEN '1997-05-01' AND '1997-05-31'
Order by OrderDate DESC
;




-- 4. Uso do TOP: Identifique os 5 produtos mais caros da loja. A consulta deve retornar o nome do produto (C: ProductName) e o seu pre�o (C: UnitPrice).
SELECT TOP (5) ProductName,
UnitPrice
FROM Products
order by UnitPrice desc
;


-- 5. M�ltiplos Crit�rios: Encontre todos os funcion�rios (T: Employees) que foram contratados (C: HireDate) antes do ano de 1993 e que moram nos EUA (C: Country = 'USA').
SELECT*
FROM Employees
WHERE HireDate < '1993' AND Country = 'USA'
;

--Parte 2: Agrega��o e Agrupamento (Aggregate Functions, GROUP BY, HAVING)
-- 6. Contagem Simples (COUNT): Quantos produtos ao todo s�o fornecidos pelo fornecedor (T: Supplier) de ID = 1?
SELECT COUNT(SupplierID) AS QTDE_PRODUTOS
FROM Products
WHERE SupplierID = 1
;


-- 7. M�dia de Pre�os (AVG): Qual � o pre�o m�dio de todos os produtos cadastrados na tabela T: Products? D� um nome (alias) para a coluna de resultado como PrecoMedio.
	SELECT 
	AVG(UnitPrice) AS PrecoMedio
	FROM Products
	;

-- 8. Agrupamento (GROUP BY): Crie uma consulta que mostre a quantidade de clientes existentes em cada pa�s (C: Country).
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

-- 10. Filtro de Grupos (HAVING): Liste todos os pa�ses que possuem mais de 7 clientes. A consulta deve mostrar o pa�s e a contagem de clientes.
SELECT Country,
COUNT(CustomerID) AS QUANTIDADE
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 7
;

-- 11. Consulta Complexa com Agrega��o: Mostre o C: ProductID e o valor total vendido (calculado como C: UnitPrice * C: Quantity) para cada produto na tabela T: Order Details. Liste apenas os produtos cujo valor total vendido ultrapasse $50.000 e ordene do maior para o menor valor.
SELECT ProductID,
SUM(UnitPrice*Quantity) AS VL_TOTAL
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(UnitPrice*Quantity) >= 50000
ORDER BY VL_TOTAL DESC
;


--Parte 3: Subconsultas e Cl�usulas Adicionais
-- 12. Uso de DISTINCT: Crie uma consulta que retorne todas as cidades (C: City) �nicas para as quais j� foram enviados pedidos (T: Orders).
SELECT DISTINCT City
FROM Customers
WHERE CustomerID IN (SELECT 
CustomerID FROM Orders)
;

-- 13. Subconsulta com IN: Liste o nome de todos os produtos (T: Products) que s�o da categoria 'Beverages'. (Dica: primeiro, use uma subconsulta para encontrar o C: CategoryID de 'Beverages' na tabela T: Categories).
SELECT DISTINCT ProductName
FROM Products
WHERE CategoryID IN (SELECT 
CategoryID FROM Categories
WHERE CategoryName = 'Beverages')
;

-- 14. Subconsulta com Agrega��o: Mostre todos os produtos cujo pre�o unit�rio (C: UnitPrice) � maior que o pre�o m�dio de todos os produtos.
SELECT ProductName,
UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice)FROM Products)
;

--Parte 4: Manipula��o de Dados (INSERT, UPDATE, DELETE)

-- 15. Inser��o (INSERT): Insira uma nova transportadora (T: Shipper) na sua tabela T: Shippers_Copia. O nome da empresa (C: CompanyName) deve ser "Loggi" e o telefone (C: Phone) "(11) 99999-9999".

INSERT INTO Shippers_Copia (CompanyName, Phone)
VALUES ('Loggi', '(11) 88888-8888'); 

-- 16. Atualiza��o (UPDATE): O telefone da "Loggi" mudou. Atualize o registro na tabela T: Shippers_Copia para o novo telefone "(11) 88888-8888".
UPDATE Shippers_Copia
SET Phone = '(11) 88888-8888'
WHERE CompanyName = 'Loggi'
;


-- 17. Exclus�o (DELETE): Exclua a transportadora chamada "Speedy Express" da sua tabela T: Shippers_Copia.
--Parte 5: Cria��o e Altera��o de Estruturas (DDL e Constraints)
DELETE FROM Shippers_Copia
WHERE CompanyName = 'Speedy Express'
;
-- 18. Cria��o de Tabela (CREATE TABLE): Crie uma nova tabela chamada T: Auditoria com as seguintes colunas: C: LogID, C: NomeTabela, C: DataModificacao.
CREATE TABLE Auditoria(
LogID INT,
NomeTabela VARCHAR(50),
DataModificacao DATE
);


-- 19. Adi��o de Constraints: Recrie a tabela T: Auditoria adicionando as restri��es: PRIMARY KEY, NOT NULL e DEFAULT.
CREATE TABLE Auditoria(
LogID INT PRIMARY KEY,
NomeTabela VARCHAR(50) NOT NULL,
DataModificacao DATE NOT NULL DEFAULT GETDATE() 
);

-- 20. Altera��o de Tabela (ALTER TABLE): Adicione uma nova coluna na tabela T: Auditoria chamada C: Usuario do tipo VARCHAR(50). Em seguida, remova esta mesma coluna da tabela.
ALTER TABLE Auditoria
ADD Usuario VARCHAR(50);

ALTER TABLE Auditoria
DROP COLUMN Usuario;