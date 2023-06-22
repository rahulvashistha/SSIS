--create database CaseStudyIE;

use CaseStudyIE;


--Fact\Staging Table CommodityWise
Create Table STG_CommodityWise(
CW_ID integer identity(1,1),
HSCode nvarchar(2),
Commodity nvarchar(256),
Value    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
FileName    nvarchar(128),
InsertedDate    datetime default getdate(),
UpdatedDate datetime default getdate()
)
--Alter Columns
alter table STG_CommodityWise alter column Commodity nvarchar(512)
 

--Fact\Staging Table CountryWise
Create Table STG_CountryWise(
CW_ID integer identity(1,1),
Country nvarchar(64),    
ExImValue    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
FileName    nvarchar(128),
InsertedDate    datetime default getdate(),
UdpatedDate datetime default getdate()
)
--Alter Columns
alter table STG_CountryWise alter column Country nvarchar(256)

 
--Fact\Staging Table CountryWiseAllCommodity
Create Table STG_CountryWiseAllCommodity(
CWAC_ID integer identity (1,1),
HSCode    nvarchar(2),
Commodity nvarchar(128),
CountryName    nvarchar(64),
ExImValue    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
InsertedDate    datetime default getdate(),
UdpatedDate datetime default getdate()
)
--Alter Columns
alter table STG_CountryWiseAllCommodity alter column Commodity nvarchar(512)
alter table STG_CountryWiseAllCommodity alter column CountryName nvarchar(256)


---ReportingLayer


 --Dimension Table Country
Create Table Country(
CountryID    integer identity(1,1),
CountryName nvarchar(64),
PRIMARY KEY (CountryID)
)
--Alter Columns
alter table Country alter column CountryName nvarchar(256)
 

--Dimension Table Commodity
Create Table Commodity(
CommodityID    integer identity(1,1),
HSCode    nvarchar(2),
CommodityName nvarchar(128),
PRIMARY KEY (CommodityID)
)
--Alter Columns
alter table Commodity alter column CommodityName nvarchar(256)


--Creating Master table for Financial Year and Import Export
--Master Table
Create Table Master(
MID integer identity(1,1),
Value nvarchar(16)
);


--Drop Procedure
drop procedure sp_Master;

--Stored Procedure for Master Table
CREATE PROCEDURE sp_Master
AS
BEGIN
SET NOCOUNT ON;

-- Select all records from Master Table
--Select * from Master;

-- Verify the identity column of Master Table
--DBCC CHECKIDENT ('Master');

-- Delete all records from Master Table
Delete from Master;

-- Reset identity column of Master table to start from 0
DBCC CHECKIDENT ('Master', RESEED, 0);

-- Verify the identity column of Master table
--DBCC CHECKIDENT ('Master');

--Insert Values
Insert into master(Value) Values ('2017-2018'), ('2018-2019'), ('2019-2020'), ('2020-2021'), ('2021-2022'), ('Import'), ('Export');

END

--Calling the stored procedure
EXEC sp_Master;


--Audit\Reporting Table CountryWise
Create Table CountryWise(
CW_ID integer identity(1,1),
CountryID integer, 
Value    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
FileName    nvarchar(128),
InsertedDate    datetime default getdate(),
UdpatedDate datetime default getdate(),
foreign key (CountryID) references Country(CountryID)
)
--Alter Columns
alter table CountryWise drop column FileName;

 
--Audit\Reporting Table CommidtyWise
Create Table CommodityWise(
CW_ID integer identity(1,1),
CommodityID integer,
HSCode nvarchar(2),
Commodity nvarchar(256),
Value    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
FileName    nvarchar(128),
InsertedDate    datetime default getdate(),
UpdatedDate datetime default getdate(),
foreign key (CommodityID) references Commodity(CommodityID)
)
--Alter Columns
alter table CommodityWise drop column FileName;

alter table CommodityWise alter column Commodity nvarchar(512)


 
--Audit\Reporting Table CountryWiseAllCommodity
Create Table CountryWiseAllCommodity(
CWAC_ID integer identity (1,1),
CountryID integer,
CommodityID integer,
ExImValue    numeric(8,2),
FinancialYear    nvarchar(16),
ImportExport    nvarchar(8),
InsertedDate    datetime default getdate(),
UdpatedDate datetime default getdate(),
foreign key (CountryID) references Country(CountryID),
foreign key (CommodityID) references Commodity(CommodityID)
)


--Audit Table
Create Table AuditTable(
FileName varchar(128),
InsertedRow int,
PackageName varchar(128),
TaskName varchar(128),
StartDate datetime,
EndDate datetime
);

--On PreExecute Event
Insert into AuditTable(FileName,StartDate,PackageName,TaskName) values(?,getdate(),?,?);

--On PostExecute Event
Update AuditTable Set [InsertedRow] = ?, [EndDate]=getdate()
WHERE [FileName] = ?;