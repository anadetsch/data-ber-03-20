/*
1. From the order_items table, 
find the price of the highest priced order item and lowest price order item
*/

SELECT
	MAX(price)		AS most_expensive,
    MIN(price)		AS less_expensive
FROM olist.order_items;

/*
2. From the order_items table, 
what is range of the shipping_limit_date of the orders?
*/
SELECT
	MAX(shipping_limit_date),
    MIN(shipping_limit_date)
FROM olist.order_items;

/*
3. From the customers table, 
find the 3 states with the greatest number of customers.
*/
SELECT
	customer_state,
    COUNT(customer_state)		AS no_customer_state
FROM olist.customers
GROUP BY customer_state
ORDER BY no_customer_state DESC
LIMIT 3;

/*
4. From the customers table, 
within the state with the greatest number of customers, 
find the 3 cities with the greatest number of customers.
*/
SELECT
    COUNT(customer_city)	AS no_customer_city,
    customer_city
FROM olist.customers
WHERE customer_state = 'SP'
GROUP BY customer_city
ORDER BY no_customer_city DESC
LIMIT 3;

/*
5. From the closed_deals table, 
how many distinct business segments are there (not including null)?
*/
SELECT
	COUNT(DISTINCT(business_segment))		AS qty_dis_seg
FROM olist.closed_deals
LIMIT 10;

/*
6. From the closed_deals table, 
sum the declared_monthly_revenue for duplicate row values in business_segment and 
find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
*/

SELECT
	SUM(declared_monthly_revenue)		AS sum_declared_rev,
    business_segment
FROM olist.closed_deals
GROUP BY business_segment
ORDER BY	sum_declared_rev DESC
LIMIT 3;

/*
7. From the order_reviews table, 
find the total number of distinct review score values.
*/
SELECT
	COUNT(DISTINCT(review_score))		AS total_review_values
FROM olist.order_reviews;

/*
8. In the order_reviews table, 
create a new column with a description that corresponds to each number category 
for each review score from 1 - 5.
*/
SELECT *,
	CASE
		WHEN review_score = '1' THEN 'very low'
        WHEN review_score = '2' THEN 'low'
        WHEN review_score = '3' THEN 'middle'
        WHEN review_score = '4' THEN 'good'
        WHEN review_score = '5' THEN 'very good'
        ELSE 'undefined'
	END											AS review_score_definition
FROM olist.order_reviews;

/*
9. From the order_reviews table, 
find the review score occurring most frequently and how many times it occurs.
*/
SELECT
	review_score,
    COUNT(*)		AS qty_reviews
FROM olist.order_reviews
GROUP BY review_score
ORDER BY qty_reviews DESC
LIMIT 1;