use AdventureWorks2014
--vd1
create table Production.parts(
part_id int not null,
part_name nvarchar(100)
)
go

--vd2
create clustered index ix_parts on Production.parts (part_id);

--vd3
exec sp_rename 
	N'Production.parts.ix_parts_id',
	N'index_part_id',
	N'INDEX';

--vd4
alter index ix_parts
on Production.parts
disable;

--vd5
alter index all on Production.parts
disable;

--vd6
drop index if exists index_part_id on Production.parts;

--vd7
create nonclustered index index_customer_storeid
on Sales.Customer(StoreID);

--vd8
create unique index AK_Customer_rowguid
on Sales.Customer(rowguid);

--vd9
create index index_cust_personId on
Sales.Customer(PersonID)
where PersonID is not null;

--vd10
select CustomerID, PersonId, StoreID from Sales.Customer where PersonID = 1700;

--vd11
create partition function partition_function (int) 
range left for values (20200630, 20200731, 20200831);

--vd12
(select 20200613 date, $partition.partition_function()20200613)PartitionNumber)
union
(select 20200713 date, $partition.partition_function()20200713)PartitionNumber)
union
(select 20200813 date, $partition.partition_function()20200813)PartitionNumber)
union
(select 20200913 date, $partition.partition_function()20200913)PartitionNumber);

--vd13
create primary xml index pxml_ProductModel_CatalogDescription
on Production.ProductModel (CatalogDescription);

--vd14
create xml index ixml_ProductModel_CatalogDescription_Path
on Production.ProductModel (CatalogDescription)
using xml index pxml_ProductModel_CatalogDescription
for Path;

--vd15
create columnstore index IX_SalesOrderDetails_ProductIDOrderQty_columnstore on Sales.SalesOrderDetail (ProductID, OrderQty);

--vd16
select ProductID, SUM(OrderQty)
from Sales.SalesOrderDetail
group by ProductID;