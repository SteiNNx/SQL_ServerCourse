USE TSQL

GO

INSERT INTO Sales.Customers
(
companyname,
contactname,
contacttitle,
address,
city,
region,
postalcode,
country,
phone,
fax
)

SELECT * FROM dbo.PotentialCustomers;