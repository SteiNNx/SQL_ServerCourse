CREATE TABLE Marketing.PhoneCampaign
(
PhoneCampaignID INT NOT NULL,
ProspectID INT NOT NULL,
FirstAttemptedContact DATETIME NULL,
ContactComments NVARCHAR(MAX) NULL,
InitialContact DATETIME NULL
,ContactOutcomeCode CHAR(1) NULL,
SalesValue DECIMAL(10,2) NULL
);
GO