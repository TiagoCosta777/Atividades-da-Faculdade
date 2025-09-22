USE SQL_EX;

-- 3 - Atividade JOINs e Fun��es Avan�adas
--Exerc�cios


    --1. Consulta B�sica: Liste o nome de cada produto e o nome da sua respectiva categoria.
    SELECT PR.ProductID,
    PR.ProductName,
    CA.CategoryName
    FROM Products PR
    JOIN Categories CA ON PR.CategoryID = CA.CategoryID
    ;
    GO



    --2. Pedidos e Clientes: Mostre o OrderID de cada pedido e o nome da empresa do cliente que o realizou.
    SELECT OD.OrderID,
    CS.CompanyName
    FROM Customers CS
    JOIN Orders OD ON CS.CustomerID = OD.CustomerID
    GO

    --3. Clientes e Seus Pedidos (Incluindo os sem pedidos): Crie uma lista com o nome de todos os clientes e os OrderIDs dos pedidos que eles fizeram. Clientes que nunca fizeram pedidos devem aparecer na lista.
    SELECT CS.ContactName,
    OD.OrderID
    FROM Customers CS
    LEFT JOIN Orders OD ON CS.CustomerID = OD.CustomerID
    ;


    --4. Produtos de Fornecedores Japoneses: Liste o nome dos produtos fornecidos por empresas localizadas no Jap�o.
    SELECT PR.ProductName,
    SP.CompanyName,
    SP.Country
    FROM Products PR
    JOIN Suppliers SP ON PR.SupplierID = SP.SupplierID
    WHERE SP.Country = 'Japan'
    ;

    --5. Formata��o de Nomes de Funcion�rios: Crie uma consulta que mostre o nome completo dos funcion�rios e o nome completo dos seus respectivos supervisores diretos, ambos em uma �nica coluna formatada como "SOBRENOME, NOME".
    SELECT 
   CONCAT(' NOME: ', F.FirstName, ' SOBRENOME: ', F.LastName) AS FUNCIONARIO,
   CONCAT(' NOME: ', S.FirstName, ' SOBRENOME: ', S.LastName) AS SUPERVISOR
    FROM Employees F
   JOIN Employees S ON F.ReportsTo = S.EmployeeID
    ;

    --6. Contagem de Pedidos por Funcion�rio: Mostre o nome de todos os funcion�rios e a quantidade de pedidos que cada um registrou. Funcion�rios que nunca registraram um pedido devem aparecer com contagem 0.
    SELECT 
    E.FirstName,
    COUNT(OD.EmployeeID) AS TOTAL
    FROM Orders OD
    RIGHT JOIN Employees E ON OD.EmployeeID = E.EmployeeID
    GROUP BY E.FirstName
    ;
    GO

    --7. Valor Total em Estoque por Fornecedor: Calcule o valor total em estoque (UnitPrice * UnitsInStock) para os produtos de cada fornecedor. Mostre o nome do fornecedor e o valor total, mas apenas para fornecedores cujo valor total em estoque exceda $3.000.
    SELECT*
    FROM [Order Details]
    JOIN Products



    --8. Fornecedores Sem Produtos: Identifique o nome das empresas fornecedoras que n�o possuem nenhum produto cadastrado.

    --9. Relat�rio Detalhado de Pedido: Para o pedido 10251, mostre o nome do cliente, a data do pedido formatada como dd/MM/yyyy, o nome do produto, a quantidade e o pre�o unit�rio.

    --10. Categorias e Contagem de Produtos: Liste o nome de todas as categorias e a quantidade de produtos em cada uma. Inclua categorias que n�o possuem nenhum produto.

    --11. Pedidos de 'Michael Suyama': Mostre todos os OrderIDs e as datas dos pedidos registrados pelo funcion�rio 'Michael Suyama'.

    --12. Combina��o Cruzada: Gere uma lista com todas as combina��es poss�veis entre os nomes das categorias e os nomes das empresas transportadoras.

    --13. Vendas por Transportadora e Cliente: Calcule o valor total de frete (Freight) pago por cada cliente a cada transportadora. A consulta deve exibir o nome do cliente, o nome da transportadora e a soma do frete.

    --14. Tempo de Servi�o: Para cada pedido, mostre o OrderID e h� quantos anos o funcion�rio que o registrou trabalhava na empresa naquela data (diferen�a entre OrderDate e HireDate).

    --15. Relat�rio de Vendas Formatado: Crie um relat�rio que mostre uma descri��o de cada venda. A coluna deve conter um texto formatado como: "O cliente [Nome do Cliente] comprou [Quantidade] unidade(s) de [Nome do Produto] em [Data do Pedido formatada]."

    --16. Cliente com Maior Gasto em Frete: Identifique qual cliente gastou mais com frete no total. A consulta deve retornar apenas o nome do cliente e o valor total gasto.

    --17. Categorias Nunca Vendidas para o M�xico: Liste as categorias de produtos que nunca foram vendidas para clientes no M�xico.

    --18. Funcion�rios e Seus Supervisores: Crie uma consulta que mostre o nome de cada funcion�rio e o nome do seu supervisor direto. Funcion�rios sem supervisor devem aparecer na lista.

    --19. Vendas Totais por Ano: Junte os dados de pedidos e detalhes de pedidos para calcular o total de vendas (excluindo o frete) para cada ano. A consulta deve mostrar o ano e o valor total vendido.

    --20. Produtos com "Chocolate": Encontre todos os produtos que contenham a palavra "chocolate" em seu nome, e liste tamb�m o nome da categoria e do fornecedor.

    --21. Pedidos e Funcion�rios (Perspectiva dos Pedidos): Usando RIGHT JOIN, mostre o nome e sobrenome do funcion�rio associado a cada pedido. Garanta que todos os pedidos apare�am.

    --22. Diferen�a de Pre�o para a M�dia da Categoria: Para cada produto, mostre seu nome, o nome da categoria, seu pre�o e uma coluna indicando a diferen�a entre o seu pre�o e o pre�o m�dio de todos os produtos da sua categoria.

    --23. Primeiro e �ltimo Pedido por Cliente: Para cada cliente, mostre o nome da empresa, a data do seu primeiro pedido e a data do seu �ltimo pedido.

    --24. Fornecedores com Produtos Acima de $50: Liste o nome e o pa�s de todos os fornecedores que oferecem pelo menos um produto com pre�o unit�rio acima de $50.

    --25. Ranking de Vendas por Funcion�rio: Crie um ranking dos funcion�rios baseado no valor total de vendas que eles geraram. A consulta deve mostrar a posi��o no ranking, o nome completo do funcion�rio e o valor total vendido.