

--Find if there is any duplicate product id in the product tabel
SELECT product_name, COUNT(1) AS cnt_prod_id
FROM product.product
GROUP BY product_name
HAVING COUNT(1)>1



--Write a query that returns category ids with a maximum list price above 4000 or a minimum list price below 500.

SELECT category_id, MAX(list_price) AS max_price, MIN(list_price) AS min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price)>4000 OR MIN(list_price)<3




--Find the average product prices of the brands.
--As a result of the query, the average prices should be displayed in descending order.
SELECT B.brand_name, AVG(list_price) AS avg_price
FROM product.product A
JOIN product.brand B
ON A.brand_id=B.brand_id
GROUP BY B.brand_name
HAVING AVG(list_price)>1000
ORDER BY AVG(list_price) DESC



--Write a query that returns the net price paid by the customer for each order. (Don't neglect discounts and quantities)
SELECT order_id, SUM(list_price*(1-discount)*quantity)
FROM sale.order_item
GROUP BY order_id



-- Orders per state per month
SELECT A.state,YEAR(B.order_date) AS YEARS,MONTH(B.order_date) AS month, COUNT(1) AS NUM_OF_ORDERS
FROM sale.customer A
RIGHT JOIN sale.orders B
ON B.customer_id=A.customer_id
GROUP BY A.state,YEAR(B.order_date),MONTH(B.order_date)
ORDER BY YEARS,state


--SUMMARY TABLE
SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year,
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary
FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year

SELECT Brand,Category,SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY 
		GROUPING SETS (
					(Brand),
					(Category),
					(),
					(Brand,Category)
					)
ORDER BY 1

-------------

--GROUPING SETS
SELECT Brand,Category,SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY 
		GROUPING SETS (
					(Brand),
					(Category),
					(),
					(Brand,Category)
					)
ORDER BY 1

-----



--ROLLUP
SELECT Brand,Category,SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY 
		ROLLUP (
					Brand,Category
					)
ORDER BY 2


--CUBE

SELECT Brand,Category,SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY 
		CUBE (
					Brand,Category
					)
ORDER BY 2









