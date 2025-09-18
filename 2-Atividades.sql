USE SQL_EX;
GO

--Parte 1: Fun��es de Texto e Operador LIKE

--1. Formata��o de Nomes: Selecione o nome e sobrenome dos funcion�rios e exiba-os em uma �nica coluna chamada NomeCompleto, em mai�sculas, no formato "SOBRENOME, NOME".
SELECT UPPER(CONCAT(FirstName, LastName)) as NomeCompleto
FROM Employees
;
GO

--2. Extra��o de Iniciais: Crie uma consulta que mostre os tr�s primeiros caracteres do nome de cada produto.
SELECT SUBSTRING(ProductName, 1, 3)
FROM Products
;
GO


--3. Busca por Padr�o: Liste todos os clientes cujo nome do contato come�a com a letra 'A' e termina com a letra 'o'.
SELECT ContactName
FROM Customers
WHERE ContactName LIKE 'a%o' 
;
GO

--4. Comprimento do Nome: Encontre todos os produtos cujos nomes t�m mais de 20 caracteres. Ordene pelo nome do produto.
SELECT ProductName
FROM Products
WHERE LEN(ProductName) >= 20
;
GO

--5. Substitui��o de Texto: Para todos os produtos da categoria 1, mostre o nome do produto substituindo a palavra "Lager" por "Cerveja".
SELECT REPLACE(ProductName, 'Lager', 'Cerveja') AS ProductName
FROM Products
WHERE CategoryID = 1
 ;
GO
--6. Concatena��o com Convers�o: Exiba o ID e o nome do produto em uma �nica coluna formatada como "ID: [ProductID] - Nome: [ProductName]".
SELECT CONCAT('ID: ', ProductID, ' - Nome: ', ProductName) AS ID_AND_NAME
FROM Products
;
GO

--7. Busca por M�ltiplos Padr�es: Liste os clientes cujo nome do pa�s comece com 'U' mas n�o seja 'USA'.
SELECT 
ContactName,
CustomerID
FROM Customers
WHERE Country LIKE 'U%' AND Country <> 'USA'
;
GO



--8. Verifica��o de Nulos com Texto: Selecione todos os clientes e mostre o nome da empresa. Se a regi�o for nula, exiba o texto 'N/A' no lugar do nulo.
SELECT 
CompanyName,
ISNULL(Region, 'N/A') AS REGIAO
FROM Customers
;
GO

--9. Remo��o de Espa�os: Supondo que a coluna de telefone dos clientes pudesse ter espa�os extras, escreva uma consulta que remova espa�os � esquerda e � direita de todos os n�meros de telefone.
SELECT TRIM(Phone)
FROM Customers
;
GO

--10. Busca por Caractere Espec�fico: Encontre todos os produtos cujo nome contenha um ap�strofo (').
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%''%'
;
GO

-- Parte 2: Fun��es de Data e Hora

--11. Idade dos Funcion�rios: Calcule e mostre a idade atual de cada funcion�rio com base na sua data de nascimento.
SELECT DATEDIFF(YEAR, BirthDate, GETDATE()) -
CASE 
WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate , GETDATE()), BirthDate) > GETDATE()
THEN 1
ELSE 0
END AS IDADE
FROM Employees
;
GO

--12. Tempo de Servi�o: Liste todos os funcion�rios e h� quantos anos eles trabalham na empresa, com base na data de contrata��o.
SELECT DATEDIFF(YEAR, HireDate, GETDATE()) -
CASE
	WHEN DATEADD(YEAR, DATEDIFF(YEAR, HireDate, GETDATE()), HireDate) > GETDATE()
	THEN 1
	ELSE 0
	END AS ANOS_EMPRESA
FROM Employees
;
GO

--13. Pedidos por Trimestre: Agrupe os pedidos e conte quantos foram feitos em cada trimestre do ano.
SELECT YEAR(OrderDate) AS ANO,
DATEPART(QUARTER, OrderDate) AS TRIMESTRE
FROM Orders
GROUP BY YEAR(OrderDate), DATEPART(QUARTER, OrderDate)
ORDER BY ANO, TRIMESTRE
;
GO
--14. Formata��o de Data: Exiba a data do pedido dos 10 primeiros pedidos no formato dd/MM/yyyy.
SELECT TOP(10) FORMAT(OrderDate,  'dd/MM/yyyy') AS DATA_ATUALIZADA
FROM Orders
ORDER BY OrderDate ASC
;
GO

--15. Pedidos da �ltima Semana: Selecione todos os pedidos que foram feitos nos �ltimos 7 dias a partir da data do pedido mais recente na tabela.
SELECT 
CustomerID,
OrderID
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -7, (SELECT MAX(OrderDate) FROM Orders))
;
GO

--16. Dia da Semana: Mostre o ID do pedido e o nome do dia da semana em que cada pedido foi realizado.
SET LANGUAGE 'BRAZILIAN';
GO
SELECT OrderId,
DATENAME(WEEKDAY, OrderDate) AS DIA_DA_SEMAMA
FROM Orders
;
GO

SET LANGUAGE 'US_ENGLISH';
GO

--17. Adicionando Tempo: Para cada pedido, calcule uma data de "primeiro acompanhamento", que � 30 dias ap�s a data do pedido.
SELECT 
OrderID,
CustomerID,
DATEADD(DAY, 30, OrderDate) AS DATA_ACOMPANHAMENTO
FROM Orders
ORDER BY OrderDate ASC
;
GO
--18. Pedidos de Anivers�rio: Encontre todos os pedidos que foram feitos no mesmo m�s do anivers�rio do funcion�rio que os registrou.
SELECT
Em.FirstName,
Od.OrderID
FROM Orders Od
JOIN Employees Em ON Od.EmployeeID = Em.EmployeeID
WHERE MONTH(Od.OrderDate) = MONTH(Em.BirthDate) 
;
GO


--19. Filtro por Ano e M�s: Liste todos os produtos que foram pedidos em julho de 1996.
SELECT
O.OrderID,
PR.ProductID,
O.OrderDate
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products PR ON OD.ProductID = PR.ProductID
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 7
;
GO


--20. Hora do Pedido: Se a coluna de data do pedido tivesse hora, como voc� selecionaria apenas os pedidos feitos antes do meio-dia? (Este � um exerc�cio te�rico, demonstre a consulta).
SELECT
OrderID,
OrderDate
FROM Orders
WHERE CAST(OrderDate AS TIME) < '12:00:00'
;
GO

-- Parte 3: Fun��es Matem�ticas e de Convers�o

--21. Arredondamento de Pre�os: Mostre o pre�o unit�rio de todos os produtos, arredondado para o n�mero inteiro mais pr�ximo.

SELECT CAST(ROUND(UnitPrice, 0)AS INT) AS ARREDONDADO
FROM Products
;
GO

--22. Valor Absoluto: Calcule a diferen�a absoluta entre o pre�o unit�rio e o n�vel de reabastecimento para cada produto.
SELECT 
UnitsInStock,
ReorderLevel,
ABS(UnitsInStock - ReorderLevel) AS Reabastecimento
FROM Products
;
GO


--23. Potencia��o: Para cada item detalhado do pedido, calcule o pre�o unit�rio elevado � quantidade (este � um c�lculo hipot�tico para praticar a fun��o).





--24. Raiz Quadrada: Exiba a raiz quadrada do ID dos primeiros 10 produtos.

--25. Valor M�ximo entre Colunas: Para cada produto, mostre o maior valor entre as unidades em estoque e as unidades em pedido.

--26. Convers�o de Tipos: Some o ID do produto com o ID da sua categoria. Em seguida, tente concatenar o ID do produto com o seu nome sem fazer uma convers�o expl�cita e observe o erro. Corrija a consulta para que funcione.

--27. Piso e Teto: Para os 10 produtos mais caros, mostre o pre�o unit�rio, seu valor "piso" (menor inteiro) e seu valor "teto" (maior inteiro).

--28. Sinal do Estoque: Use uma fun��o para mostrar se o estoque de cada produto � positivo (1), zero (0) ou negativo (-1).

