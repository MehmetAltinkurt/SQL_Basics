--SUBQUERIES

SELECT order_id,list_price,
(SELECT AVG(list_price)
FROM sale.order_item) AS AVG_PRICE
FROM sale.order_item

SELECT *
FROM sale.staff
where staff_id IN(
SELECT store_id
FROM sale.staff
WHERE first_name='David' AND last_name='Thomas')




SELECT *
FROM sale.staff
where manager_id IN
(
SELECT staff_id
FROM sale.staff
WHERE first_name='Charles' AND last_name='Cussona')



SELECT *
FROM sale.staff
WHERE manager_id = (SELECT staff_id
					FROM sale.staff
					WHERE first_name = 'Charles' and last_name = 'Cussona')


SELECT * FROM sale.customer
WHERE city=
(SELECT city
FROM sale.store
WHERE store_name='The BFLO Store' )



select * from product.product

--Write a query that returns the list of products that are more expensive than the product named 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
SELECT *
FROM product.product
WHERE list_price>
(SELECT list_price
FROM product.product
WHERE product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)')


-- Write a query that returns customer first names, last names and order dates.
-- The customers who are order on the same dates as Laurel Goldammer.
SELECT *
FROM sale.orders A,sale.customer B
WHERE A.customer_id=B.customer_id
AND A.order_date IN
(
SELECT A.order_date
FROM sale.orders A,sale.customer B
WHERE A.customer_id=B.customer_id
AND B.first_name='Laurel'
AND B.last_name='Goldammer'
)

--List the products that ordered in the last 10 orders in Buffalo city.
SELECT *
FROM sale.order_item A, product.product B
WHERE order_id IN  
				(
				SELECT TOP 10 order_id
				FROM sale.customer A, sale.orders B
				WHERE A.city='Buffalo'
				AND A.customer_id=B.customer_id
				ORDER BY order_id DESC 
				)
AND A.product_id=B.product_id


--Write a query that returns the list of product names that were made in 2020
--and whose prices are higher than maximum product list price of Receivers Amplifiers category.


--Receivers Amplifiers kategorisindeki en yüksek fiyatlý üründen daha pahalý olan 2020 model ürünleri getiriniz.
SELECT * FROM product.product
SELECT * FROM product.category

SELECT product_name,model_year, list_price
FROM  product.product
WHERE list_price>
(SELECT MAX(A.list_price)
FROM product.product A,product.category B
WHERE B.category_id=A.category_id
AND B.category_name='Receivers Amplifiers'
)
AND model_year=2020





--EXIST
SELECT *
FROM sale.customer
WHERE EXISTS (SELECT 1)


SELECT *
FROM sale.customer A
WHERE EXISTS(
			SELECT 1
			FROM sale.orders B
			WHERE B.order_date>'2020-01-01'
			AND A.customer_id=B.customer_id
			)


