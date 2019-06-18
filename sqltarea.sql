---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
---------------------------------------------------------------------

WITH OrderRows AS
(
	SELECT 
		orderid, 
		orderdate,
		ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rowno,
		val
	FROM Sales.OrderValues
)
SELECT 
	o.orderid,
	o.orderdate,
	o.val,
	o2.val as prevval,
	o.val - o2.val as diffprev
FROM OrderRows AS o
LEFT OUTER JOIN OrderRows AS o2 ON o.rowno = o2.rowno + 1;


---------------------------------------------------------------------
-- Task 2
---------------------------------------------------------------------

SELECT 
	orderid, 
	orderdate,
	val,
	LAG(val) OVER (ORDER BY orderdate, orderid) AS prevval,
	val - LAG(val) OVER (ORDER BY orderdate, orderid) AS diffprev
FROM Sales.OrderValues;



---------------------------------------------------------------------
-- Task 3
---------------------------------------------------------------------
WITH SalesMonth2007 AS
(
	SELECT
		MONTH(orderdate) AS monthno,
		SUM(val) AS val
	FROM Sales.OrderValues
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY MONTH(orderdate)
)
SELECT
	monthno,
	val,
	(
	LAG(val, 1, 0) 
		OVER (ORDER BY monthno) +
	LAG(val, 2, 0) 
		OVER (ORDER BY monthno) + 
	LAG(val, 3, 0) 
		OVER (ORDER BY monthno)) / 3 AS avglast3months,
	val - FIRST_VALUE(val) 
		OVER (ORDER BY monthno ROWS UNBOUNDED PRECEDING) AS diffjanuary,
	LEAD(val) 
		OVER (ORDER BY monthno) AS nextval
FROM SalesMonth2007;


-- listar las diferencias deventas de kane jhon por mes entre el año 2006 y 2007
-- custid=20

WITH SalesTest AS
(
	/*select ord.*,cu.contactname from Sales.OrderValues ord 
	inner join Sales.Customers cu 
		on(ord.custid=cu.custid) 
		where ord.custid=20
			and orderdate >= '20060101' AND orderdate < '20070101'*/
	select 
		MONTH(orderdate) AS mes,
		YEAR(orderdate) AS anno,
		SUM(VAL) as val
	from Sales.OrderValues ord 
	inner join Sales.Customers cu 
		on(ord.custid=cu.custid) 
		where ord.custid=20
			and orderdate >= '20060101' AND orderdate < '20070101'
		GROUP BY MONTH(orderdate),YEAR(orderdate)

)
select
 mes,
 val
 from SalesTest;