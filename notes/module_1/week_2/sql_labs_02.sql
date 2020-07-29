/*
1. From the marketing_qualified_leads table, 
find the earliest and latest first_contact_date.
*/
SELECT
	MAX(DATE(first_contact_date))		AS earliest_contact,
    MIN(DATE(first_contact_date))		AS first_contact
FROM olist.marketing_qualified_leads;

/*
2. From the marketing_qualified_leads table, 
find the top 3 most frequent origin types for all first_contact_date entries in 2018.
*/
SELECT
	origin
FROM olist.marketing_qualified_leads
GROUP BY origin
ORDER BY COUNT(origin) DESC
LIMIT 3;

/*
3. From the marketing_qualified_leads table, 
find the first_contact_date with the highest number of mql_id entries 
and state the number of entries on that date.
*/
SELECT
	first_contact_date,
    COUNT(mql_id)			AS qty_entries
FROM olist.marketing_qualified_leads
GROUP BY DATE(first_contact_date)
ORDER BY qty_entries DESC
LIMIT 1;

/*
4. From the products table, 
find the name and count of the top 2 product category names.
*/
SELECT *
FROM olist.products
LIMIT 10;

SELECT
	product_category_name,
    COUNT(product_category_name)		AS qty
FROM olist.products
GROUP BY product_category_name
ORDER BY qty DESC
LIMIT 2;

/*
5. From the products table, 
find the product_category_name with the highest recorded product weight in grams.
*/
SELECT
	product_category_name,
    product_weight_g
FROM olist.products
ORDER BY product_weight_g DESC
LIMIT 1;

/*
6. From the products table, 
find the product_category_name with the greatest sum of dimensions including length, height and width in centimeters.
*/
SELECT
	product_category_name,
    product_height_cm + product_length_cm + product_width_cm		AS dimensions
FROM olist.products
ORDER BY dimensions DESC
LIMIT 1;

/*
7. From the order_payments table, 
find the payment_type with the greatest number of order_id entries 
and the count of that payment type.
*/
SELECT
	payment_type,
    COUNT(payment_type)		AS qty
FROM olist.order_payments
GROUP BY payment_type
ORDER BY qty DESC
LIMIT 1;

/*
8. From the order_payments table, 
find the highest payment value for an individual order_id.
*/
SELECT
	payment_value
FROM olist.order_payments
ORDER BY payment_value DESC
LIMIT 1;

/*
9. From the sellers table, 
find the 3 seller states with the greatest number of distinct seller cities.
*/
SELECT
	seller_state,
    COUNT(DISTINCT seller_city)	AS qty_city
FROM olist.sellers
GROUP BY seller_state
ORDER BY qty_city DESC
LIMIT 3;

