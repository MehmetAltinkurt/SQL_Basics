



--RDB&SQL_ASSÝGNMENT_1 F4526-MEHMET


--DROP DATABASE ChocolateFactory
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Manufacturer')
  BEGIN
    CREATE DATABASE Manufacturer
    END



USE Manufacturer

--CREATE SCHEMA man;


CREATE TABLE [Product](
	[prod_id] INT PRIMARY KEY NOT NULL,
	[prod_name] VARCHAR(50) NULL,
	[quantity] INT NULL,
	);


CREATE TABLE [Component](
	[comp_id] INT PRIMARY KEY NOT NULL,
	[comp_name] VARCHAR(50) NULL,
	[description] VARCHAR(50) NULL,
	[quantity_comp] INT NULL,
	);

CREATE TABLE [Supplier](
	[supp_id] INT PRIMARY KEY NOT NULL,
	[supp_name] VARCHAR(50) NULL,
	[supp_location] VARCHAR(50) NULL,
	[supp_country] VARCHAR(50) NULL,
	[is_active] bit NULL,
	);


CREATE TABLE [Prod_Comp](
	prod_id int not null FOREIGN KEY REFERENCES Product(prod_id),
	comp_id int not null FOREIGN KEY REFERENCES Component(comp_id),
	quantity_comp int not null
	Constraint PK_Prod_Comp PRIMARY KEY (prod_id, comp_id)
	);


CREATE TABLE [Comp_Supp](
	comp_id int not null FOREIGN KEY REFERENCES Component(comp_id),
	supp_id int not null FOREIGN KEY REFERENCES Supplier(supp_id),
	order_date date null,
	quantity_comp int not null
	Constraint PK_Comp_Supp PRIMARY KEY ( comp_id,supp_id)
	);
