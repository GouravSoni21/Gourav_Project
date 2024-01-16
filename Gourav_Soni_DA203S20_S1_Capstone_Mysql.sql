use sakila;
### Task 1 ###
# Display the fullname of the all actor using concat 

SELECT actor_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;

### Task 2 ###
# To display the number of times each first name appears in the Sakila database,
#  we can use the 'COUNT' function along with the 'GROUP BY' clause.

SELECT COUNT(*) AS unique_actor_count
FROM (SELECT first_name FROM actor GROUP BY first_name HAVING COUNT(DISTINCT actor_id) = 1) AS unique_actors;

### Task 2.2 ###
# these are th actors first name that have a unique names in the sakila database

SELECT CONCAT(first_name) AS unique_actor_name, COUNT(*) AS name_count
FROM actor
GROUP BY unique_actor_name
ORDER BY name_count desc;

### Task 3 ###
# To display the number of times each last name appears in the Sakila database,
#  we can use the 'COUNT' function along with the 'GROUP BY' clause .

SELECT COUNT(*) AS unique_actor_count
FROM (SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(DISTINCT actor_id) = 1) AS unique_actors;

# these are th actors last name that have a unique names in the sakila database

SELECT CONCAT(last_name) AS unique_actor_name, COUNT(*) AS name_count
FROM actor
GROUP BY unique_actor_name
ORDER BY name_count desc;

### Task 4 ###
# Displaying the records for the movies with the rating "R" (age = < 17 Year)

select * from film where rating = 'R';

### Task 4.2 ###
# Displaying the records for the movies that are not rated "R"

select * from film where rating != 'R';

### Task 4.3 ###
# Displaying the records for the movies that are suitable for audience below 13 year of age 

select * from film where rating = 'PG-13';

### Task 5 ###
# Displaying the records for the movies where the replacement cost is up to $11 

select * from film where replacement_cost <= 11;

### Task 5.2 ### 
#  Displaying the records for the movies where the replacement cost is between 11$ and 20$ 

select * from film where replacement_cost between 11 and 20;

### Task 5.3 ###
# # Displaying the records for the movies in Descending Order of there replaecement cost 

select * from film  ORDER BY replacement_cost desc; ;

### Task 6 ### 
# Display the names of the top 3 movies with the greatest number of actors  

SELECT film.title AS movie_title, COUNT(film_actor.actor_id) AS actor_count
FROM film JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id ORDER BY actor_count DESC LIMIT 3;

### Task 7 ### 
# Display the titles of movies starting with the letters (K and Q) 

select * from film where title like 'K%'or title like 'Q%';

### Task 8 ###
# Display the names of all actors who appeared in the film (Agent Truman)

SELECT actor.first_name, actor.last_name FROM actor JOIN film_actor ON actor.actor_id = 
film_actor.actor_id JOIN film ON film_actor.film_id = film.film_id WHERE film.title = 'AGENT TRUMAN';

### Task 9 ### 
# identify all the movies categorized as family films 

SELECT film.title, category.name AS category
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

### Task 10 ###
/* maximum, minimum, and average rental rates for each movie rating group, and then order the
results in descending order based on the average rental rates.*/

SELECT 
    film.rating,
    MAX(film.rental_rate) AS max_rental_rate,
    MIN(film.rental_rate) AS min_rental_rate,
    AVG(film.rental_rate) AS avg_rental_rate
FROM film GROUP BY film.rating ORDER BY avg_rental_rate DESC;

### Task 10.2 ###
/* The rental frequency for each movie by counting the number of times and make it appears in the "rental" table. Then result  
sorted in descending order based on the rental frequencies.*/

SELECT film.title, COUNT(rental.rental_id) AS rental_frequency
FROM film JOIN inventory ON film.film_id = inventory.film_id JOIN rental ON inventory.inventory_id = rental.inventory_id
 GROUP BY film.title ORDER BY rental_frequency DESC;

### Task 11 ###
# To display number of film categories whose difference between the avg. film replacement cost and the avg. film rental rate is > $15
 
SELECT category.name AS category_name,
    AVG(film.replacement_cost - film.rental_rate) AS cost_rate_difference,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    AVG(film.rental_rate) AS avg_rental_rate
FROM film JOIN film_category ON film.film_id = film_category.film_id JOIN category ON film_category.category_id = category.category_id
GROUP BY category_name HAVING cost_rate_difference > 15 ORDER BY cost_rate_difference DESC;

### Task 11.2 ###
# Display the list of all film categories identify above along with the Corresponding average film replacement
# cost and average film rental rate 

SELECT category.name AS category_name,
    COUNT(*) AS category_count,
    AVG(film.replacement_cost - film.rental_rate) AS cost_rate_difference,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    AVG(film.rental_rate) AS avg_rental_rate
FROM film JOIN film_category ON film.film_id = film_category.film_id JOIN category ON film_category.category_id = category.category_id
GROUP BY category_name HAVING cost_rate_difference > 15 ORDER BY cost_rate_difference DESC;

### Task 12 ###
# Display the film categories in which the number of movies is > 70  

SELECT category.name AS category_name, COUNT(*) AS movie_count
FROM film JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id GROUP BY category_name
HAVING movie_count > 70 ORDER BY movie_count DESC;

