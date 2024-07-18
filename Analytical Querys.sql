SELECT 
	f.title,
	SUM(p.amount) AS total
FROM payment as p
JOIN rental as r ON p.rental_id = r.rental_id
JOIN inventory as i ON r.inventory_id = i.inventory_id
JOIN film as f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY total DESC, f.title ASC;

SELECT 
	c.city,
	f.title,
	SUM(p.amount) AS total
FROM city as c
JOIN address as ads ON c.city_id = ads.city_id
JOIN customer as cr ON ads.address_id = cr.address_id
JOIN payment as p ON cr.customer_id = p.customer_id
JOIN rental as r ON p.rental_id = r.rental_id
JOIN inventory as i ON i.inventory_id = r.inventory_id
JOIN film as f ON f.film_id = i.film_id
GROUP BY c.city, f.title
ORDER BY total DESC, c.city ASC, f.title ASC;
