

/*

/* add some fake data 1 */
insert [dbo].[FactInternetSales]
select 
	[ProductKey]*10000, [OrderDateKey], [DueDateKey], [ShipDateKey], [CustomerKey], 
	[PromotionKey], [CurrencyKey], [SalesTerritoryKey], 
	[SalesOrderNumber] + [SalesOrderNumber], [SalesOrderLineNumber], 
	[RevisionNumber], [OrderQuantity], [UnitPrice], [ExtendedAmount], [UnitPriceDiscountPct], [DiscountAmount], 
	[ProductStandardCost], [TotalProductCost], [SalesAmount], [TaxAmt], [Freight], [CarrierTrackingNumber], [CustomerPONumber], 
	[OrderDate], [DueDate], [ShipDate]
from [dbo].[FactInternetSales]
GO

/* add some fake data 2 */
insert [dbo].[FactInternetSales]
select 
	[ProductKey]*2, [OrderDateKey], [DueDateKey], [ShipDateKey], [CustomerKey], 
	[PromotionKey], [CurrencyKey], [SalesTerritoryKey], 
	'x' + [SalesOrderNumber], [SalesOrderLineNumber], 
	[RevisionNumber], [OrderQuantity], [UnitPrice], [ExtendedAmount], [UnitPriceDiscountPct], [DiscountAmount], 
	[ProductStandardCost], [TotalProductCost], [SalesAmount], [TaxAmt], [Freight], [CarrierTrackingNumber], [CustomerPONumber], 
	[OrderDate], [DueDate], [ShipDate]
from [dbo].[FactInternetSales]
GO

select count(1) from [dbo].[FactInternetSales]
go


--> Include Actual Execution Plan <--

--> Compatibility SQL Server 2017 <--
USE [master]
GO
ALTER DATABASE [AdventureWorksDW] SET COMPATIBILITY_LEVEL = 140
GO
USE [AdventureWorksDW]
GO


--> Compatibility SQL Server 2019 <--
USE [master]
GO
ALTER DATABASE [AdventureWorksDW] SET COMPATIBILITY_LEVEL = 150
GO
USE [AdventureWorksDW]
GO
*/

set statistics time on
SELECT [ProductKey],
       SUM([OrderQuantity])                 AS SUM_OrderQTY,
       SUM([UnitPrice])                     AS SUM_BASEPRICE,
       AVG([OrderQuantity])					AS AVG_OrderQTY,
       AVG([UnitPrice])                     AS AVG_BASEPRICE,
       COUNT(*)                             AS COUNT_ORDER
FROM   FactInternetSales
WHERE  [OrderDate]   >= DATEADD(dd, -73, '1998-12-01')
GROUP  BY     [ProductKey]
ORDER  BY     [ProductKey];
set statistics time off
GO



