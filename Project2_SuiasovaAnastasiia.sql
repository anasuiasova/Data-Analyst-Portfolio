---1

WITH A
AS
(SELECT YEAR (SI.InvoiceDate) AS Year, SUM (SIL.UnitPrice * SIL.Quantity) AS IncomePerYear
    , COUNT (DISTINCT MONTH (SI.InvoiceDate)) AS NumberOfDistinctMonth
FROM Sales.Invoices SI JOIN Sales.InvoiceLines SIL
ON SI.InvoiceID = SIL.InvoiceID
GROUP BY YEAR (SI.InvoiceDate)),
B 
AS
(SELECT Year, IncomePerYear, NumberOfDistinctMonth
    ,CAST(((IncomePerYear / NumberOfDistinctMonth) * 12) AS decimal (18,2)) AS YearleLinearIncome
    ,LAG ((IncomePerYear / NumberOfDistinctMonth) * 12) OVER (ORDER BY Year) AS PYV 
FROM A)
SELECT Year, IncomePerYear, NumberOfDistinctMonth, YearleLinearIncome
    ,CAST(((YearleLinearIncome - PYV)/PYV) * 100 AS decimal(18,2)) AS GrowthRate
FROM B
GO

---2

WITH A 
AS
(SELECT DISTINCT YEAR (SI.InvoiceDate) AS TheYear, DATEPART(QUARTER,SI.InvoiceDate) AS TheQuarter
    ,SC.CustomerName, SUM (SIL.UnitPrice * SIL.Quantity) AS IncomePerYear
FROM Sales.Invoices SI JOIN Sales.InvoiceLines SIL
ON SI.InvoiceID = SIL.InvoiceID
JOIN Sales.Customers SC 
ON SI.CustomerID = SC.CustomerID
GROUP BY YEAR (SI.InvoiceDate), DATEPART(QUARTER,SI.InvoiceDate),SC.CustomerName),
B 
AS
(SELECT TheYear, TheQuarter, CustomerName, IncomePerYear
    , DENSE_RANK () OVER (PARTITION BY TheYear, TheQuarter ORDER BY IncomePerYear DESC) AS DNR
FROM A)
SELECT TheYear, TheQuarter, CustomerName, IncomePerYear, DNR
FROM B
WHERE DNR <=5
GO

--3

SELECT TOP (10) WSI.StockItemID, WSI.StockItemName
    ,SUM(SIL.ExtendedPrice-SIL.TaxAmount) AS TotalProfit
FROM Sales.InvoiceLines SIL JOIN Warehouse.StockItems WSI
ON SIL.StockItemID = WSI.StockItemID
GROUP BY WSI.StockItemID, WSI.StockItemName
ORDER BY SUM(SIL.ExtendedPrice-SIL.TaxAmount) DESC
GO

--4

WITH A 
AS
(SELECT DISTINCT WSI.StockItemID, WSI.StockItemName, WSI.UnitPrice, WSI.RecommendedRetailPrice
    , (WSI.RecommendedRetailPrice - WSI.UnitPrice) AS NominalProductProfit
FROM Warehouse.StockItems WSI JOIN Purchasing.PurchaseOrderLines PPOL
ON WSI.StockItemID = PPOL.StockItemID)
SELECT ROW_NUMBER () OVER (ORDER BY NominalProductProfit DESC) AS Rn, StockItemID, StockItemName, UnitPrice, RecommendedRetailPrice, NominalProductProfit
   , DENSE_RANK () OVER (ORDER BY NominalProductProfit DESC) AS DNR
FROM A
GO

---5

SELECT CONCAT(PS.SupplierID,' - ' + PS.SupplierName) AS SupplierDetails
    , STRING_AGG(CAST(WSI.StockItemID AS varchar(max)) + ' ' + WSI.StockItemName, ' /, ') AS ProductDetails
FROM Purchasing.Suppliers PS JOIN Purchasing.PurchaseOrders PPO
ON PS.SupplierID=PPO.SupplierID
JOIN Purchasing.PurchaseOrderLines PPOL
ON PPO.PurchaseOrderID = PPOL.PurchaseOrderID
JOIN Warehouse.StockItems WSI
ON PPOL.StockItemID = WSI.StockItemID
GROUP BY PS.SupplierID, PS.SupplierName
GO

---6

SELECT TOP (5) SI.CustomerID, AC.CityName, ACO.CountryName, ACO.Continent, ACO.Region
    , SUM(SIL.ExtendedPrice) AS TotalExtendedPrice
FROM Sales.Invoices SI
JOIN Sales.InvoiceLines SIL
  ON SIL.InvoiceID = SI.InvoiceID
JOIN Sales.Customers SC
  ON SC.CustomerID = SI.CustomerID
JOIN Application.Cities AC
  ON AC.CityID = SC.DeliveryCityID
JOIN Application.StateProvinces ASP
  ON ASP.StateProvinceID = AC.StateProvinceID
JOIN Application.Countries ACO
  ON ACO.CountryID = ASP.CountryID
GROUP BY SI.CustomerID, AC.CityName, ACO.CountryName, ACO.Continent, ACO.Region
ORDER BY SUM(SIL.ExtendedPrice) DESC
GO

---7

/*WITH A
AS
(SELECT YEAR(SI.InvoiceDate) AS InvoiceYear
    , MONTH(SI.InvoiceDate) AS InvoiceMonth
    ,SUM(SIL.UnitPrice*SIL.Quantity) AS MonthlyTotal
FROM Sales.Invoices SI JOIN Sales.InvoiceLines SIL 
ON SI.InvoiceID = SIL.InvoiceID
GROUP BY YEAR(SI.InvoiceDate), MONTH(SI.InvoiceDate))
,B AS
(SELECT InvoiceYear, InvoiceMonth, MonthlyTotal
    , SUM(MonthlyTotal) OVER (PARTITION BY InvoiceYear ORDER BY InvoiceMonth) AS CumulativeTotal
FROM A)
SELECT InvoiceYear, InvoiceMonth, MonthlyTotal, CumulativeTotal
FROM B
GO*/

WITH A 
AS 
(SELECT YEAR(SI.InvoiceDate) AS InvoiceYear,
      MONTH(SI.InvoiceDate) AS InvoiceMonth,
      SUM(SIL.UnitPrice*SIL.Quantity) AS MonthlyTotal
  FROM Sales.Invoices SI JOIN Sales.InvoiceLines SIL 
  ON SI.InvoiceID = SIL.InvoiceID
  GROUP BY YEAR(SI.InvoiceDate), MONTH(SI.InvoiceDate)),
B AS 
(SELECT InvoiceYear, InvoiceMonth, MonthlyTotal,
      SUM(MonthlyTotal) OVER (PARTITION BY InvoiceYear ORDER BY InvoiceMonth) AS CumulativeTotal
  FROM A),
C AS 
(SELECT InvoiceYear, CAST(InvoiceMonth AS varchar(2)) AS InvoiceMonth, MonthlyTotal, CumulativeTotal, InvoiceMonth AS SortMonth
  FROM B

  UNION ALL

SELECT InvoiceYear, 'GrandTotal' AS InvoiceMonth, 
    SUM(MonthlyTotal) AS MonthlyTotal,
    SUM(MonthlyTotal) AS CumulativeTotal,
    13 AS SortMonth
  FROM A
  GROUP BY InvoiceYear)
SELECT InvoiceYear, InvoiceMonth, MonthlyTotal, CumulativeTotal
FROM C
ORDER BY InvoiceYear, SortMonth 
GO

---8

WITH A
AS
(SELECT YEAR (SO.OrderDate) AS OrderYear,
    MONTH (SO.OrderDate) AS OrderMonth,
    COUNT (SO.OrderID) AS OrdersCount
FROM Sales.Orders SO 
GROUP BY YEAR (SO.OrderDate), MONTH (SO.OrderDate))
SELECT OrderMonth, 
    ISNULL([2013],0) AS [2013],
    ISNULL([2014],0) AS [2014],
    ISNULL([2015],0) AS [2015],
    ISNULL([2016],0) AS [2016]
FROM A
PIVOT (SUM(OrdersCount) FOR OrderYear IN ([2013],[2014],[2015],[2016])) AS PivotTable
ORDER BY OrderMonth

---9

WITH A 
AS
(SELECT SO.CustomerID, SO.OrderDate, SC.CustomerName, SO.OrderID,
    LAG (SO.OrderDate,1) OVER (PARTITION BY SO.CustomerID ORDER BY SO.OrderDate,SO.OrderID) AS PreviousOrderDate
FROM Sales.Orders SO JOIN Sales.Customers SC
ON SO.CustomerID = SC.CustomerID)
,B AS
(SELECT CustomerID, OrderDate, CustomerName, PreviousOrderDate,
    DATEDIFF(DD,PreviousOrderDate,OrderDate) AS DaysBetweenOrders,
    CAST(ROUND(AVG(CAST(DATEDIFF(DD,PreviousOrderDate,OrderDate) AS float)) OVER (PARTITION BY CustomerID), 0) AS int) AS AvgDaysBetweenOrders,
    MAX(OrderDate) OVER (PARTITION BY CustomerID) AS LastCustOrderDate,
    MAX(OrderDate) OVER () AS LastOrderDateAll,
    DATEDIFF(DD,MAX(OrderDate) OVER (PARTITION BY CustomerID),MAX(OrderDate) OVER ()) AS DaysSinceLastOrder
FROM A)
SELECT CustomerID, CustomerName, OrderDate, PreviousOrderDate, AvgDaysBetweenOrders,
    LastCustOrderDate, LastOrderDateAll ,DaysSinceLastOrder
    ,CASE 
        WHEN DaysSinceLastOrder > AvgDaysBetweenOrders * 2
        THEN 'Potential Churn'
        ELSE 'Active'
    END AS CustomerStatus
FROM B
ORDER BY CustomerID, OrderDate
GO

---10

WITH A AS
(SELECT SCC.CustomerCategoryName,
    CASE
        WHEN SC.CustomerName LIKE 'Tailspin%' THEN 'Tailspin Toys'
        WHEN SC.CustomerName LIKE 'Wingtip%'  THEN 'Wingtip Toys'
        ELSE SC.CustomerName
        END AS NormalizedCustomerName
FROM Sales.Customers AS SC JOIN Sales.CustomerCategories AS SCC
ON SC.CustomerCategoryID = SCC.CustomerCategoryID),
B
AS
(SELECT CustomerCategoryName,
     COUNT(DISTINCT NormalizedCustomerName) AS CustomerCOUNT
    FROM A
    GROUP BY CustomerCategoryName)
SELECT CustomerCategoryName, CustomerCOUNT,
    SUM(CustomerCOUNT) OVER () AS TotalCustCount,
    CONVERT(varchar(20), CAST(100.0 * CustomerCOUNT / SUM(CustomerCOUNT) OVER () AS decimal(6,2))) + '%' AS DistributionFactor
FROM B
ORDER BY CustomerCategoryName
GO