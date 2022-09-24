--F4526-Mehmet
/*
1. Product Sales
You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.

1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

To generate this report, you are required to use the appropriate SQL Server Built-in functions or expressions as well as basic SQL knowledge.
*/

SELECT D.customer_id,D.first_name,D.last_name, 
CASE WHEN D.customer_id IN
(SELECT D.customer_id
FROM sale.order_item A
JOIN product.product B
ON A.product_id=B.product_id
JOIN sale.orders C
ON A.order_id=C.order_id
JOIN sale.customer D
ON C.customer_id=D.customer_id
WHERE B.product_name='Polk Audio - 50 W Woofer - Black')
THEN 'YES' ELSE 'NO' END AS Other_Product
FROM sale.order_item A
JOIN product.product B
ON A.product_id=B.product_id
JOIN sale.orders C
ON A.order_id=C.order_id
JOIN sale.customer D
ON C.customer_id=D.customer_id
WHERE B.product_name='2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
ORDER BY D.customer_id

/*
2. Conversion Rate
Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. Write a query to return the conversion rate for each Advertisement type.
*/


CREATE TABLE sale.Actions(
[Visitor_ID] INT PRIMARY KEY IDENTITY (1,1),
[Adv_Type] CHAR(1) NOT NULL,
[Action] NVARCHAR(MAX) NOT NULL	
	);

INSERT INTO sale.Actions ([Adv_Type],[Action]) VALUES
('A','Left'),
('A','Order'),
('B','Left'),
('A','Order'),
('A','Review'),
('A','Left'),
('B','Left'),
('B','Order'),
('B','Review'),
('A','Review')

SELECT Adv_Type,
	((SELECT COUNT(1) 
	FROM sale.Actions B
	WHERE A.Adv_Type=B.Adv_Type
	AND Action='Order'
	GROUP BY Adv_Type)*1.0/
	(SELECT COUNT(1) 
	FROM sale.Actions B
	WHERE A.Adv_Type=B.Adv_Type
	GROUP BY Adv_Type)*1.0)
FROM sale.Actions A
GROUP BY Adv_Type


