Use CaseStudyIE;

--Drop Procedure
drop procedure sp_CountryWiseTable

--Stored Procedure for CountryWise Audit Table
CREATE PROCEDURE sp_CountryWiseTable
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from CountryWise table
--Select * from CountryWise;

-- Delete all records from CountryWise table
Delete from CountryWise;

--Adding data to CountryWise audit table
Insert Into CountryWise (CountryID, value, FinancialYear, ImportExport)
Select Table2.CountryID, Table1.ExImValue, Table1.FinancialYear, Table1.ImportExport 
FROM stg_countrywise as Table1 join Country as Table2 
ON Table1.Country = Table2.CountryName where ExIMValue is not null;


--Updating FinancialYear and ImportExport values from Master table
Update CountryWise SET 
FinancialYear =(
Case FinancialYear
	When '2017-2018' Then 1
	When '2018-2019' Then 2
	When '2019-2020' Then 3
	When '2020-2021' Then 4
	When '2021-2022' Then 5
	END),
ImportExport =(
Case ImportExport
	When 'Import' Then 6
	When 'Export' Then 7
	END);

END

--Calling the stored procedure
EXEC sp_CountryWiseTable;



--Drop Procedure
drop procedure sp_CommodityWiseTable

--Stored Procedure for CommodityWise Audit Table
CREATE PROCEDURE sp_CommodityWiseTable
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from CommodityWise table
--Select * from CommodityWise;

-- Delete all records from CommodityWise table
Delete from CommodityWise;

--Adding data to CommodityWise audit table
Insert Into CommodityWise (CommodityID, HSCode, Commodity, Value, FinancialYear, ImportExport)
Select T2.CommodityID, T1.HSCode, T1.Commodity, T1.Value, T1.FinancialYear, T1.ImportExport
From STG_CommodityWise as T1 Join Commodity as T2
ON T1.Commodity = T2.CommodityName;

--Alter CommodityWise to trim the trailing spaces
Update CommodityWise SET Commodity = RTRIM(Commodity);

--Updating FinancialYear and ImportExport values from Master table
Update CommodityWise SET 
FinancialYear =(
Case FinancialYear
	When '2017-2018' Then 1
	When '2018-2019' Then 2
	When '2019-2020' Then 3
	When '2020-2021' Then 4
	When '2021-2022' Then 5
	END),
ImportExport =(
Case ImportExport
	When 'Import' Then 6
	When 'Export' Then 7
	END);

END

--Calling the stored procedure
EXEC sp_CommodityWiseTable;



--Drop Procedure
drop procedure sp_CountryWiseAllCommodity;

--Stored Procedure for CountryWiseAllCommodity Audit Table
CREATE PROCEDURE sp_CountryWiseAllCommodity
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from CountryWiseAllCommodity table
--Select * from CountryWiseAllCommodity;

-- Delete all records from CountryWiseAllCommodity table
Delete from CountryWiseAllCommodity;

--Adding data to CountryWiseAllCommodity audit table
Insert Into CountryWiseAllCommodity (CountryID, CommodityID, ExImValue, FinancialYear, ImportExport)
Select Tab2.CountryID, Tab3.CommodityID, ExImValue, FinancialYear, ImportExport
From STG_CountryWiseAllCommodity as Tab1 
Inner Join Commodity as Tab3 ON Tab1.HSCode = Tab3.HSCode
Inner Join Country as Tab2 ON Tab1.CountryName = Tab2.CountryName
where ExImValue is not null;


--Updating FinancialYear and ImportExport values from Master table
Update CountryWiseAllCommodity SET 
FinancialYear =(
Case FinancialYear
	When '2017-2018' Then 1
	When '2018-2019' Then 2
	When '2019-2020' Then 3
	When '2020-2021' Then 4
	When '2021-2022' Then 5
	END),
ImportExport =(
Case ImportExport
	When 'Import' Then 6
	When 'Export' Then 7
	END);



END

--Calling the stored procedure
EXEC sp_CountryWiseAllCommodity;
