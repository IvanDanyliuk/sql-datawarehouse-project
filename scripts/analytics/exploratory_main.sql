/*
=====================================================
----------------- Ranking Analytics -----------------
=====================================================
*/

-- Which 5 products generate the highest revenue?
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

SELECT
	*
FROM (
	SELECT
		p.product_name,
		SUM(f.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
	GROUP BY p.product_name
)t WHERE rank_products <= 5;

-- What are the 5 most worst-performing products in terms of sales?
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue;
