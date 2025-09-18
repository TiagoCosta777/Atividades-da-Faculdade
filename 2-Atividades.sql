USE SQL_EX;
GO

--Parte 1: Funções de Texto e Operador LIKE

--1. Formatação de Nomes: Selecione o nome e sobrenome dos funcionários e exiba-os em uma única coluna chamada NomeCompleto, em maiúsculas, no formato "SOBRENOME, NOME".
SELECT UPPER(CONCAT(FirstName, LastName)) as NomeCompleto
FROM Employees
;
GO

--2. Extração de Iniciais: Crie uma consulta que mostre os três primeiros caracteres do nome de cada produto.
SELECT SUBSTRING(ProductName, 1, 3)
FROM Products
;
GO


--3. Busca por Padrão: Liste todos os clientes cujo nome do contato começa com a letra 'A' e termina com a letra 'o'.
SELECT ContactName
FROM Customers
WHERE ContactName LIKE 'a%o' 
;
GO

--4. Comprimento do Nome: Encontre todos os produtos cujos nomes têm mais de 20 caracteres. Ordene pelo nome do produto.
SELECT ProductName
FROM Products
WHERE LEN(ProductName) >= 20
;
GO

--5. Substituição de Texto: Para todos os produtos da categoria 1, mostre o nome do produto substituindo a palavra "Lager" por "Cerveja".
SELECT REPLACE(ProductName, 'Lager', 'Cerveja') AS ProductName
FROM Products
WHERE CategoryID = 1
 ;
GO
--6. Concatenação com Conversão: Exiba o ID e o nome do produto em uma única coluna formatada como "ID: [ProductID] - Nome: [ProductName]".
SELECT CONCAT('ID: ', ProductID, ' - Nome: ', ProductName) AS ID_AND_NAME
FROM Products
;
GO

--7. Busca por Múltiplos Padrões: Liste os clientes cujo nome do país comece com 'U' mas não seja 'USA'.
SELECT 
ContactName,
CustomerID
FROM Customers
WHERE Country LIKE 'U%' AND Country <> 'USA'
;
GO



--8. Verificação de Nulos com Texto: Selecione todos os clientes e mostre o nome da empresa. Se a região for nula, exiba o texto 'N/A' no lugar do nulo.
SELECT 
CompanyName,
ISNULL(Region, 'N/A') AS REGIAO
FROM Customers
;
GO

--9. Remoção de Espaços: Supondo que a coluna de telefone dos clientes pudesse ter espaços extras, escreva uma consulta que remova espaços à esquerda e à direita de todos os números de telefone.
SELECT TRIM(Phone)
FROM Customers
;
GO

--10. Busca por Caractere Específico: Encontre todos os produtos cujo nome contenha um apóstrofo (').
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%''%'
;
GO

-- Parte 2: Funções de Data e Hora

--11. Idade dos Funcionários: Calcule e mostre a idade atual de cada funcionário com base na sua data de nascimento.
SELECT DATEDIFF(YEAR, BirthDate, GETDATE()) -
CASE 
WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate , GETDATE()), BirthDate) > GETDATE()
THEN 1
ELSE 0
END AS IDADE
FROM Employees
;
GO

--12. Tempo de Serviço: Liste todos os funcionários e há quantos anos eles trabalham na empresa, com base na data de contratação.
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
--14. Formatação de Data: Exiba a data do pedido dos 10 primeiros pedidos no formato dd/MM/yyyy.
SELECT TOP(10) FORMAT(OrderDate,  'dd/MM/yyyy') AS DATA_ATUALIZADA
FROM Orders
ORDER BY OrderDate ASC
;
GO

--15. Pedidos da Última Semana: Selecione todos os pedidos que foram feitos nos últimos 7 dias a partir da data do pedido mais recente na tabela.
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

--17. Adicionando Tempo: Para cada pedido, calcule uma data de "primeiro acompanhamento", que é 30 dias após a data do pedido.
SELECT 
OrderID,
CustomerID,
DATEADD(DAY, 30, OrderDate) AS DATA_ACOMPANHAMENTO
FROM Orders
ORDER BY OrderDate ASC
;
GO
--18. Pedidos de Aniversário: Encontre todos os pedidos que foram feitos no mesmo mês do aniversário do funcionário que os registrou.
SELECT
Em.FirstName,
Od.OrderID
FROM Orders Od
JOIN Employees Em ON Od.EmployeeID = Em.EmployeeID
WHERE MONTH(Od.OrderDate) = MONTH(Em.BirthDate) 
;
GO


--19. Filtro por Ano e Mês: Liste todos os produtos que foram pedidos em julho de 1996.
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


--20. Hora do Pedido: Se a coluna de data do pedido tivesse hora, como você selecionaria apenas os pedidos feitos antes do meio-dia? (Este é um exercício teórico, demonstre a consulta).
SELECT
OrderID,
OrderDate
FROM Orders
WHERE CAST(OrderDate AS TIME) < '12:00:00'
;
GO

-- Parte 3: Funções Matemáticas e de Conversão

--21. Arredondamento de Preços: Mostre o preço unitário de todos os produtos, arredondado para o número inteiro mais próximo.

SELECT CAST(ROUND(UnitPrice, 0)AS INT) AS ARREDONDADO
FROM Products
;
GO

--22. Valor Absoluto: Calcule a diferença absoluta entre o preço unitário e o nível de reabastecimento para cada produto.
SELECT 
UnitsInStock,
ReorderLevel,
ABS(UnitsInStock - ReorderLevel) AS Reabastecimento
FROM Products
;
GO


--23. Potenciação: Para cada item detalhado do pedido, calcule o preço unitário elevado à quantidade (este é um cálculo hipotético para praticar a função).





--24. Raiz Quadrada: Exiba a raiz quadrada do ID dos primeiros 10 produtos.

--25. Valor Máximo entre Colunas: Para cada produto, mostre o maior valor entre as unidades em estoque e as unidades em pedido.

--26. Conversão de Tipos: Some o ID do produto com o ID da sua categoria. Em seguida, tente concatenar o ID do produto com o seu nome sem fazer uma conversão explícita e observe o erro. Corrija a consulta para que funcione.

--27. Piso e Teto: Para os 10 produtos mais caros, mostre o preço unitário, seu valor "piso" (menor inteiro) e seu valor "teto" (maior inteiro).

--28. Sinal do Estoque: Use uma função para mostrar se o estoque de cada produto é positivo (1), zero (0) ou negativo (-1).

