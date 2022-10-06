


SELECT product_id,SUM(quantity)
FROM product.stock
GROUP BY product_id
ORDER BY 1;



SELECT *,
	SUM(quantity) OVER (PARTITION BY product_id) TOTAL_QUANTÝTY
FROM product.stock

SELECT DISTINCT product_id,
	SUM(quantity) OVER (PARTITION BY product_id) TOTAL_QUANTÝTY
FROM product.stock


SELECT *,
	AVG(list_price) OVER (PARTITION BY brand_id)
FROM product.product 



SELECT	category_id, product_id,
		COUNT(*) OVER() NOTHING,
		COUNT(*) OVER(PARTITION BY category_id) countofprod_by_cat,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id) countofprod_by_cat_2,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) whole_rows,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) specified_columns_1,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) specified_columns_2
FROM	product.product
ORDER BY category_id, product_id




--WHAT is price the cheapest product in every category

SELECT DISTINCT category_id,
	MIN(list_price) OVER (PARTITION BY category_id) 
FROM product.product
ORDER BY category_id,list_price

-- How many different product in the product table?
SELECT DISTINCT COUNT(*) OVER ()
FROM product.product

-- How many different product in the order_item table?
SELECT COUNT 
(
SELECT  DISTINCT product_id
FROM sale.order_item
)


-- Write a query that returns how many products are in each order?

SELECT DISTINCT order_id,
	SUM(quantity) OVER (PARTITION BY order_id) AS cnt_product
FROM sale.order_item


------ How many different product are in each brand in each category

SELECT DISTINCT category_id,brand_id, COUNT (product_id) OVER (PARTITION BY category_id,brand_id)
FROM product.product;





SELECT *
FROM product.stock
ORDER BY store_id, quantity DESC


SELECT DISTINCT store_id,
	FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC)
FROM product.stock;



SELECT *,
	FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW )
FROM product.stock;


--Write a query that returns customers and their most valuable order with total amount of it.
WITH CTE AS
(
SELECT B.customer_id,A.order_id,
	SUM(A.quantity*A.list_price*(1-A.discount)) my_order
FROM sale.order_item A, sale.orders B
WHERE A.order_id=B.order_id
GROUP BY B.customer_id,A.order_id
)
SELECT DISTINCT customer_id, 
	FIRST_VALUE(order_id) OVER(PARTITION BY customer_id ORDER BY my_order DESC),
	FIRST_VALUE(my_order) OVER(PARTITION BY customer_id ORDER BY my_order DESC)
FROM CTE
ORDER BY customer_id


---Write a query that returns first order date by month
SELECT DISTINCT YEAR(order_date) AS Year, MONTH(order_date) AS Month,
FIRST_VALUE(order_date) OVER (PARTITION BY YEAR(order_date), MONTH(order_date) ORDER BY order_date)
FROM sale.orders;



-- 

SELECT DISTINCT *,
	FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC),
	LAST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM product.stock;

---


--Write a query that returns the order date of the one previous sale of each staff (use the LAG function)
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_order_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
--Write a query that returns the order date of the one next sale of each staff (use the lead function)
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LEAD (order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) next_order_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id




--Assign an ordinal number to the product prices for each category in ascending order

SELECT category_id, list_price,
   row_number() over (PARTITION BY category_id ORDER BY category_id) AS row_num
from product.product


SELECT category_id, list_price,
   row_number() over (PARTITION BY category_id ORDER BY category_id) AS row_num,
   RANK() over (PARTITION BY category_id ORDER BY list_price) AS rnk,
   DENSE_RANK() over (PARTITION BY category_id ORDER BY list_price) AS drnk
from product.product


--Write a query that returns both of the followings:
--Average product price.
--The average product price of orders.

SELECT DISTINCT order_id,
AVG(list_price) OVER() AS avg_price,
AVG(list_price) OVER(PARTITION BY order_id) AS avg_price_by_order
FROM sale.order_item



--Calculate the stores' weekly cumulative number of orders for 2018
SELECT DISTINCT A.store_id,A.store_name, DATEPART(WEEK,order_date) AS week_of_year,
COUNT(order_id) OVER (PARTITION BY A.store_id,DATEPART(WEEK,order_date)) CNT_ORDER,
COUNT(order_id) OVER (PARTITION BY A.store_id ORDER BY DATEPART(WEEK,order_date)) CUM_ORD_CNT
FROM sale.store A, sale.orders B
WHERE A.store_id=B.store_id
AND YEAR(B.order_date)=2018


--Calculate 7-day moving average of the number of products sold between '2018-03-12' and '2018-04-12'

WITH CTE AS
(
SELECT DISTINCT B.order_date,
SUM(A.quantity) OVER (PARTITION BY B.order_date) as Sum_quantity

FROM sale.order_item A, sale.orders B
WHERE A.order_id=B.order_id
AND B.order_date >= '2018-03-12' 
AND B.order_date<='2018-04-12'
)
SELECT *,
AVG(Sum_quantity) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as sales_moving_average_7
FROM CTE



--Write a query using the window function that returns staffs' first name, last name, and their total net amount of orders in descending order.

SELECT DISTINCT A.first_name,A.last_name,
SUM(C.quantity*C.list_price*(1-C.discount)) OVER (PARTITION BY A.staff_id ) AS sum_amount
FROM sale.staff A, sale.orders B, sale.order_item C
WHERE A.staff_id=B.staff_id
AND B.order_id=C.order_id
ORDER BY sum_amount DESC;


--List the employee's first order dates by month in 2020. Expected columns are: 
--first name, last name, month and the first order date. (last name and month in ascending order)


SELECT DISTINCT A.first_name,A.last_name, MONTH(B.order_date),
FIRST_VALUE (B.order_date) OVER (PARTITION BY  A.staff_id, MONTH(B.order_date) ORDER BY B.order_date)
FROM sale.staff A, sale.orders B
WHERE A.staff_id=B.staff_id
AND YEAR(B.order_date)=2020
ORDER BY A.last_name,MONTH(B.order_date)



--Write a query using the window function that returns the cumulative total turnovers of the Burkes Outlet by order date between "2019-04-01" and "2019-04-30".

--Columns that should be listed are: 'order_date' in ascending order and 'Cumulative_Total_Price'.

SELECT DISTINCT B.order_date,
--SUM(A.quantity*A.list_price) OVER (PARTITION BY B.order_date ) AS sum_amount,
SUM(A.quantity*A.list_price) OVER (ORDER BY B.order_date) AS CUM
FROM sale.order_item A, sale.orders B,sale.store C
WHERE A.order_id=B.order_id
AND B.store_id=C.store_id
AND C.store_name='Burkes Outlet'
AND B.order_date BETWEEN '2019-04-01' AND '2019-04-30'















