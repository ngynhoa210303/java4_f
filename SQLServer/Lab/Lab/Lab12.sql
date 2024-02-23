CREATE DATABASE LAB12
GO
USE LAB12
GO

--Tao bang
CREATE TABLE [User](

	UserName		VARCHAR(50)	NOT NULL,
	[Password]		VARCHAR(20) NOT NULL,
	Email			VARCHAR(20) NOT NULL,
	FullName		NVARCHAR(50) NOT NULL,
	[Address]		NVARCHAR(MAX),
	Gender			BIT,
	DateOfBirth		Date
);
GO

CREATE TABLE Category(
	CategoryId		INT IDENTITY(1,1) NOT NULL,
	CategoryName	NVARCHAR(50) NOT NULL	
);
GO

CREATE TABLE Car(
	CarId		    INT IDENTITY(1,1) NOT NULL,
	CarName	        NVARCHAR(50)	NOT NULL,
	[Description]	NVARCHAR(MAX),
	Quantity		INT				NOT NULL,
	CurrentPrice	MONEY		    NOT NULL,
	[Lenght]        INT,    
	Mass			INT,	
	CategoryId		INT				NOT NULL 
);
GO

CREATE TABLE [Order](
	OrderId			INT IDENTITY(1,1) NOT NULL,
	CreatedDate		DATE		NOT NULL,
	UserName		VARCHAR(50) NOT NULL
);
GO

CREATE TABLE OrderDetail(
	OrderId			INT NOT NULL, 	
	CarId		    INT NOT NULL,
	Quantity			INT NOT NULL,
	Price			MONEY NOT NULL
);
GO

--Khóa chính
ALTER TABLE [User] ADD CONSTRAINT PRI_User PRIMARY KEY (UserName);
ALTER TABLE Category ADD CONSTRAINT PRI_Category PRIMARY KEY (CategoryId);
ALTER TABLE Car ADD CONSTRAINT PRI_Car PRIMARY KEY (CarId);
ALTER TABLE [Order] ADD CONSTRAINT PRI_Order PRIMARY KEY (OrderId);
ALTER TABLE OrderDetail ADD CONSTRAINT PRI_OrderDetail PRIMARY KEY (OrderId, CarId);

--Khóa ngoai
ALTER TABLE Car ADD CONSTRAINT FK_Car_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE;
ALTER TABLE [Order] ADD CONSTRAINT FK_Order_User FOREIGN KEY (UserName) REFERENCES [User](UserName) ON DELETE CASCADE;
ALTER TABLE OrderDetail ADD CONSTRAINT FK_OrderDetail_Car FOREIGN KEY (CarId) REFERENCES Car(CarId) ON DELETE CASCADE;
ALTER TABLE OrderDetail ADD CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderId) REFERENCES [Order](OrderId) ON DELETE CASCADE;

--Insert du lieu
INSERT INTO [User] VALUES('Dungnt','dungnt1234','dungnt@gmail.com',N'Nguyen Thi Dung',N'Ha Nam',1,'2003-08-24'),
						 ('Vanlt','vanlt1234','vanlt@gmail.com',N'Le Thi Van',N'Ha Noi',1,'2003-11-23'),
						 ('Thinhnv','thinhnv1234','thinhnv@gmail.com',N'Nguyen Van Thinh',N'Bac Ninh',0,'1999-07-25'),
						 ('Namtd','namtd1234','namtd@gmail.com',N'Tran Duc Nam',N'Vinh Phuc',0,'1998-05-27');

INSERT INTO [Order]VALUES ('2022-05-12','Dungnt'),
						  ('2022-05-16','Dungnt'),
						  ('2022-05-11','Thinhnv'),
						  ('2022-05-10','Dungnt'),
						  ('2022-05-9','Namtd'),
						  ('2022-05-12','Vanlt');

INSERT INTO Category VALUES(N'Xe mui tran'),
						   (N'Xe the thao'),
						   (N'Xe khach'),
						   (N'Xe bus'),
						   (N'Xe du lich'),
						   (N'Xe Tai');

INSERT INTO Car VALUES(N'Toyota' ,Null,10,700000000,3300,1400,1),
					  (N'Honda' ,Null,1,500000000,3400,1800,1),
					  (N'Hyundai' ,Null,5,550000000,3600,1350,2),
					  (N'Suzuki' ,Null,10,750000000,3800,1760,5),
					  (N'Lexus' ,Null,3,1000000000,4100,1560,3),
                      (N'Mazda' ,Null,4,850000000,4200,1700,4),
					  (N'Mercedes Benz' ,Null,10,1500000000,3500,1450,1),
					  (N'Audi' ,Null,10,50000000,3100,1680,6),
					  (N'Lamborghini' ,Null,10,3000000000,3700,1800,2),
					  (N'Vinfast' ,Null,10,950000000,3900,1790,4),
					  (N'Ford' ,Null,10,650000000,4300,1670,5);

INSERT INTO OrderDetail VALUES (2,3,1,550000000),
							   (2,2,1,500000000),
							   (1,3,5,550000000),
							   (3,5,3,1000000000),
							   (6,4,10,750000000),
							   (5,6,4,850000000),
							   (4,8,10,50000000),
							   (2,7,10,1500000000),
							   (5,9,10,3000000000),
							   (6,11,10,650000000),
							   (1,10,10,950000000),
							   (3,4,10,750000000),
							   (5,2,1,500000000),
							   (3,3,5,550000000),
							   (4,7,10,1500000000),
							   (1,8,10,50000000),
							   (2,10,10,950000000),
							   (5,3,5,550000000),
							   (1,6,4,850000000),
							   (1,2,1,500000000);

SELECT * FROM [User]
SELECT * FROM Category
SELECT * FROM Car
SELECT * FROM [Order]
SELECT * FROM OrderDetail