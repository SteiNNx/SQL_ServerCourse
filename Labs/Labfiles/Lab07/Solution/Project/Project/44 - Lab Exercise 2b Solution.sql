USE TSQL
GO

DELETE FROM dbo.PotentialCustomers
WHERE contactname IN(
'Taylor, Maurice',
'Mallit, Ken',
'Tiano, Mike');