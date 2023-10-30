USE sakila;
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT *, COUNT(inventory_id) FROM film
JOIN inventory
USING (film_id)
WHERE title LIKE 'Hunchback%'
GROUP BY inventory_id;

SELECT COUNT(*) AS copy_quantity
FROM inventory
WHERE film_id IN(
SELECT film_id
FROM film
WHERE title LIKE 'Hunchback Impossible');
-- Six (6) copies of Hunchback Impossible

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT * FROM film
WHERE length >
(SELECT AVG(length) FROM film)
ORDER by length DESC;
-- Durations range from 116 to 185 mins

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT actor_id, CONCAT(first_name,' ', last_name) AS full_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'));
        
-- 6. Determine which films were starred by the most prolific actor in the Sakila database
SELECT title FROM film
WHERE film_id IN (
SELECT film_id
FROM film_actor
WHERE actor_id IN (
SELECT actor_id
FROM actor
WHERE (CONCAT(first_name, ' ', last_name) = 'GINA DEGENERES')));

SELECT *, COUNT(actor_id) AS roles FROM actor
JOIN film_actor
USING (actor_id)
JOIN film
USING (film_id)
GROUP BY actor_id
ORDER BY roles DESC;
