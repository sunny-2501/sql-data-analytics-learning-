select ProductKey  , SUM(SalesAmount)  TotalSales 
from [dbo].[FactInternetSales]
Group By ProductKey



---- Copy of the Table 
Select * from DimProduct
go
Select * Into DimProduct_bk From DimProduct
go

Select * from DimProduct_bk
where color = 'Red'
AND 1=2;
go
