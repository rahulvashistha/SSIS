use CaseStudyIE;

--Creating Views for PowerBI
CREATE VIEW CommodityWiseView AS
Select a.[CommodityID],b.[HSCode],b.[Commodity],b.[Value],b.[FinancialYear],b.[ImportExport],b.[InsertedDate],b.[UpdatedDate] 
From [dbo].[Commodity] a join [dbo].[CommodityWise] b 
On a.[CommodityID]=b.[CommodityID];


CREATE VIEW CountryWiseView AS
Select a.[CountryID],a.[CountryName],b.[Value],b.[FinancialYear],b.[ImportExport],b.[InsertedDate],b.[UdpatedDate]
From [dbo].[Country] a
Join [dbo].[CountryWise] b
ON a.[CountryID]=b.[CountryID]

CREATE VIEW CountryWiseAllCommodityView AS
Select a.CountryID,a.[CountryName],c.CommodityID,c.CommodityName,b.ExImValue,b.FinancialYear,b.ImportExport
From [dbo].[Country] a
Join [dbo].[STG_CountryWiseAllCommodity] b 
ON a.CountryName=b.CountryName
Join [dbo].[Commodity] c 
ON c.HSCode = b.HSCode
