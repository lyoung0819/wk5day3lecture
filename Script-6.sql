-- MULTI JOINS & SUBQUERIES


-- >> MULTI JOINS <<
SELECT * FROM film;

SELECT * FROM actor a;

-- film & actor relationship is many to many 
-- this is shown with the film_actor table

SELECT * FROM film_actor fa;


-- To connect tables to find multiple pieces of information from 2+ tables 
-- JOIN between the film and film_actor table 
SELECT * FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id;

-- JOIN between the actor and film_actor table
SELECT * FROM film_actor fa 
JOIN actor a 
ON a.actor_id = fa.actor_id;

-- to do Multi JOIN
SELECT a.first_name, a.last_name, a.actor_id, fa.actor_id, fa.film_id, f.film_id, f.title, f.description FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
JOIN film f 
ON f.film_id = fa.film_id; 

-- display customer name and film that they rented -- start with customer table > join to rental > join rental to inventory > join inventory to film
SELECT c.first_name, c.last_name, f.title, f.description  
FROM customer c 
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE c.first_name LIKE 'R%'
ORDER BY f.title
OFFSET 10
LIMIT 5;



-- >> SUBQUERIES <<
-- Subqueries are queries within other queries 

-- Example: Which films have exactly 12 actors in it?
-- Step1: You'd want to look for the film_ids from the film_actor table that have a count of 12
SELECT film_id, count(*)
FROM film_actor fa 
GROUP BY film_id 
HAVING count(*) = 12

-- film_id|count|
-------+-----+
--    529|   12|
--    802|   12|
--     34|   12|
--   892|   12|
--    414|   12|
--    517|   12|

-- Step2: Query the film table for films that match those IDS 
SELECT * 
FROM film 
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);

-- This required two queries. OR we can put these both into a subquery! 

-- The query that we want to execute first is the subquery
-- ** Subqueries must return only ONE column ** *unless used in a from clause* 

-- subquery: 
SELECT film_id
FROM film_actor fa 
GROUP BY film_id 
HAVING count(*) = 12

-- main query: 
SELECT * 
FROM film 
WHERE film_id IN (
	
);

-- put them together: subquery goes ito the IN clause
SELECT * 
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM film_actor fa 
	GROUP BY film_id 
	HAVING count(*) = 12	
);

-- Subqueries and joins can be interchanged in some cases, but they are different

-- >> SUBQUERY VS JOIN <<

--Which employee has sold the most rentals (use the rental table)
--Subqueries will only look at one column, can't see other data 
SELECT * 
FROM staff
WHERE staff_id = (
	SELECT staff_id
	FROM rental 
	GROUP BY staff_id
	ORDER BY count(*) DESC
	LIMIT 1
	);
	
-- Joins will allow you to use other columns and info in tables 
SELECT s.staff_id, first_name, last_name, count(*) 
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id 
GROUP BY s.staff_id 
ORDER BY COUNT(*) DESC;

-- Subqueries can be used for calculations 
-- Find all of the payments that are more than the average payment 
SELECT * 
FROM payment p 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);

-- Subqueries with the FROM clause 
-- ***Subquery in a FROM must have an alias** 

-- Find the average num of rentals per customer

-- Step1: Get the count for each customer
SELECT customer_id, COUNT(*) AS num_rentals 
FROM rental
GROUP BY customer_id;

-- Step2. Use the temp table from Step 1 as the table to find the AVG via subquery 
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals 
	FROM rental
	GROUP BY customer_id
) AS customer_rental_totals;

-- This acts as a normal table with regular DQL, so we can do all other DQL clauses 



SELECT *
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals 
	FROM rental
	GROUP BY customer_id
) -- AS customer_rental_totals
WHERE num_rentals > 40
ORDER BY num_rentals;