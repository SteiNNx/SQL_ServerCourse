CREATE TABLE Marketing.Opportunity
(
OpportunityID INT NOT NULL,
ProspectID INT NOT NULL,
SalesStageCode CHAR(2) NOT NULL,
DateRaised DATETIME NOT NULL,
Likelihood TINYINT NOT NULL,
Rating CHAR(1) NOT NULL,
EstimatedClosingDate DATE NOT NULL,
EstimatedRevenue DECIMAL(10,2) NOT NULL,
DeliveryAddress NVARCHAR(MAX) NOT NULL
);
GO