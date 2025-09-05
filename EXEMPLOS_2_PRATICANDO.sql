USE SQL_EX;

-- Parte 1: Sele��es B�sicas
-- 1. Sele��o com Filtro Simples
--Liste o nome da empresa (CompanyName) e a cidade (City) de todos os clientes do M�xico.
SELECT
CompanyName,
City
FROM Customers;


--2. Ordena��o
--Mostre todos os funcion�rios (FirstName, LastName) ordenados por data de contrata��o (HireDate), do mais antigo para o mais novo.
SELECT 
FirstName,
LastName,
HireDate
FROM Employees
ORDER BY HireDate ASC
;

--3. Filtro com Intervalo de Datas
--Liste os pedidos (OrderID, OrderDate, CustomerID) feitos entre 1� de julho de 1996 e 30 de setembro de 1996.
SELECT 
OrderID,
OrderDate,
CustomerID
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-09-30'
;




-- 4. TOP com Ordena��o
-- Mostre os 10 clientes que possuem o maior n�mero de pedidos (Orders). Exiba CustomerID e a contagem de pedidos.
SELECT TOP(10) 
CustomerID,
COUNT(OrderID) AS Total
FROM Orders
GROUP BY CustomerID
ORDER BY COUNT(OrderID) DESC
;

--5. M�ltiplos Crit�rios
--Liste todos os produtos (ProductName, UnitPrice, UnitsInStock) que custam mais de 50 e t�m estoque maior que 20 unidades.
SELECT 
ProductName,
UnitPrice,
UnitsInStock
FROM Products
WHERE UnitPrice > '50' AND UnitsInStock > '20'
;

--Parte 2: Agrega��o e Agrupamento
--6. COUNT com Condi��o
--Quantos pedidos foram feitos pelo cliente ALFKI?

SELECT CustomerID,
COUNT(OrderID) AS TOTAL
FROM Orders
GROUP BY CustomerID
HAVING CustomerID = 'ALFKI'
;


--7. AVG com Filtro
--Qual o pre�o m�dio dos produtos fornecidos pelo SupplierID = 2?
SELECT AVG(UnitPrice) AS PRECO_MEDIO
FROM Products
WHERE SupplierID = 2
;

--8. GROUP BY
--Liste o n�mero de funcion�rios que trabalham em cada cidade (City) da tabela Employees.
SELECT 
City,
COUNT(EmployeeID) AS TOTAL
FROM Employees
GROUP BY City
;

--9. SUM com GROUP BY
--Mostre a soma total de Freight (frete) agrupada por cada cliente (CustomerID).
SELECT CustomerID,
SUM(Freight) AS TOTAL
FROM Orders
GROUP BY CustomerID
;

--10. HAVING
--Liste os fornecedores (SupplierID) que fornecem mais de 5 produtos diferentes.
SELECT SupplierID,
COUNT(DISTINCT ProductID) AS TOTAL
FROM Products
GROUP BY SupplierID
HAVING COUNT(DISTINCT ProductID) > 5
;




--11. Consulta Complexa
--Mostre o valor total vendido (UnitPrice * Quantity * (1 - Discount)) por cada pedido (OrderID) e exiba apenas os pedidos cujo valor total ultrapasse 10.000.





--Parte 3: Subconsultas e Cl�usulas Extras
--12. DISTINCT
--Liste todos os cargos (Title) �nicos da tabela Employees.

--13. Subconsulta com IN
--Liste o nome de todos os produtos (ProductName) que s�o fornecidos por fornecedores localizados na Alemanha.

--14. Subconsulta com Agrega��o
--Liste os pedidos (OrderID, OrderDate) cujo valor do frete (Freight) seja maior que a m�dia de todos os fretes.

--Parte 4: Manipula��o de Dados

--15. INSERT
--Insira um novo cliente (Customers) com os seguintes dados:

--CustomerID = 'TIAG0'

--CompanyName = 'Tech Solutions'

--ContactName = 'Tiago Costa'

--City = 'S�o Paulo'

--Country = 'Brazil'

--16. UPDATE
--Atualize o ContactTitle do cliente TIAG0 para 'Data Analyst'.

--17. DELETE
--Exclua o cliente TIAG0 da tabela Customers.

--Parte 5: Cria��o e Altera��o de Estruturas

--18. CREATE TABLE
--Crie uma tabela chamada LogsPedidos com as colunas:

--LogID (INT, chave prim�ria)

--OrderID (INT, NOT NULL)

--DataLog (DATE, default = GETDATE())

--19. Constraints
--Recrie a tabela LogsPedidos adicionando a constraint de foreign key ligando OrderID a Orders(OrderID).

--20. ALTER TABLE
--Na tabela LogsPedidos, adicione uma coluna chamada Usuario (VARCHAR(50)). Em seguida, remova essa mesma coluna.