USE TSQLV6;
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




--7. Busca por M�ltiplos Padr�es: Liste os clientes cujo nome do pa�s comece com 'U' mas n�o seja 'USA'.

--8. Verifica��o de Nulos com Texto: Selecione todos os clientes e mostre o nome da empresa. Se a regi�o for nula, exiba o texto 'N/A' no lugar do nulo.

--9. Remo��o de Espa�os: Supondo que a coluna de telefone dos clientes pudesse ter espa�os extras, escreva uma consulta que remova espa�os � esquerda e � direita de todos os n�meros de telefone.

--10. Busca por Caractere Espec�fico: Encontre todos os produtos cujo nome contenha um ap�strofo (').