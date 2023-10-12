--drop table sales_data
--truncate sales_data

create table sales_data(
    ORDERNUMBER int,
	QUANTITYORDERED int,
	PRICEEACH float,
	ORDERLINENUMBER int,
	SALES float,
	ORDERDATE date,
	STATUS varchar(50),
	QTR_ID int,
	MONTH_ID int,
	YEAR_ID int,
	PRODUCTLINE varchar(50),
	MSRP int,
	PRODUCTCODE text,
	CUSTOMERNAME varchar(50),
	CITY varchar(50),
	STATE varchar(50),
	COUNTRY varchar(50),
	TERRITORY varchar(50),
	CONTACTLASTNAME varchar(50),
	CONTACTFIRSTNAME varchar(50),
	DEALSIZE varchar(50)
);

copy sales_data
from 'D:\MY-DATA\PROFESSION\SQL\Projects\sales-data-portfolio\sales_data_sample.csv'
ENCODING 'ISO-8859-1'
delimiter ','
csv header;

select * from sales_data