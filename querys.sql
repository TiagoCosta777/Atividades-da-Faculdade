USE sakila;

-- Exercícios de SQL com o Banco de Dados Sakila
-- Parte 1: Consultas Básicas (SELECT, WHERE, ORDER BY, LIMIT)
-- Listagem Simples: Selecione o nome (first_name) e sobrenome (last_name) de todos os atores que têm o primeiro nome 'PENELOPE'.
SELECT 
first_name,
last_name
FROM actor
WHERE first_name = 'PENELOPE'
;

-- Ordenação: Mostre todos os filmes (title) que têm duração (length) maior que 120 minutos, ordenados pela duração em ordem decrescente.
SELECT 
title,
length
FROM film
WHERE length > 120
ORDER BY length DESC
;
-- Filtro com Datas: Liste todos os aluguéis (rental) que foram feitos no mês de junho de 2005. Ordene os resultados pela data do aluguel (rental_date), do mais recente para o mais antigo.
SELECT 
rental_id,
rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-01' AND '2005-06-30'
ORDER BY rental_date DESC
;
-- Uso do LIMIT: Identifique os 10 filmes com a maior taxa de substituição (replacement_cost). A consulta deve retornar o título do filme (title) e seu custo de substituição.




-- Múltiplos Critérios: Encontre todos os clientes (customer) que foram criados (create_date) antes de 2006 e que moram na cidade de 'London' (você precisará fazer JOIN com a tabela address e city).

-- Parte 2: Agregação e Agrupamento (Aggregate Functions, GROUP BY, HAVING)
-- Contagem Simples (COUNT): Quantos filmes ao todo são da categoria 'Action'?

-- Média de Duração (AVG): Qual é a duração média de todos os filmes cadastrados na tabela film? Dê um nome (alias) para a coluna de resultado como DuracaoMedia.

-- Agrupamento (GROUP BY): Crie uma consulta que mostre a quantidade de clientes existentes em cada cidade (city).

-- Soma (SUM) com Agrupamento: Calcule o valor total pago (amount) por cada cliente (customer_id) na tabela payment. A consulta deve mostrar o customer_id e a soma total.

-- Filtro de Grupos (HAVING): Liste todas as categorias que possuem mais de 60 filmes. A consulta deve mostrar o nome da categoria e a contagem de filmes.

-- Consulta Complexa com Agregação: Mostre o filme (film_id) e o valor total arrecadado (amount) para cada filme na tabela rental e payment. Liste apenas os filmes cujo valor total arrecadado ultrapasse $100 e ordene do maior para o menor valor.

-- Parte 3: Subconsultas e Cláusulas Adicionais
-- Uso de DISTINCT: Crie uma consulta que retorne todos os anos (release_year) únicos para os quais existem filmes cadastrados.

-- Subconsulta com IN: Liste o título de todos os filmes que são da categoria 'Horror'. (Dica: primeiro, use uma subconsulta para encontrar o category_id de 'Horror' na tabela category).

-- Subconsulta com Agregação: Mostre todos os filmes cuja duração (length) é maior que a duração média de todos os filmes.

-- Parte 4: Manipulação de Dados (INSERT, UPDATE, DELETE)
-- Inserção (INSERT): Insira um novo ator na tabela actor. O primeiro nome (first_name) deve ser "JOÃO" e o sobrenome (last_name) deve ser "SILVA".

-- Atualização (UPDATE): O sobrenome do ator "JOÃO SILVA" mudou. Atualize o registro na tabela actor para o novo sobrenome "OLIVEIRA".

-- Exclusão (DELETE): Exclua o ator chamado "JOÃO OLIVEIRA" da tabela actor.

-- Parte 5: Junções (JOIN)
-- INNER JOIN: Liste o título dos filmes e o nome das categorias a que pertencem.

-- LEFT JOIN: Mostre todos os clientes e seus endereços completos (incluindo cidade e país), mesmo que alguns dados estejam faltando.

-- Múltiplos JOINs: Crie uma consulta que mostre o nome do cliente, o título do filme que ele alugou e a data do aluguel. Você precisará juntar as tabelas customer, rental, inventory e film.

-- Parte 6: Consultas Avançadas
-- CASE Statement: Categorize os filmes por duração:

-- 'Curto' para filmes com menos de 60 minutos

-- 'Médio' para filmes entre 60 e 120 minutos

-- 'Longo' para filmes com mais de 120 minutos

-- Funções de Data: Liste todos os aluguéis que aconteceram no último trimestre de 2005.

-- Consulta Correlacionada: Encontre todos os clientes que gastaram mais que a média de gastos de todos os clientes.

-- Window Functions: Mostre para cada filme, seu título, duração e a duração média da categoria a que pertence.

-- Consulta Recursiva (CTE): Crie uma consulta que mostre a hierarquia de funcionários (staff) caso houvesse uma relação de gerência na tabela.

