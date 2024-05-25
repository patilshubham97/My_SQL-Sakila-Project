use sakila;

# Q.1) List all the films in the Sakila database. 
SELECT title FROM film;

# Q.2) Find all the actors whose first name is 'Johnny'.
SELECT first_name, last_name FROM actor WHERE first_name = 'Johnny';

# Q.3) Retrieve the titles of films that were released in the year 2006.
SELECT title FROM film WHERE release_year = 2006;

# Q.4) List all films and their respective categories.
SELECT f.title, c.name FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id;

# Q.5) Find all the films that a particular actor (e.g., 'Johnny Depp') has appeared in.
SELECT f.title FROM film f JOIN film_actor fa 
ON f.film_id = fa.film_id JOIN actor a 
ON fa.actor_id = a.actor_id 
WHERE a.first_name = 'Garry' AND a.last_name = 'Penn';

# Q.6) Show the first and last names of all customers along with the titles of the films they have rented.
SELECT c.first_name, c.last_name, f.title FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id;

# Q.7) Count the total number of films in the inventory.
SELECT COUNT(*) FROM film;

# Q.8) Find the average rental duration of all films.
SELECT AVG(rental_duration) FROM film; 

# Q.9) Determine the total amount of money spent by each customer.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent 
FROM customer c JOIN payment p 
ON c.customer_id = p.customer_id 
GROUP BY c.customer_id;

# Q.10) Find the film with the highest rental rate.
SELECT title FROM film 
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film); 

# Q.11) List all customers who have never rented a film.
SELECT first_name, last_name FROM customer 
WHERE customer_id NOT IN (SELECT customer_id FROM rental); 

# Q.12) Retrieve the titles of films that have never been rented.
SELECT title FROM film 
WHERE film_id NOT IN (SELECT film_id FROM inventory WHERE inventory_id 
IN (SELECT inventory_id FROM rental));

# Q.12) List all actors who have appeared in films in the 'Action' category.
SELECT DISTINCT a.first_name, a.last_name 
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Action'; 

# Q.14) Find all customers who have rented more than 10 films.
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS rentals 
FROM customer c JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id 
HAVING rentals > 10; 

# Q.15) List all films along with their language names.
SELECT f.title, l.name AS language 
FROM film f JOIN language l ON f.language_id = l.language_id;

# Q.16) Find the rental date of the most recently rented film.
SELECT rental_date FROM rental 
ORDER BY rental_date DESC LIMIT 1; 

# Q.17) Retrieve all rentals made in the last 10 days.
SELECT * FROM rental 
WHERE rental_date >= DATE_SUB(CURDATE(), 
INTERVAL 10 DAY); 

# Q.18) List all films that were released after the year 2000.
SELECT title FROM film 
WHERE release_year >2000;

# Q.19) Find all actors whose last name starts with 'A'.
SELECT first_name, last_name FROM actor 
WHERE last_name LIKE 'A%';
 
# Q.20) Retrieve the titles of films that contain the word 'Love'.
SELECT title FROM film WHERE title LIKE '%Love%';

# Q.21) Find the number of films in each category.
SELECT c.name, COUNT(f.film_id) AS film_count FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id GROUP BY c.name; 

# Q.22) Retrieve the top 5 categories by the number of films.
SELECT c.name, COUNT(f.film_id) AS film_count FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
GROUP BY c.name 
ORDER BY film_count 
DESC LIMIT 5;




