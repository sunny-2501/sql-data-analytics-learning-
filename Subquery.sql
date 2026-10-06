use [AdventureWorksDW2025]
go

select name from sys.databases

Select * from FactInternetSales
where SalesAmount = (Select Max(SalesAmount) from FactInternetSales)

Select ProductKey, SalesAmount 
From FactInternetSales
where SalesAmount > (Select  AVG(SalesAmount) from FactInternetSales);

--Sales amount having sales greater then Average and min and max sales is also include 
Select ProductKey, SalesAmount,
  (Select AVG(SalesAmount) 
  From FactInternetSales) as AVGSalesAmount,

   (Select MAX(SalesAmount) 
   From FactInternetSales) as MaxSalesAmount,

   (Select MIN(SalesAmount)
   From FactInternetSales) as MINSalesAmount


From FactInternetSales
where SalesAmount >= (Select AVG(SalesAmount) From FactInternetSales);


Select ProductKey   from DimProduct where Color = 'RED';



