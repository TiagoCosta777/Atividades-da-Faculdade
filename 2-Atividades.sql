USE TSQLV6;
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




--7. Busca por Múltiplos Padrões: Liste os clientes cujo nome do país comece com 'U' mas não seja 'USA'.

--8. Verificação de Nulos com Texto: Selecione todos os clientes e mostre o nome da empresa. Se a região for nula, exiba o texto 'N/A' no lugar do nulo.

--9. Remoção de Espaços: Supondo que a coluna de telefone dos clientes pudesse ter espaços extras, escreva uma consulta que remova espaços à esquerda e à direita de todos os números de telefone.

--10. Busca por Caractere Específico: Encontre todos os produtos cujo nome contenha um apóstrofo (').