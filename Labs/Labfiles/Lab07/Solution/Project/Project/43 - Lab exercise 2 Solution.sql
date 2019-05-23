USE TSQL
GO

UPDATE Sales.Customers
SET contacttitle='Sales Consultant'
WHERE city='Berlin'
AND contacttitle='Sales Representative';