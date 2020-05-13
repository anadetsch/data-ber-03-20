CREATE TABLE olist.temp_monthly_kpis AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS month_id,
        DATE_FORMAT(
            DATE_ADD(o.order_purchase_timestamp, INTERVAL 1 MONTH),
            '%Y-%m-01')                                     AS month_id_shifted_m,
        DATE_FORMAT(
            DATE_ADD(o.order_purchase_timestamp, INTERVAL 1 YEAR),
            '%Y-%m-01')                                     AS month_id_shifted_y,
        YEAR(o.order_purchase_timestamp)                    AS year,
        MONTH(o.order_purchase_timestamp)                   AS month,
        c.customer_state,
        COUNT(DISTINCT o.order_id)                          AS orders,
        SUM(oi.price)                                       AS revenue
    FROM olist.order_items oi
        JOIN olist.orders o
        ON oi.order_id = o.order_id
        JOIN olist.customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
        AND o.order_purchase_timestamp >= '2017-01-01'
        AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY 1,2,3,4,5,6
    ORDER BY c.customer_state, 1);
    
SELECT
	mk.month_id,
    mk.year,
    mk.month,
    mk.customer_state,
    mk.orders,
    mk_lm.orders	AS orders_lm,
    mk_ly.orders	AS orders_ly,
    mk.revenue,
    mk_lm.revenue	AS revenue_lm,
    mk_ly.revenue	AS revenue_ly
FROM olist.temp_monthly_kpis mk
	LEFT JOIN olist.temp_monthly_kpis  mk_lm
    ON mk.month_id = mk_lm.month_id_shifted_m
    AND mk.customer_state = mk_lm.customer_state
    LEFT JOIN olist.temp_monthly_kpis mk_ly
    ON mk.month_id = mk_ly.month_id_shifted_y
    AND mk.customer_state = mk_ly.customer_state;
