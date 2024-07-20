-- Insert data into date_dim
INSERT INTO date_dim(
	date_key,
	date,
	year,
	quarter,
	month,
	day,
	week,
	is_weekend
) 
SELECT
	DISTINCT(TO_CHAR(payment_date :: DATE, 'YYYYMMDD')::integer) as date_key,
	date(payment_date) AS date,
	EXTRACT(year FROM payment_date) as year,
	EXTRACT(quarter FROM payment_date) as quarter,
	EXTRACT(month FROM payment_date) as month,
	EXTRACT(day FROM payment_date) as day,
	EXTRACT(week FROM payment_date) as week,
	CASE WHEN EXTRACT(isodow FROM payment_date) IN (6,7) THEN true ELSE false END AS is_weekend
FROM payment;

-- Insert data into customer_dim
INSERT INTO customer_dim(
	customer_key,
	customer_id,
	first_name,
	last_name,
	email,
	address,
	address2,
	district,
	city,
	country,
	postal_code,
	phone,
	active,
	create_date,
	start_date,
	end_date
) SELECT
	c.customer_id as customer_key,
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email,
	a.address,
	a.address2,
	a.district,
	ci.city,
	co.country,
	a.postal_code,
	a.phone,
	c.active,
	c.create_date,
	now() as start_date,
	now() as end_date
FROM customer c
JOIN address a ON (c.address_id = a.address_id)
JOIN city ci ON (a.city_id = ci.city_id)
JOIN country co ON (ci.country_id = co.country_id);

-- Insert data into store_dim
INSERT INTO store_dim(
	store_key,
	store_id,
	address,
	address2,
	district,
	city,
	country,
	postal_code,
	manager_first_name,
	manager_last_name,
	start_date,
	end_date
) SELECT
	st.store_id as store_key,
	st.store_id,
	a.address,
	a.address2,
	a.district,
	ci.city,
	co.country,
	a.postal_code,
	s.first_name as manager_first_name,
	s.last_name as manager_last_name,
	now() as start_date,
	now() as end_date
FROM store st
JOIN address a ON st.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN staff s ON st.manager_staff_id = s.staff_id;

-- Insert data into movie_dim
INSERT INTO movie_dim(
	movie_key,
	film_id,
	title,
	description,
	release_year,
	language,
	original_language,
	rental_duration,
	length,
	rating,
	special_features
) SELECT
	f.film_id as movie_key,
	f.film_id,
	f.title,
	f.description,
	f.release_year,
	l.name as language,
	l.name as original_language,
	f.rental_duration,
	f.length,
	f.rating,
	f.special_features
FROM film f 
JOIN language l ON f.language_id = l.language_id;

-- Insert data into sales_fact
INSERT INTO sales_fact(
	sales_key,
	date_key,
	customer_key,
	movie_key,
	store_key,
	sales_amount
) SELECT
	p.payment_id as sales_key,
	TO_CHAR(payment_date :: DATE, 'YYYYMMDD')::integer as date_key,
	p.customer_id as customer_key,
	i.film_id as movie_key,
	i.store_id as store_key,
	p.amount as sales_amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id;
