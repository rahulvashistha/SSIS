use CaseStudyIE;

--Describe Tables
--exec sp_columns STG_CommodityWise
--exec sp_columns STG_CountryWise
--exec sp_columns STG_CountryWiseAllCommodity


--Stored Procedure for Selection
CREATE PROCEDURE sp_SelectTable
@TableName VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @SQL NVARCHAR(MAX);

SET @SQL = 'Select * from ' + @TableName;

EXEC sp_executesql @SQL;
END

--Calling the Selection stored procedure
EXEC sp_SelectTable 'STG_CommodityWise';
EXEC sp_SelectTable 'STG_CountryWise';
EXEC sp_SelectTable 'STG_CountryWiseAllCommodity';


--Stored Procedure for truncation
CREATE PROCEDURE sp_TruncateTable
@TableName VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @SQL NVARCHAR(MAX);

SET @SQL = 'TRUNCATE TABLE ' + @TableName;

EXEC sp_executesql @SQL;
END

--Calling the truncation stored procedure
EXEC sp_Truncatetable 'STG_CommodityWise';
EXEC sp_Truncatetable 'STG_CountryWise';
EXEC sp_Truncatetable 'STG_CountryWiseAllCommodity';


--Validation for STG_CountryWise
select [Import Total], [Export Total], Table1.FinancialYear from (
select sum(ExImValue) as 'Export Total', FinancialYear from STG_CountryWise where ImportExport='Export' group BY FinancialYear) as Table1 join (
select sum(ExImValue) as 'Import Total', FinancialYear from STG_CountryWise where ImportExport='Import' group BY FinancialYear) as Table2 on Table1.FinancialYear = Table2.FinancialYear

--Validation for STG_CountryWiseAllCommodity
select distinct CountryName, ImportExport from STG_CountryWiseAllCommodity group by ImportExport, CountryName;

--Validation for STG_CommodityWise
select distinct FileName, ImportExport from STG_CommodityWise group by ImportExport, FileName;

