use clusteredIndex;

--
create table customers (
	customerid int not null primary key identity(1,1),
	customername char(100) not null,
	customeraddress char(100) not null,
	comments char(189) not null
)
go

declare @i int = 1 
while @i<=80000
begin
	insert into customers values(
		'customersname'+ cast(@i as char),
		'customersaddress'+ cast(@i as char),
		'comments'+ cast(@i as char)
	)
	set @i +=1
end

-- select de los regiostros
select * from customers;

-- informmacion fisica de un cluster index
-- con laopcion detail nos retorna por cada nivel
select * from sys.dm_db_index_physical_stats
	(
		DB_ID('clusteredindex'), -- codigo de la base de datos internamente
		OBJECT_ID('customers'), -- obtiene el objeto customer y recupera el id interno de la tabla
		null, -- 
		null, --
		'DETAILED' -- 'SAMPPLE' 'LIMITED' 'DETAILED' -- enforma detallada, toda la hoja y ruta etc...
	)
GO

-- Creamos una tabla de apoyo para ver la informacion del indice 
Create table sp_table_pages
(
	PageFId tinyint,
	PagePId int,
	IamFId tinyint,
	IamPId int,
	ObjectId int,
	IndexId tinyint,
	PartionNumber tinyint,
	PartitionId bigint,
	Iam_chain_type varchar(30),
	PageType tinyint,
	Indexlevel tinyint,
	NextPageFId tinyint,
	NextPagePId int,
	PrevPageFId int,
	PrevPagePId int,
	PRIMARY KEY (PageFId,PagePId)
)
GO


-- Insertamos la informacion de las paginas de indices clustered en la tabla temporal para su mejor analisis
Insert Into sp_table_pages EXEC('DBCC IND(uniqueclusteredindexstructure,customers,1)')
GO


-- Recupero la informacion para su analisis, recupera solo las paginas del indice en este caso 15
-- 14 del nivel intermedio y 1 del Root 

Select * from  sp_table_pages
Where PageType =  2  -- Paginas de tipo 2= Indice,  1 = Data Pages, 10 = iam pages
order by IndexLevel  desc
Go



-- Recupero la informacion para su analisis, recupera solo las paginas de datos (Leaf Level Data)

Select * from  sp_table_pages
Where PageType =  1
order by IndexLevel  desc
Go

-- Visualizamos la pagina root del Indice  (1) 
Select * from  sp_table_pages
Where IndexLevel =  2
Go



--- Queremos recuperar informacion del registro 33333
-- Vamos a visualizar las paginas de indices para lograr ver los contenidos de las paginas de indices 


dbcc traceon (3604)

-- 1 Volcamos la informacion de la pagina root del indice 
dbcc PAGE (uniqueclusteredindexstructure,1,991,3)  -- El pagePid de la consulta anterior que es el root 



-- 2 Volcamos la informacion de la pagina de nivel intemedio del indice 
-- como queremos encontrar el valor 33333 buscamos en la columna customerid key en que rango esta ese valor
-- y escogemos la pagina de la columna ChildPageId para seguir navegando al siguiente nivel 
dbcc PAGE (uniqueclusteredindexstructure,1,2342,3)


-- 3 Volcamos la informacion de la pagina datos  del indice  a nivel de leaf level 
-- mismo proceso anterior 
dbcc PAGE (uniqueclusteredindexstructure,1,2040,1)