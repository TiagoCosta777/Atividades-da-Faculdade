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
SELECT 
ProductName,
POWER(CAST(UnitPrice AS FLOAT), UnitsInStock) AS POTENCIACAO
FROM Products
;
GO

--24. Raiz Quadrada: Exiba a raiz quadrada do ID dos primeiros 10 produtos.
SELECT TOP(10)
ProductID,
SQRT(ProductID)
FROM Products
ORDER BY ProductID ASC
;
GO
--25. Valor Máximo entre Colunas: Para cada produto, mostre o maior valor entre as unidades em estoque e as unidades em pedido.
SELECT ProductID,
GREATEST(UnitsInStock, UnitsOnOrder) AS MAIOR_VALOR
FROM Products
;
GO

--26. Conversão de Tipos: Some o ID do produto com o ID da sua categoria. Em seguida, tente concatenar o ID do produto com o seu nome sem fazer uma conversão explícita e observe o erro. Corrija a consulta para que funcione.
SELECT 
ProductID,
CategoryID,
ProductID+CategoryID AS SOMA_ID
FROM Products
;
GO

--27. Piso e Teto: Para os 10 produtos mais caros, mostre o preço unitário, seu valor "piso" (menor inteiro) e seu valor "teto" (maior inteiro).
SELECT TOP(10)
ProductID,
UnitPrice,
FLOOR(UnitPrice) AS VALOR_PISO,
CEILING(UnitPrice) AS VALOR_TETO
FROM Products
ORDER BY UnitPrice DESC
;
GO

--28. Sinal do Estoque: Use uma função para mostrar se o estoque de cada produto é positivo (1), zero (0) ou negativo (-1).
SELECT ProductID,
UnitsInStock,
SIGN(UnitsInStock) AS Sinal_do_Estoque
FROM Products
;
GO


-- Parte 4: Operadores de Conjunto e Filtros Avançados


--29. União de Cidades: Crie uma lista única de todas as cidades onde há clientes e onde há fornecedores.
SELECT City
FROM Customers
UNION
SELECT City
FROM Suppliers
;
GO

--30. União com Duplicatas: Faça o mesmo que no exercício anterior, mas agora inclua as cidades duplicadas.
SELECT City
FROM Customers
UNION ALL
SELECT City
FROM Suppliers
;
GO

--31. Interseção de Países: Liste todos os países que têm tanto clientes quanto fornecedores.
SELECT Country
FROM Customers
INTERSECT
SELECT Country
FROM Suppliers
;
GO

--32. Filtro com Lista: Selecione todos os produtos que pertencem às categorias 'Confections' ou 'Dairy Products'.
SELECT 
P.ProductID,
P.ProductName 
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName IN ('Confections', 'Dairy Products')
;
GO

--33. Clientes sem Pedidos: Liste todos os clientes que nunca fizeram um pedido.
SELECT 
C.CustomerID,
C.CompanyName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL
;
GO

--34. Intervalo de Preços: Encontre todos os produtos com preço unitário entre $20 e $50.
SELECT 
ProductID,
ProductName,
UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 50
;
GO

--35. Intervalo de Datas: Liste todos os pedidos feitos no primeiro semestre de 1998.
SELECT
OrderID,
OrderDate
FROM Orders
WHERE YEAR(OrderDate) = 1998
AND MONTH(OrderDate) BETWEEN 1 AND 6
;
GO

--36. Verificação de Nulos: Encontre todos os clientes cuja região não está preenchida.
SELECT CustomerID,
ContactName,
Region
FROM Customers
WHERE Region IS NULL
; 
GO

--37. Verificação de Não Nulos: Liste todos os funcionários que têm um supervisor.
SELECT*
FROM Employees
WHERE ReportsTo IS NOT NULL
;
GO


--38. Verificação de Existência: Selecione todos os fornecedores para os quais existe pelo menos um produto cadastrado.
SELECT*
FROM Suppliers S
WHERE EXISTS (
SELECT 1
FROM Products P 
 WHERE P.SupplierID = S.SupplierID)
;
GO


-- Parte 5: Exercícios Mistos e Desafios


--39. Formato de Endereço: Crie uma consulta que exiba o endereço completo dos clientes da 'Germany' em uma única coluna, no formato: "Endereço: [Address], Cidade: [City], CEP: [PostalCode]".
SELECT CONCAT('Endereço: ', Address, ' Cidade: ', City, ' Cep: ', PostalCode) AS ENDERECO
FROM Customers
WHERE Country = 'Germany'
;
GO

--40. Relatório de Vendas Mensal: Agrupe as vendas por ano e mês, mostrando o valor total vendido. Ordene pelo ano e depois pelo mês.
SELECT
YEAR(O.OrderDate) AS ANO,
MONTH(O.OrderDate) AS MES,
SUM(OD.UnitPrice * OD.quantity) AS TOTAL_VEN
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
ORDER BY ANO, MES
;
GO

--41. Produtos sem Venda: Liste todos os produtos que nunca foram vendidos.
SELECT CONCAT( 'Codigo Produto: ', P.ProductID, ' Codigo Saida: ',
O.OrderID) AS VENDAS_NULAS
FROM Products P
LEFT JOIN [Order Details] O ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL
;
GO

--42. Análise de Descontos: Calcule o valor total de desconto concedido por categoria de produto.
SELECT C.CategoryName,
SUM(OD.UnitPrice * OD.Quantity * OD.Discount) AS DESCONTO
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID 
GROUP BY C.CategoryName
;
GO

--43. Conversão para Moeda: Apresente o preço unitário de cada produto como uma string, formatada como 'R$ xx.xx'.
SELECT
ProductName,
FORMAT(UnitPrice, 'C', 'pt-BR') AS PRECO
FROM Products
;
GO

--44. Clientes e Fornecedores na Mesma Cidade: Liste os nomes das empresas de clientes e fornecedores que estão localizados na mesma cidade.
SELECT
C.ContactName,
C.City
FROM Customers C
WHERE C.City IN( SELECT S.City FROM Suppliers S
);
GO
--45. Relatório de Frete: Para cada país de destino, calcule o custo médio do frete e o total de pedidos. Mostre apenas os países com mais de 10 pedidos.
SELECT 
ShipCountry,
AVG(Freight) AS PRECO_MEDIO_FRETE,
COUNT(OrderID) AS TOTAL
FROM Orders 
GROUP BY ShipCountry
HAVING COUNT(OrderID) > 10
ORDER BY PRECO_MEDIO_FRETE, TOTAL
;
GO



--46. Funcionário do Mês: Identifique o funcionário que registrou o maior número de pedidos em julho de 1997.
SELECT E.EmployeeID,
E.FirstName,
COUNT(O.EmployeeID) AS TOTAL,
YEAR(OrderDate) AS ANO,
MONTH(OrderDate) AS MES
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeID, E.FirstName
HAVING YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 7
ORDER BY TOTAL DESC
;
GO




--47. Primeiro e Último Pedido: Para cada cliente, mostre a data do seu primeiro e do seu último pedido.

--48. Produtos com "Chocolate": Encontre todos os produtos que contenham a palavra "chocolate" em seu nome, independentemente de estar em maiúsculas ou minúsculas.

--49. Diferença de Preço para a Média: Para cada produto, mostre seu nome, seu preço e uma coluna indicando a diferença entre o seu preço e o preço médio de todos os produtos.

--50. Ranking de Vendas por Produto: Crie um ranking dos 10 produtos mais vendidos (em valor total). A consulta deve mostrar a posição no ranking, o nome do produto e o total vendido.