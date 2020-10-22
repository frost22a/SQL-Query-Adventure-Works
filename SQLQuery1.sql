use AdventureWorks2019
go

select
	pp.FirstName
	,pp.LastName
	,ssp.Bonus
from Person.Person as pp join Sales.SalesPerson as ssp on pp.BusinessEntityID = ssp.BusinessEntityID

select 
	pp.Name
	,(sod.UnitPrice * (1 - sod.UnitPriceDiscount)) * sod.OrderQty as 'Value'
from Production.Product as pp join Sales.SalesOrderDetail as sod on pp.ProductID = sod.ProductID
order by pp.Name

select 
	pp.Name
	,sum((sod.UnitPrice * (1 - sod.UnitPriceDiscount)) * sod.OrderQty) as 'Total'
from Production.Product as pp join Sales.SalesOrderDetail as sod on pp.ProductID = sod.ProductID
group by pp.Name
order by pp.Name

select
	ppc.Name
	,pps.Name
from Production.ProductCategory as ppc join Production.ProductSubcategory as pps on ppc.ProductCategoryID = pps.ProductCategoryID
order by ppc.Name

select
	ppc.Name
	,Count(ppc.Name)
from Production.ProductCategory as ppc join Production.ProductSubcategory as pps on ppc.ProductCategoryID = pps.ProductCategoryID
group by ppc.Name
order by ppc.Name

select 
	pp.BusinessEntityID
	,pp.FirstName + ' ' + pp.LastName as 'Employee Name'
	,Count(*)
from  Person.Person as pp join HumanResources.EmployeeDepartmentHistory as hr on hr.BusinessEntityID = pp.BusinessEntityID
group by pp.FirstName + ' ' + pp.LastName, pp.BusinessEntityID
having count(*)>1
order by pp.BusinessEntityID

SELECT 
p.LastName
,p.FirstName
,count(*)
FROM HumanResources.EmployeeDepartmentHistory h
JOIN Person.Person p on p.BusinessEntityID = h.BusinessEntityID
GROUP BY p.LastName, p.FirstName
HAVING count(*) >1

select * from Person.Person 

select * from HumanResources.Employee

select * from HumanResources.EmployeeDepartmentHistory 

select 
	pp.FirstName
	,pp.LastName
	,ppp.PhoneNumber
from Person.Person as pp left join Person.PersonPhone as ppp on pp.BusinessEntityID = ppp.BusinessEntityID 

select 
	pp.Name
	,ppd.DocumentNode
from Production.Product as pp left join Production.ProductDocument as ppd on pp.ProductID = ppd.ProductID
where ppd.DocumentNode is null

SELECT 
m.name
,m.UnitMeasureCode
,CASE
WHEN pSize.SizeUnitMeasureCode IS NOT NULL THEN 'Is used as size'
WHEN pWeight.WeightUnitMeasureCode IS NOT NULL THEN 'Is used as weight'
END as 'Used as'
FROM Production.UnitMeasure m
LEFT JOIN Production.Product pSize ON m.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON m.UnitMeasureCode = pWeight.WeightUnitMeasureCode



select 
	pu.Name
	,pu.UnitMeasureCode
	,pp.SizeUnitMeasureCode
	,pp1.WeightUnitMeasureCode
	,case
	when pp.SizeUnitMeasureCode is not null then 'is used as size'
	when pp1.WeightUnitMeasureCode is not null then 'is used as weight'
	end as 'used as:'
from 
Production.UnitMeasure as pu
left join Production.Product as pp on pu.UnitMeasureCode = pp.SizeUnitMeasureCode
left join Production.Product as pp1 on pu.UnitMeasureCode = pp1.WeightUnitMeasureCode
WHERE pp.SizeUnitMeasureCode IS NULL AND pp1.WeightUnitMeasureCode IS NULL




select * from Production.UnitMeasure

use AdventureWorks2019

select 
	pp.Name
	,ssoh.OrderDate
from Production.Product pp 
join Sales.SalesOrderDetail sso on pp.ProductID = sso.ProductID
join Sales.SalesOrderHeader ssoh on ssoh.SalesOrderID = sso.SalesOrderID

select 
	pp.Name
	,max(ssoh.OrderDate)	
from Production.Product pp 
join Sales.SalesOrderDetail sso on pp.ProductID = sso.ProductID
join Sales.SalesOrderHeader ssoh on ssoh.SalesOrderID = sso.SalesOrderID
group by pp.Name
order by pp.Name

select 
	pp.Name
	,max(ssoh.OrderDate) as 'Date sold'	
from Production.Product pp 
left join Sales.SalesOrderDetail sso on pp.ProductID = sso.ProductID
left join Sales.SalesOrderHeader ssoh on ssoh.SalesOrderID = sso.SalesOrderID
group by pp.Name
order by pp.Name

select 
	pp.FirstName
	,pp.LastName
	,hrs.Name
from Person.Person as pp
join HumanResources.EmployeeDepartmentHistory as hre on hre.BusinessEntityID = pp.BusinessEntityID
join HumanResources.Shift as hrs on hrs.ShiftID = hre.ShiftID

select 
	hr.LoginID
	,hr.SickLeaveHours
from HumanResources.Employee as hr

select 
	AVG(SickLeaveHours)
from HumanResources.Employee 



select 
	hr.LoginID
	,hr.SickLeaveHours
	,(select AVG(SickLeaveHours) from HumanResources.Employee) as 'AvgSickLeaveHours' 
from HumanResources.Employee as hr

select 
	hr.LoginID
	,hr.SickLeaveHours
	,(select AVG(SickLeaveHours) from HumanResources.Employee) as 'AvgSickLeaveHours' 
	,hr.SickLeaveHours - (select AVG(SickLeaveHours) from HumanResources.Employee) as 'SickLeaveDiff'
from HumanResources.Employee as hr

select 
	hr.LoginID
	,hr.SickLeaveHours
	,(select AVG(SickLeaveHours) from HumanResources.Employee) as 'AvgSickLeaveHours' 
	,hr.SickLeaveHours - (select AVG(SickLeaveHours) from HumanResources.Employee) as 'SickLeaveDiff'
from HumanResources.Employee as hr
where hr.SickLeaveHours > (select AVG(SickLeaveHours) from HumanResources.Employee)
order by 'SickLeaveDiff' desc

select 
	pp.ProductID
	,pp.Name as 'ProductName'
	,pps.Name as 'SubcategoryName'
	,ppc.Name as 'CategoryName'
from Production.Product as pp
join Production.ProductSubcategory as pps on pps.ProductSubcategoryID= pp.ProductSubcategoryID
join Production.ProductCategory as ppc on ppc.ProductCategoryID = pps.ProductSubcategoryID

select 
	ssod.LineTotal
from Sales.SalesOrderDetail as ssod

select 
	ppp.ProductID
	,ppp.ProductName 
	,ppp.SubcategoryName 
	,ppp.CategoryName 
	,ssod.LineTotal
from Sales.SalesOrderDetail as ssod
join (select 
	pp.ProductID
	,pp.Name as 'ProductName'
	,pps.Name as 'SubcategoryName'
	,ppc.Name as 'CategoryName'
from Production.Product as pp
join Production.ProductSubcategory as pps on pps.ProductSubcategoryID= pp.ProductSubcategoryID
join Production.ProductCategory as ppc on ppc.ProductCategoryID = pps.ProductSubcategoryID) as ppp on ppp.ProductID = ssod.ProductID

-- lub

select 
	ppp.*
	,ssod.LineTotal
from Sales.SalesOrderDetail as ssod
join (select 
	pp.ProductID
	,pp.Name as 'ProductName'
	,pps.Name as 'SubcategoryName'
	,ppc.Name as 'CategoryName'
from Production.Product as pp
join Production.ProductSubcategory as pps on pps.ProductSubcategoryID= pp.ProductSubcategoryID
join Production.ProductCategory as ppc on ppc.ProductCategoryID = pps.ProductSubcategoryID) as ppp on ppp.ProductID = ssod.ProductID

select 
	ppp.*
	,ssop.ProductID
	,sso.Description
from Sales.SpecialOfferProduct as ssop
join Sales.SpecialOffer as sso on sso.SpecialOfferID = ssop.SpecialOfferID
join (select 
		pp.ProductID
		,pp.Name as 'ProductName'
		,pps.Name as 'SubcategoryName'
		,ppc.Name as 'CategoryName'
	from Production.Product as pp
	join Production.ProductSubcategory as pps on pps.ProductSubcategoryID= pp.ProductSubcategoryID
	join Production.ProductCategory as ppc on ppc.ProductCategoryID = pps.ProductSubcategoryID
) as ppp on ppp.ProductID = ssop.ProductID

-- wyk³ad 89

select
	pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
	,(select COUNT(*) from HumanResources.EmployeeDepartmentHistory as hredh where hredh.BusinessEntityID = pp.BusinessEntityID) 
from HumanResources.Employee as hre 
join Person.Person as pp on pp.BusinessEntityID = hre.BusinessEntityID

select 
	BusinessEntityID
	,COUNT(*) 
from HumanResources.EmployeeDepartmentHistory group by BusinessEntityID

select
	pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
	,(select COUNT(*) from HumanResources.EmployeeDepartmentHistory as hredh where hredh.BusinessEntityID = pp.BusinessEntityID) 
from HumanResources.Employee as hre 
join Person.Person as pp on pp.BusinessEntityID = hre.BusinessEntityID
where (select COUNT(*) from HumanResources.EmployeeDepartmentHistory as hredh where hredh.BusinessEntityID = pp.BusinessEntityID) >1

select 
	* 
from HumanResources.Employee

select
	pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
	,YEAR(hre.HireDate)
from HumanResources.Employee as hre 
join Person.Person as pp on pp.BusinessEntityID = hre.BusinessEntityID
order by pp.BusinessEntityID, pp.FirstName, pp.LastName

select
	pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
	,YEAR(hre.HireDate)
	,(select COUNT(*) from HumanResources.Employee as hre2 where YEAR(hre2.HireDate) = YEAR(hre.HireDate) )
from HumanResources.Employee as hre 
join Person.Person as pp on pp.BusinessEntityID = hre.BusinessEntityID
order by pp.BusinessEntityID, pp.FirstName, pp.LastName


select COUNT(*) from HumanResources.Employee as hre2 group by YEAR(hre2.HireDate)

select
	pp.FirstName
	,pp.LastName
	,ssp.Bonus
	,ssp.SalesQuota
	,ssp.TerritoryID
	,(select AVG(ssp2.Bonus) from Sales.SalesPerson as ssp2 where ssp2.TerritoryID = ssp.TerritoryID) as 'Average bonus on the territory'
	,(select AVG(ssp3.SalesQuota) from Sales.SalesPerson as ssp3 where ssp3.TerritoryID = ssp.TerritoryID) as 'Average Sales Quota on the territory'
from
Sales.SalesPerson as ssp
join Person.Person as pp on pp.BusinessEntityID = ssp.BusinessEntityID

select ssp.TerritoryID, AVG(SalesQuota) from Sales.SalesPerson as ssp group by ssp.TerritoryID

select ssp.TerritoryID, AVG(Bonus) from Sales.SalesPerson as ssp group by ssp.TerritoryID

select 
*
from 
Sales.SalesPerson as ssp
where ssp.SalesQuota < 
(select 
	AVG(ssp1.SalesQuota)
from 
Sales.SalesPerson as ssp1)

select 
	AVG(ssp.SalesQuota)
from 
Sales.SalesPerson as ssp

select 
*
from 
Sales.SalesPerson as ssp

select 
*
from 
Sales.SalesPerson as ssp
where ssp.SalesQuota < 
(select 
	AVG(ssp1.SalesQuota)
from 
Sales.SalesPerson as ssp1 where ssp1.TerritoryID = ssp.TerritoryID)

select 
COUNT(*)
from 
Sales.SalesOrderHeader

--89/11

select 
	YEAR(ssoh.OrderDate) as "YEAR"
	,MONTH(ssoh.OrderDate) as "MONTH"
	,COUNT(*) as "number of orders"
	,(select COUNT(*) from Sales.SalesOrderHeader as ssoh2 where YEAR(ssoh2.OrderDate) = (YEAR(ssoh.OrderDate) - 1) and MONTH(ssoh2.OrderDate) = MONTH(ssoh.OrderDate) ) as 'orders last year'
from 
Sales.SalesOrderHeader as ssoh
group by YEAR(ssoh.OrderDate), MONTH(ssoh.OrderDate)
order by YEAR desc, MONTH desc

--92/1
select 
*
from
Production.UnitMeasure

select 
 pum.UnitMeasureCode
from
Production.UnitMeasure as pum
where
	not exists (select * from Production.Product as pp where pum.UnitMeasureCode = pp.SizeUnitMeasureCode or pum.UnitMeasureCode = pp.WeightUnitMeasureCode)

select 
	pum.UnitMeasureCode
from
Production.UnitMeasure as pum
where
	exists (select * from Production.Product as pp where pum.UnitMeasureCode = pp.SizeUnitMeasureCode or pum.UnitMeasureCode = pp.WeightUnitMeasureCode)

select 
	pp.ListPrice
	,pp.ProductSubcategoryID
from
Production.Product as pp where pp.ProductSubcategoryID = 1

select 
	pp.ListPrice
	,pp.ProductSubcategoryID
from
Production.Product as pp where pp.ProductSubcategoryID = 1
order by pp.ListPrice desc

select 
*
from
Production.Product as pp
where pp.ListPrice > all (select ListPrice from Production.Product as pp1 where pp1.ProductSubcategoryID = 1)

select 
*
from
Production.Product as pp
where pp.ListPrice > any (select ListPrice from Production.Product as pp1 where pp1.ProductSubcategoryID = 1)

--94/1

SELECT 
p.* 
FROM Production.Product p
WHERE
p.Color = (SELECT Color FROM Production.Product WHERE ProductID=322)

select
*
from
Production.Product pp
join Production.Product pp1 on pp.Color = pp1.Color
where pp1.ProductID =322