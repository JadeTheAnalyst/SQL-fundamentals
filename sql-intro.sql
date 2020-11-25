
Use weclouddatamovies;
SELECT
first_name,
last_name
FROM actor;

SELECT distinct 
first_name
FROM actor;

#1
SELECT *
FROM actor
LIMIT 10;

#2
SELECT *
FROM rental;

#3
SELECT rental_date,customer_id
FROM rental;

#4
SELECT first_name, last_name, email
FROM customer;

#5
SELECT DISTINCT  rating
FROM film;

SELECT DISTINCT  rental_duration
FROM film;

SELECT * from Film
Where rating <> "R" and rental_rate >3;

SELECT * from Film
# Where rating <> "R" and rental_rate >3;
# Where rental_duration between 4 and/or 6;
#where rental_duration >=4 and rental_duration <6
#Where rental_duration in (4,5,6)
WHERE title like 'B%' AND rental_duration in (4,5,6)
order by rental_rate  #ASC DEFAULT

SELECT  title, rental_rate, rating
FROM film
WHERE rental_duration in (4,6)
ORDER BY 2 DESC;

#1,2
SELECT
customer_id,
rental_id, 
amount,
payment_date
FROM payment
WHERE customer_id <= 100 and payment_date > " 2006-01-01"
ORDER BY amount

#3
SELECT
customer_id,
rental_id, 
amount,
payment_date
FROM payment
WHERE amount= 0.99 and payment_date > " 2006-01-01"
ORDER BY customer_id desc

#4
SELECT * from customer
where first_name like "a%"
#4
SELECT * from customer
where first_name not like "%a%"

#Total spent for each customer
SELECT customer_id, sum(amount)
FROM payment
Group By customer_id

#Total spent for each customer
SELECT customer_id, sum(amount) #Max AVG order #Most frequent count
FROM payment
Group By customer_id
ORDER BY sum(amount) Desc

#Total spent for each customer #Good to use aliases when you export data
SELECT customer_id as 'customer', sum(amount) as 'Total Spent'  #Max AVG order #Most frequent count
FROM payment
Group By customer_id
ORDER BY sum(amount) Desc
#1
SELECT 
staff_id as "Staff ID",
avg(amount) as "Average Revenue"
FROM payment
Group By staff_id

#2 of movies that were rented 6 or 7 times
SELECT 
rental_duration as 'Rental Duration',
count(film_id) as '# of Movies'
FROM film
Group BY rental_duration
ORDER BY rental_duration DESC

#3 Relating rating and amount of revenue associated wuth that 
SELECT
rating as 'Movie Rating', 
COUNT(film_id) as '# of Movies',
MIN(rental_rate) as 'Minimum Rental Rate',
MAX(rental_rate) as 'Maximum Rental Rate',
AVG(rental_rate) as 'Maximum Rental Rate'
FROM film
Group BY rating

#1
SELECT
customer_id as 'Customer ID',
COUNT(payment_id) as 'Number of Transactions'
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id)>=25
ORDER BY COUNT(payment_id) DESC

#2
SELECT
customer_id as 'Customer ID',
SUM(amount) as 'Total Spent'
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>=100
ORDER BY SUM(amount) DESC

#3
SELECT
customer_id as 'Customer ID',
COUNT(payment_id) as 'Number of Transactions',
SUM(amount) as 'Total Spent'
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id)>=25 AND SUM(amount)>=100
ORDER BY SUM(amount) DESC

#Joins
# 1
SELECT distinct
b.store_id,
a.title as 'Movie Title',
a.description as 'Movie Description'
FROM film as a
INNER JOIN inventory as b
on a.film_id=b.film_id
WHERE b.store_id=2

#2
SELECT
title as 'Movie Title',
COUNT(actor_id) as '# of Actors'
FROM film as a
LEFT JOIN film_actor as b
on a.film_id=b.film_id
GROUP BY title
ORDER BY COUNT(actor_id) DESC

#3
SELECT
title as 'Movie Title',
name as 'Movie Category'
FROM film as a
LEFT JOIN film_category as b
on a.film_id=b.film_id
LEFT JOIN category as c
on b.category_id=c.category_id

#4
SELECT 
a.customer_id as 'Customer ID', 
SUM(amount) as 'Total Spent',
first_name as 'First Name',
last_name as 'Last Name', 
address as 'Address',
city as City, 
district as 'Province or State', 
postal_code as 'Postal Code',
country as Country, email as Email
FROM customer as a JOIN address as b on a.address_id=b.address_id
JOIN city as c on b.city_id=c.city_id JOIN country as d on c.country_id=d.country_id
JOIN payment as e on a.customer_id=e.customer_id
GROUP BY a.customer_id
ORDER BY SUM(e.amount) DESC
LIMIT 10
