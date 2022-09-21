---- C-11 WEEKLY AGENDA-6 RD&SQL STUDENT

---- 1. List all the cities in the Texas and the numbers of customers in each city.----
SELECT * FROM sale.store
SELECT * FROM sale.customer

SELECT city,COUNT(customer_id) As no_of_customers
		FROM sale.customer
		WHERE [state]='TX' --AND LEFT(city,1)='A'
		GROUP BY city

 
---- 2. List all the cities in the California which has more than 5 customer, by showing the cities which have more customers first.---

SELECT city,COUNT(customer_id) As no_of_customers
FROM sale.customer
WHERE [state]='CA' 
GROUP BY city
HAVING COUNT(customer_id) > 5
ORDER BY no_of_customers DESC


---- 3. List the top 10 most expensive products----
SELECT TOP 10 *
FROM product.product
ORDER BY list_price DESC

---- 4. List store_id, product name and list price and the quantity of the products which are located in the store id 2 and the quantity is greater than 25----
SELECT * FROM product.stock
SELECT * FROM product.product

SELECT A.store_id,B.product_name,B.list_price, A.quantity
FROM product.stock AS A
LEFT JOIN product.product AS B
ON A.product_id=B.product_id
WHERE A.store_id=2 AND A.quantity>25


---- 5. Find the sales order of the customers who lives in Boulder order by order date----
SELECT * FROM sale.orders
SELECT * FROM sale.customer


SELECT A.first_name,A.last_name,A.city,B.order_date
FROM sale.customer AS A
INNER JOIN sale.orders AS B
ON A.customer_id=B.customer_id
WHERE A.city='Boulder'
ORDER BY B.order_date



---- 6. Get the sales by staffs and years using the AVG() aggregate function.
SELECT * FROM sale.order_item
SELECT * FROM sale.orders
SELECT * FROM sale.staff

SELECT C.first_name,C.last_name,YEAR(B.order_date) AS [Year],AVG(A.quantity*(A.list_price-(A.list_price*A.discount))) AS Average_Sale
FROM sale.order_item AS A
LEFT JOIN sale.orders AS B
ON A.order_id=B.order_id
LEFT JOIN sale.staff AS C
ON B.staff_id=C.staff_id
GROUP BY C.first_name,C.last_name,YEAR(B.order_date)
ORDER BY C.first_name,YEAR(B.order_date)


---- 7. What is the sales quantity of product according to the brands and sort them highest-lowest----
SELECT * FROM sale.order_item
SELECT * FROM product.brand
SELECT * FROM product.product

SELECT SUM(A.quantity) AS QT, C.brand_name
FROM sale.order_item AS A
LEFT JOIN product.product AS B
ON A.product_id=B.product_id
LEFT JOIN product.brand AS C
ON B.brand_id=C.brand_id
GROUP BY C.brand_name
ORDER BY QT DESC


---- 8. What are the categories that each brand has?----
SELECT * FROM product.brand
SELECT * FROM product.category
SELECT * FROM product.product


SELECT B.brand_name,C.category_name
FROM product.product AS A
LEFT JOIN product.brand AS B 
ON A.brand_id=B.brand_id
LEFT JOIN product.category AS C
ON A.category_id=C.category_id
GROUP BY B.brand_name, C.category_name
ORDER BY B.brand_name DESC


---- 9. Select the avg prices according to brands and categories----



SELECT B.brand_name,C.category_name, AVG(A.list_price) AS Average_price
FROM product.product AS A
LEFT JOIN product.brand AS B 
ON A.brand_id=B.brand_id
LEFT JOIN product.category AS C
ON A.category_id=C.category_id
GROUP BY B.brand_name, C.category_name
ORDER BY B.brand_name DESC, C.category_name DESC


---- 10. Select the annual amount of product produced according to brands----
SELECT * FROM product.stock
SELECT * FROM product.product
SELECT * FROM product.brand

SELECT B.model_year,C.brand_name,SUM(A.quantity)
FROM product.stock AS A
INNER JOIN product.product AS B
ON A.product_id=B.product_id
INNER JOIN product.brand AS C
ON B.brand_id=C.brand_id
GROUP BY model_year, brand_name
ORDER BY C.brand_name,B.model_year


---- 11. Select the store which has the most sales quantity in 2018.----
SELECT * FROM sale.order_item
SELECT * FROM sale.orders
SELECT * FROM sale.store

SELECT TOP 1 SUM(A.quantity) AS QT, C.store_name
FROM sale.order_item AS A
LEFT JOIN sale.orders AS B
ON A.order_id=B.order_id
LEFT JOIN sale.store AS C
ON B.store_id=C.store_id
WHERE YEAR(B.order_date)=2018
GROUP BY C.store_name
ORDER BY QT DESC


---- 12 Select the store which has the most sales amount in 2018.----
SELECT * FROM sale.orders
SELECT * FROM sale.store
SELECT * FROM sale.order_item

SELECT SUM(C.quantity*C.list_price*(1-C.discount)) AS sales_amount, B.store_name
FROM sale.orders AS A
JOIN sale.store AS B
ON A.store_id=B.store_id
JOIN sale.order_item AS C
ON A.order_id=C.order_id
WHERE YEAR(A.order_date)=2018
GROUP BY B.store_name
ORDER BY sales_amount DESC


---- 13. Select the personnel which has the most sales amount in 2019.----
SELECT * FROM sale.orders
SELECT * FROM sale.staff
SELECT * FROM sale.order_item

SELECT TOP 1 SUM(C.quantity*C.list_price*(1-C.discount)) AS sales_amount,B.first_name,B.last_name
FROM sale.orders AS A
JOIN sale.staff AS B
ON A.staff_id=B.staff_id
JOIN sale.order_item AS C
ON A.order_id=C.order_id
GROUP BY B.first_name,B.last_name
ORDER BY sales_amount DESC

