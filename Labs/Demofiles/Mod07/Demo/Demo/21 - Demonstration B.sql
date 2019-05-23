-- Demonstration B

-- Step 1: Open a new query window to the TSQL database
USE TSQL;
GO

-- Step 2: Update a row in the Employees table

UPDATE HR.Employees
SET title='Sales Manager'
WHERE EmpID=7

-- Step 3: Merge update the Products table

--View products

SELECT * FROM Production.Products

--View ProductsStaging

SELECT * FROM Production.Categories

--Perform Merge Update

MERGE INTO Production.Products as P
	USING Production.ProductsStaging as S
		ON P.ProductID=S.ProductID
WHEN MATCHED THEN
	UPDATE SET
	P.Discontinued=S.Discontinued
WHEN NOT MATCHED THEN
	INSERT (productname,supplierid,categoryid,unitprice,discontinued)
	VALUES (S.productname,S.supplierid,S.categoryid,S.unitprice,S.discontinued);

--View products

SELECT * FROM Production.Products

-- Step 4: Delete a row in the Products table

DELETE Production.PRODUCTS
WHERE ProductID=78

-- Step 5: Truncate the ProductsStaging table

TRUNCATE TABLE Production.ProductsStaging