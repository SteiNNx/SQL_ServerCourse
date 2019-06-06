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

