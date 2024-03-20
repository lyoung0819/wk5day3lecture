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
ON i.film_id = f.film_id;




-- >> SUBQUERIES <<

