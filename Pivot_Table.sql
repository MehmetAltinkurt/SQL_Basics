
--PIVOT TABLE

SELECT *
FROM
(
SELECT	Category, Model_Year, total_sales_price
FROM	sale.sales_summary
) A
PIVOT
(
	SUM(total_sales_price)
	FOR model_year
	IN ([2018], [2019], [2020], [2021])
) as pvt_tbl


----Write a query that returns count of the orders day by day in a pivot table format that has been shipped two days later.


SELECT order_id,DATENAME(DW,order_date) order_weekday
FROM sale.orders
WHERE DATEDIFF(DAY, order_date, shipped_date)>2


SELECT *
FROM(
	SELECT order_id,DATENAME(DW,order_date) order_weekday
	FROM sale.orders
	WHERE DATEDIFF(DAY, order_date, shipped_date)>2
	) A
PIVOT(
	COUNT (order_id)
	FOR order_weekday
	IN ([Sunday],[Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday])
	) AS PVT_TBL




















