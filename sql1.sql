use clusteredIndex;

create table customers (
	customerid int not null primary key identity(1,1),
	customername char(100) not null,
	customeraddress char(100) not null,
	comments char(189) not null
)
go