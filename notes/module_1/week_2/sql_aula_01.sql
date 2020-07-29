SELECT *
FROM olist.orders
LIMIT 10;

/*
----------
-- Selecting a sample

-- Clauses:
SELECT
FROM
LIMIT
----------
*/

SELECT *
FROM olist.customers; -- From the data base olist and table customers, give me all the columns

SELECT *
FROM olist.customers
LIMIT 100; -- From the data base olist and table customers, give me all the columns up to 100 rows

SELECT
	customer_id,
    customer_zip_code_prefix,
    customer_state
FROM olist.customers
LIMIT 100; -- From the data base olist and table customers, give me the specified columns up to 100 rows

-- sorting

SELECT *
FROM olist.orders
ORDER BY order_purchase_timestamp DESC
LIMIT 1000;

SELECT
	order_id,
    customer_id,
    order_status,
    order_purchase_timestamp
FROM olist.orders
ORDER BY order_purchase_timestamp DESC
LIMIT 1000;

-- selecting columns

SELECT
	order_id		AS order_identifier,
    customer_id		AS customer_identifier,
    order_status	AS order_status_string
FROM olist.orders
ORDER BY order_purchase_timestamp DESC
LIMIT 1000;

-- selecting rows

-- select only those orders that were place in Feb 2018
SELECT *
FROM olist.orders
WHERE order_purchase_timestamp >= '2018-02-01'
	AND order_purchase_timestamp < '2018-03-01'
LIMIT 1000;

-- only customers from Bahia
SELECT *
FROM olist.customers
WHERE customer_state = 'BA'
LIMIT 100;

-- only customers from Salvador na Bahia
SELECT *
FROM olist.customers
WHERE customer_state = 'BA'
	AND customer_city = 'Salvador'
LIMIT 100;

-- only customers from Salvador, Bahia that have a customer_id that starts with 'a'
SELECT *
FROM olist.customers
WHERE customer_state = 'BA'
	AND customer_city = 'Salvador'
    AND customer_id LIKE 'a%'
LIMIT 100;

SELECT *
FROM olist.customers
WHERE (customer_state = 'BA'
	OR customer_state = 'GO')
    AND customer_id LIKE 'a%'
LIMIT 100;

SELECT *
FROM olist.customers
WHERE customer_state IN ('BA','GO')
    AND customer_id LIKE 'a%'
LIMIT 100;

-- Column Transformations

-- add a new column that states in which price category a product is
SELECT
	order_id,
    product_id,
    price
FROM olist.order_items
LIMIT 1000;

SELECT
	order_id,
    product_id,
    price,
    IF(price < 100, 'cheap', 'expensive')	AS price_category
FROM olist.order_items
LIMIT 1000;

SELECT
	order_id,
    product_id,
    price,
    IF(price < 100, 'cheap', IF(price < 350, 'medium', 'expensive'))	AS price_category
FROM olist.order_items
LIMIT 1000;

-- rewriting as a case statement
SELECT
	order_id,
    product_id,
    price,
    CASE
		WHEN price < 100 THEN 'cheap'
        WHEN price < 350 THEN 'medium'
        ELSE 'expensive'
	END									AS price_category
FROM olist.order_items;

SELECT
	order_id,
    product_id,
    price,
    freight_value,
    price + freight_value	AS total_volume
FROM olist.order_items;

SELECT *
FROM olist.orders
LIMIT 10;

SELECT *
FROM olist.orders
WHERE order_id = 'e69bfb5eb88e0ed6a785585b27e16dbf';

SELECT *
FROM olist.order_items
WHERE order_id = 'e69bfb5eb88e0ed6a785585b27e16dbf';

SELECT *
FROM olist.products
WHERE product_id = '9a78fb9862b10749a117f7fc3c31f051';

SELECT *
FROM olist.product_category_name_translation
WHERE product_category_name = 'moveis_escritorio';

SELECT	
	customer_state,
    customer_id,
    customer_city,
    customer_unique_id
FROM olist.customers
LIMIT 10;

-- Most expensive product:
SELECT
	product_id,
    price
FROM olist.order_items
ORDER BY price DESC
LIMIT 1;

SELECT
	order_id,
    product_id,
    seller_id,
    shipping_limit_date,
    DATE(shipping_limit_date)
FROM olist.order_items
WHERE DATE(shipping_limit_date) = '2017-05-17';

-- deduplicating usisng SELECT DISTINCT
SELECT
	seller_id
FROM olist.order_items
WHERE DATE(shipping_limit_date) = DATE('2017-05-17');

SELECT DISTINCT
	seller_id,
    product_id
FROM olist.order_items
WHERE DATE(shipping_limit_date) = DATE('2017-05-17')
ORDER BY seller_id;

------------

-- aggregate functions

SELECT 
	COUNT(*)					AS no_of_rows,
    COUNT(DISTINCT seller_id)	AS unique_sellers,
    COUNT(DISTINCT product_id)	AS unique_products,
    COUNT(product_id)			AS products,
    COUNT(seller_id)			AS sellers,
    COUNT(1)					AS ones,
    COUNT(0)					AS zeros,
    SUM(1)						AS sum_of_rows,
    AVG(price)					AS mean_price,
    MAX(price)					AS max_price,
    MIN(price)					AS min_price
FROM olist.order_items
WHERE DATE(shipping_limit_date) = DATE('2017-05-17');


-- GROUP BYs
SELECT
	DATE(shipping_limit_date)	AS date_id,
    COUNT(*)					AS order_items
FROM olist.order_items
GROUP BY
	DATE(shipping_limit_date)
ORDER BY 
	DATE(shipping_limit_date)
LIMIT 1000;

SELECT
	DATE(shipping_limit_date)	AS date_id,
    COUNT(*)					AS order_items
FROM olist.order_items
GROUP BY
	DATE(shipping_limit_date)
ORDER BY 
	COUNT(*) DESC
LIMIT 1000;

-- top 10 sellers
/*
| seller_id | no_of_items | total_revenue |
|-----------|-------------|---------------|
|xyz        | 2353        | 12348785      |
| ... 
*/

SELECT
	seller_id,
    COUNT(1)		AS no_of_items,
    SUM(price)		AS total_revenue
FROM olist.order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- top 10 products by quantity
SELECT
	product_id,
    COUNT(*)		AS quantity
FROM olist.order_items
GROUP BY product_id
ORDER BY quantity DESC
LIMIT 10;

-- top 10 products from each seller


-- for each day, how many items did each seller sell?
SELECT
	DATE(shipping_limit_date)		AS date_id,
    seller_id,
    COUNT(*)						AS no_of_items
FROM olist.order_items
GROUP BY
	DATE(shipping_limit_date),
    seller_id
ORDER BY
	seller_id,
    date_id;
    
SELECT
	seller_id,
    COUNT(seller_id)			AS no_of_items,
    COUNT(DISTINCT seller_id)	AS unique_sellers
FROM olist.order_items
GROUP BY seller_id
LIMIT 10;

