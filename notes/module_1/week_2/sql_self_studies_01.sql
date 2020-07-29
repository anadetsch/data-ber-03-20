/* 1.Let's join publishers and titles and 
get a count of the number of titles each publisher has published. */

-- Using INNER JOIN
SELECT 
	pub.pub_name,
    COUNT(titles.title_id)		AS Titles
FROM publication.publishers		pub
INNER JOIN publication.titles	titles
ON pub.pub_id = titles.pub_id
GROUP BY pub.pub_name;

-- Using LEFT JOIN
SELECT
	pub.pub_name,
    COUNT(titles.title_id)		AS Titles
FROM publication.publishers		pub 
LEFT JOIN publication.titles	titles
ON pub.pub_id = titles.pub_id
GROUP BY pub.pub_name;

/* 2.What if we wanted to analyze how many units were sold for each title? */

SELECT
	titles.title,
    titles.type,
    titles.price,
	SUM(sales.qty)				AS units_sold
FROM publication.sales			sales
RIGHT JOIN publication.titles	titles
ON sales.title_id = titles.title_id
GROUP BY titles.title, titles.type, titles.price;

/* 3.we wanted to see what employees were assigned to which jobs, 
ensuring that the query returns both employees not assigned to a job and jobs not assigned to any employee */
SELECT *
FROM publication.employee			emp
RIGHT JOIN publication.jobs			job
ON emp.job_id = job.job_id
UNION
SELECT *
FROM publication.employee			emp
LEFT JOIN publication.jobs			job
ON emp.job_id = job.job_id;

/* 4. Build a query to summarize store sales,
including the number of orders, the number of itemsn and the total quantity of units sold. */
SELECT
	stores.stor_name			AS Store,
    COUNT(DISTINCT(ord_num))	AS Orders,
    COUNT(title_id)				AS Items,
    SUM(qty)					AS Qty
FROM publication.sales			sales
INNER JOIN publication.stores	stores
ON sales.stor_id = stores.stor_id
GROUP BY Store;

/* 5.If we wanted to then show the average number of items per order 
and average quantity per item for each store, 
we could do that by embedding this query as a subquery into another query that performs those calculations. */
SELECT
	Store,
    Items/Orders					AS AvgItems,
    Qty/Items						AS AvgQty
FROM (
	SELECT
		stores.stor_name			AS Store,
        COUNT(DISTINCT(ord_num))	AS Orders,
        COUNT(title_id)				AS Items,
        SUM(qty)					AS Qty
    FROM publication.sales			sales
    INNER JOIN publication.stores	stores
    ON sales.stor_id = stores.stor_id
    GROUP BY Store 
) summary;

/* 6.Suppose we wanted to see sales by title for the two stores that averaged more than one item per order. */
SELECT
	Store,
    ord_num							AS OrderNumber,
    ord_date						AS OrderDate,
	title 							AS Title,
    sales.qty						AS Qty,
    price							AS Price,
    type							AS Type
FROM (
	SELECT
		stores.stor_id				AS StoreID,
        stores.stor_name			AS Store,
        COUNT(DISTINCT(ord_num))	AS Orders,
        COUNT(title_id)				AS Items,
        SUM(qty)					AS Qty
    FROM publication.sales			sales
    INNER JOIN publication.stores	stores
	ON sales.stor_id = stores.stor_id
    GROUP BY StoreID, Store
) summary
INNER JOIN publication.sales		sales
ON summary.StoreID = sales.stor_id
INNER JOIN publication.titles		titles
ON sales.title_id = titles.title_id
WHERE Items/Orders > 1;

/* 7.Creating Temp Table */
CREATE TEMPORARY TABLE publication.store_sales_summary
SELECT
	stores.stor_id					AS StoreID,
    stores.stor_name				AS Store,
    COUNT(DISTINCT(ord_num))		AS Orders,
    COUNT(title_id)					AS Items,
    SUM(qty)						AS Qty
FROM publication.sales				sales
INNER JOIN publication.stores		stores
ON sales.stor_id = stores.stor_id
GROUP BY
	StoreID,
    Store;
    
    SELECT *
    FROM publication.store_sales_summary;
    
    /* 8.Now we can replace our subquery with this table in the main query where we retrieved title sales details for stores
    with average items per order greater than 1 */
    SELECT
		Store,
        ord_num									AS OrderNumber,
        ord_date								AS OrderDate,
        title									AS Title,
        sales.qty								AS Qty,
        price									AS Price,
        type									AS Type
    FROM publication.store_sales_summary		summary
    INNER JOIN publication.sales				sales
	ON summary.StoreId = sales.stor_id
    INNER JOIN publication.titles				titles
    ON sales.title_id = titles.title_id
    WHERE Items / Orders > 1;
    
    /* 9. Create a permanent table containing the total number of orders, items sold and quantity sold per store. */
    CREATE TABLE publication.store_sales_summary
    SELECT
		stores.stor_id					AS StoreID,
        stores.stor_name				AS Store,
        COUNT(DISTINCT(ord_num))		AS Orders,
        COUNT(title_id)					AS Items,
        SUM(qty)						AS Qty
    FROM publication.sales			sales
    INNER JOIN publication.stores	stores
    ON stores.stor_id = sales.stor_id
    GROUP BY
		StoreID,
        Store;
        
SELECT *
FROM publication.store_sales_summary;

/* 10.Deleting all stores that sold less than 80 units */
DELETE FROM publication.store_sales_summary
WHERE Qty < 80;

/* 11.Deleting all information but keeping table structure */
DELETE FROM publication.store_sales_summary;

/* 12. Append the info back to the table */
INSERT INTO publication.store_sales_summary
SELECT
	stores.stor_id				AS StoreID,
    stores.stor_name			AS Store,
    COUNT(DISTINCT(ord_num))	AS Orders,
    COUNT(title_id)				AS Items,
    SUM(qty)					AS Qty
FROM publication.sales			sales
INNER JOIN publication.stores	stores
ON stores.stor_id = sales.stor_id
GROUP BY StoreID, Store;

/* 13. Updating data and add 5 to Qty */
UPDATE publication.store_sales_summary
SET Qty = Qty + 5;

/* 14. Add 10 units only to stores that sold less than 100 units */
UPDATE publication.store_sales_summary
SET Qty = Qty + 10
WHERE Qty < 100;