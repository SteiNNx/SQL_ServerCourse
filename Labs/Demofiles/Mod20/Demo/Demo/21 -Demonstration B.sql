-- Demonstration B

-- Step 1: Open a new query window to the TSQL database
USE TSQL;
GO

-- Step 2: Use System Stored Procedures (not supported on Azure)
-- Execute a stored procedure with no parameters
EXEC sys.sp_databases; 

-- Execute a stored procedure with a single parameters
EXEC sys.sp_help N'Sales.Customers';

-- Execute a stored procedure which accepts
-- multiple parameters
EXEC sys.sp_tables 
	@table_name = '%', 
	@table_owner = 'Sales';

-- Step 3: Return system language information
EXEC sys.sp_helplanguage;

-- Step 4: List stored procedures
-- Note: TSQL db has no user procedures
-- so this will show system procedures only
-- For a result which includes user procedures,
-- Switch to AdventureWorks if available
USE TSQL;
GO
EXEC sys.sp_stored_procedures;

-- Step 5: Optional demo to show filtering by schema
USE AdventureWorks;
GO
EXECUTE sys.sp_stored_procedures @sp_owner='HumanResources';
