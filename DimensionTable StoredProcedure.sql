use CaseStudyIE;


--Drop Procedure
drop procedure sp_ResetCountryTable;

--Stored Procedure for Country Dimension Table
CREATE PROCEDURE sp_ResetCountryTable
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from Country table
--Select * from Country;

-- Verify the identity column of Country table
--DBCC CHECKIDENT ('Country');

-- Delete all records from Country table
Delete from Country;

-- Reset identity column of Country table to start from 0
DBCC CHECKIDENT ('Country', RESEED, 0);

-- Verify the identity column of Country table
--DBCC CHECKIDENT ('Country');

-- Insert distinct countries from STG_CountryWise into Country table
Insert into Country(CountryName)
Select distinct Country From STG_CountryWise where Country is not null;

--Alter CountryName to trim the leading and trailing spaces
Update Country Set CountryName = LTRIM(RTRIM(CountryName));

END

--Calling the stored procedure
EXEC sp_ResetCountryTable;


--Drop Procedure
drop procedure sp_ResetCommodityTable;

--Stored Procedure for Commodity Dimension Tables
CREATE PROCEDURE sp_ResetCommodityTable
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from Commodity table
--Select * from Commodity;

-- Verify the identity column of Commodity table
--DBCC CHECKIDENT ('Commodity');

-- Delete all records from Commodity table
Delete from Commodity;

-- Reset identity column of Commodity table to start from 0
DBCC CHECKIDENT ('Commodity', RESEED, 0);

-- Verify the identity column of Commodity table
--DBCC CHECKIDENT ('Commodity');

-- Insert distinct Commodities from STG_CommodityWise into Commodity table
Insert into Commodity(CommodityName, HSCode)
Select distinct Commodity, HSCode from STG_CommodityWise where Commodity is not null and HSCode is not null;

--Alter CommodityName to trim the leading and trailing spaces
Update Commodity Set CommodityName = RTRIM(CommodityName);

END

--Calling the stored procedure
EXEC sp_ResetCommodityTable;