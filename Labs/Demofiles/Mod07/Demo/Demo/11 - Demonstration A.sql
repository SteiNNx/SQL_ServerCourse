-- Demonstration A

-- Step 1: Open a new query window to the TSQL database
USE TSQL;
GO

-- Step 2: Insert a row into the Employees table

INSERT INTO HR.Employees
(
Title,
titleofcourtesy,
FirstName,
Lastname,
hiredate,
birthdate,
address,
city,
country,
phone
)
VALUES
(
'Sales Representative',
'Mr',
'Stephen',
'Rutter',
'05/07/2013',
'09/15/1978',
'4567 2nd Ave. N.E.',
'Seattle',
'USA',
'(206)555-0109'
);
	
-- Step 3: Insert all of the rows from the PotentialCustomers table into the Customers table

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
	
