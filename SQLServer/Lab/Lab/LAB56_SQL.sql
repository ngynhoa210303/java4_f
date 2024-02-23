USE LAB12
GO
--------------Bang User--------------

--Insert
CREATE PROCEDURE InsertUser
	@userName		VARCHAR(50),
	@password		VARCHAR(20),
	@email			VARCHAR(20),
	@fullName		NVARCHAR(50),
	@address		NVARCHAR(MAX),
	@gender			BIT,
	@dateOfBirth	DATE
AS
BEGIN
	IF @userName IS NULL 
		BEGIN
			PRINT 'User khong duoc null'
		END
	ELSE IF @fullName IS NULL 
		BEGIN
			PRINT 'FullName khong duoc null'
		END
	ELSE IF @password IS NULL
		BEGIN
			PRINT 'PassWord khong duoc null'
		END
	ELSE IF @email IS NULL
		BEGIN
			PRINT 'Email khong duoc null'
		END
	ELSE IF @gender NOT IN (0,1)
		BEGIN
			PRINT 'Gender khong hop le'
		END
	ELSE IF (DATEDIFF(DAY,@DateOfBirth,GETDATE()) <0)
		BEGIN
			PRINT N'DateOfBirth khong hop le'
		END
	ELSE IF EXISTS (SELECT UserName FROM [User] WHERE UserName = @userName)
		BEGIN
			PRINT 'Username da ton tai'
		END
	ELSE
		BEGIN
			INSERT INTO [User] VALUES (@userName,@password,@email,@fullName,@address,@gender,@dateOfBirth);
			PRINT 'INSERT du lieu thanh cong'
		END
END
EXEC InsertUser 'Huongnt1','huongnt1234','huongnt@gmail.com',N'Nguyen Thi Huong',N'Ha Noi',1,'2003-08-29'
EXEC InsertUser 'Hoangnh','hoangnh1234','hoangnh@gmail.com',N'Nguyen Huy Hoang',N'Hung Yen',0,'2023-07-06'
EXEC InsertUser  NULL ,'hoangnh1234','hoangnh@gmail.com',N'Nguyen Huy Hoang',N'Hung Yen',0,'2023-07-06'
SELECT * FROM [User]
DROP PROCEDURE InsertUser

--Update
CREATE PROCEDURE UpdateUser
	@userName		VARCHAR(50),
	@password		VARCHAR(20),
	@email			VARCHAR(20),
	@fullName		NVARCHAR(50),
	@address		NVARCHAR(MAX),
	@gender			BIT,
	@dateOfBirth	DATE
AS
BEGIN
	IF @userName IS NULL 
		BEGIN
			PRINT 'User khong duoc null'
		END
	ELSE IF @fullName IS NULL 
		BEGIN
			PRINT 'FullName khong duoc null'
		END
	ELSE IF @password IS NULL
		BEGIN
			PRINT 'PassWord khong duoc null'
		END
	ELSE IF @email IS NULL
		BEGIN
			PRINT 'Email khong duoc null'
		END
	ELSE IF @gender NOT IN (0,1)
		BEGIN
			PRINT 'Gender khong hop le'
		END
	ELSE IF (DATEDIFF(DAY,@DateOfBirth,GETDATE()) <0)
		BEGIN
			PRINT N'DateOfBirth khong hop le'
		END
	ELSE IF NOT EXISTS (SELECT UserName FROM [User] WHERE UserName = @userName)
		BEGIN
			PRINT 'Username khong ton tai'
		END
	ELSE
		BEGIN
			UPDATE [User] SET [Password] = @password, Email = @email, FullName = @fullName, 
		    [Address] = @address, Gender = @gender, DateOfBirth = @dateOfBirth
			WHERE UserName = @userName
			PRINT 'Update thanh cong'
		END
END
GO
EXEC UpdateUser  @userName = 'Dungnt', @password = '12345' , @email = 'anh@gmail.com' ,
	 @fullName =  N'Le Thi Van Anh' , @address = N'Ha Nam', @gender = 0 , @dateOfBirth = '2003-11-23'
SELECT * FROM [User]
DROP PROCEDURE UpdateUser

--Delete
CREATE PROCEDURE DeleteUser
	@userName		VARCHAR(50)
AS
BEGIN
	IF @userName IS NULL 
		BEGIN
			PRINT 'User khong duoc null'
		END
	ELSE IF NOT EXISTS (SELECT UserName FROM [User] WHERE UserName = @userName)
		BEGIN
			PRINT 'Username khong ton tai'
		END
	ELSE 
		BEGIN
			PRINT 'Xoa thanh cong'
			DELETE FROM [User] WHERE UserName = @userName
		END	
END
GO
EXEC DeleteUser 'Vanlt'
DROP PROCEDURE DeleteUser

--------------Bang Product--------------

--Insert
CREATE PROCEDURE InsertProduct
	@carName	    NVARCHAR(50),
	@description	NVARCHAR(MAX),
	@quantity		INT,
	@currentPrice	MONEY,
	@lenght         INT,    
	@mass			INT,	
	@categoryId		INT
AS
BEGIN
	IF @carName IS NULL 
		BEGIN
			PRINT 'CarName khong duoc null'
		END
	ELSE IF @quantity IS NULL 
		BEGIN
			PRINT 'Quantity khong duoc null'
		END
	ELSE IF @currentPrice IS NULL 
		BEGIN
			PRINT 'CurrentPrice khong duoc null'
		END
	ELSE IF @categoryId IS NULL
		BEGIN
			PRINT 'CategoryId khong duoc null'
		END
	ELSE IF @quantity < 0
		BEGIN
			PRINT 'Quantity khong duoc am'
		END
	ELSE IF @currentPrice < 0
		BEGIN
			PRINT 'CurentPrice khong duoc am'
		END
	ELSE IF NOT EXISTS (SELECT CategoryId FROM Car WHERE CategoryId = @categoryId)
		BEGIN
			PRINT 'CategoryId khong hop le'
		END
	ELSE
		BEGIN				
			INSERT INTO Car VALUES (@carName,@description,@quantity,@currentPrice,@lenght,@mass,@categoryId);
			PRINT 'INSERT du lieu thanh cong'
		END	
END
GO
EXEC InsertProduct N'Toyota' ,Null,7,900000000,3700,1400,1
EXEC InsertProduct N'Suzuki' ,Null,5,800000000,3500,1700,5
EXEC InsertProduct Null ,Null,5,800000000,3500,1700,5
SELECT * FROM Car
DROP PROCEDURE InsertProduct

--Update
CREATE PROCEDURE UpdateProduct
	@carId          INT,
	@carName	    NVARCHAR(50),
	@description	NVARCHAR(MAX),
	@quantity		INT,
	@currentPrice	MONEY,
	@lenght         INT,    
	@mass			INT,	
	@categoryId		INT
AS
BEGIN
	IF @carName IS NULL 
		BEGIN
			PRINT 'CarName khong duoc null'
		END
	ELSE IF @carId IS NULL
		BEGIN
			PRINT 'CarId khong duoc null'
		END
	ELSE IF @quantity IS NULL 
		BEGIN
			PRINT 'Quantity khong duoc null'
		END
	ELSE IF @currentPrice IS NULL 
		BEGIN
			PRINT 'CurrentPrice khong duoc null'
		END
	ELSE IF @categoryId IS NULL
		BEGIN
			PRINT 'CategoryId khong duoc null'
		END
	ELSE IF @quantity < 0
		BEGIN
			PRINT 'Quantity khong duoc am'
		END
	ELSE IF @currentPrice < 0
		BEGIN
			PRINT 'CurentPrice khong duoc am'
		END
	ELSE IF NOT EXISTS (SELECT CarId FROM Car WHERE CarId = @carId)
		BEGIN
			PRINT 'CarId khong ton tai'
		END
	ELSE IF NOT EXISTS (SELECT CategoryId FROM Car WHERE CategoryId = @categoryId)
		BEGIN
			PRINT 'CategoryId khong hop le'
		END
	ELSE
	BEGIN
		PRINT 'Update thanh cong'
		UPDATE Car SET CarName = @carName, [Description] = @description, Quantity = @quantity, CurrentPrice = @currentPrice,
		Lenght = @lenght, Mass = @mass, CategoryId = @categoryId
		WHERE CarId = @carId
	END
END
GO
EXEC UpdateProduct @carId = 3, @carName = N'Honda', @description = NULL, 
     @quantity = 1, @currentPrice = 600000000, @lenght = 3450, @mass = 1500, @categoryId = 5
SELECT * FROM Car
DROP PROCEDURE UpdateProduct

--Delete
CREATE PROCEDURE DeleteProduct
	@carId		INT
AS
BEGIN
	IF @carId IS NULL 
		BEGIN
			PRINT 'CarId khong duoc null'
		END
	ELSE IF NOT EXISTS (SELECT CarId FROM Car WHERE CarId = @carId)
		BEGIN
			PRINT 'CarId khong ton tai'
		END
	ELSE
		BEGIN
			PRINT 'Xoa thanh cong'
			DELETE FROM Car WHERE CarId = @carId
		END
END
GO
EXEC DeleteProduct 3
SELECT * FROM Car
DROP PROCEDURE DeleteProduct

--------------Bang OrderDetail--------------

--Insert
CREATE PROCEDURE InsertOrderDetail
	@orderId INT,
	@carId INT,
	@quantity INT
AS
BEGIN
	DECLARE @check BIT
		SET @check=0

	DECLARE @Price MONEY
		SELECT @Price= CurrentPrice FROM Car
		WHERE @carId=CarId

	DECLARE @CheckOrderId INT
		SELECT @CheckOrderId = OrderID FROM OrderDetail
		WHERE @OrderID = OrderID

	DECLARE @CheckQuantity INT
		SELECT @CheckQuantity = Quantity FROM Car
		WHERE @carId = CarId

	IF @OrderID IS NULL
		BEGIN
			PRINT N'OrderId khong duoc null'
			SET @check = 1
		END

	ELSE IF @carId IS NULL
		BEGIN 
			PRINT N'CarId khong duoc null'
			SET @check = 1
		END

	ELSE IF @Quantity is null
		BEGIN
			PRINT N'Quantity khong duoc null'
			SET @check = 1
		END

	ELSE IF NOT EXISTS (SELECT OrderID FROM OrderDetail WHERE @orderId = OrderId)
		BEGIN
			PRINT N'OrderId khong hop le'
			SET @check = 1
		END
	
	ELSE IF NOT EXISTS (SELECT CarId FROM Car WHERE @carId = CarId)
		BEGIN
			PRINT N'CarId khong hop le'
			SET @check = 1
		END
	ELSE IF @Quantity < 0
		BEGIN
			PRINT  N'Quantity khong duoc am'
			SET @check = 1
		END
	ELSE IF @Quantity > @CheckQuantity
		BEGIN
			PRINT N'Hang trong kho khong du'
			SET @check = 1
		END

	ELSE IF @OrderId = @CheckOrderId AND @carId = ANY (SELECT CarId FROM OrderDetail WHERE @OrderID = OrderID)
		BEGIN
			PRINT N'ID nay da ton tai'
			SET @check = 1
		END
	ELSE IF @check = 1
		BEGIN
			PRINT  N'Them that bai'
		END
	ELSE
		BEGIN
			INSERT INTO OrderDetail
				VALUES (@OrderID, @carId, @Quantity, @Price)
			PRINT N'Them thanh cong'
		END	
END

EXEC InsertOrderDetail null, null, null
EXEC InsertOrderDetail 1, 9, 2
EXEC InsertOrderDetail 1, 744, 2
EXEC InsertOrderDetail 6, 7, 6
SELECT * FROM OrderDetail
SELECT * FROM Car
DROP PROCEDURE InsertOrderDetail

--Update
CREATE PROCEDURE UpdateOrderDetail
	@orderId INT,
	@carId INT,
	@quantity INT
AS
BEGIN
	DECLARE @check BIT
		SET @check=0

	DECLARE @Price MONEY
		SELECT @Price= CurrentPrice FROM Car
		WHERE @carId=CarId

	DECLARE @CheckOrderId INT
		SELECT @CheckOrderId = OrderID FROM OrderDetail
		WHERE @OrderID = OrderID

	DECLARE @CheckQuantity INT
		SELECT @CheckQuantity = Quantity FROM Car
		WHERE @carId = CarId

	DECLARE @CheckDiff INT
		SELECT @CheckDiff = Quantity FROM OrderDetail 
		WHERE @carId = CarId AND @OrderId = OrderID
	IF @OrderID IS NULL
		BEGIN
			PRINT N'OrderId khong duoc null'
			SET @check = 1
		END

	ELSE IF @carId IS NULL
		BEGIN 
			PRINT N'CarId khong duoc null'
			SET @check = 1
		END

	ELSE IF @Quantity is null
		BEGIN
			PRINT N'Quantity khong duoc null'
			SET @check = 1
		END

	ELSE IF NOT EXISTS (SELECT OrderID FROM OrderDetail WHERE @orderId = OrderId)
		BEGIN
			PRINT N'OrderId khong hop le'
			SET @check = 1
		END
	
	ELSE IF NOT EXISTS (SELECT CarId FROM Car WHERE @carId = CarId)
		BEGIN
			PRINT N'CarId khong hop le'
			SET @check = 1
		END
	ELSE IF @Quantity < 0
		BEGIN
			PRINT  N'Quantity khong duoc am'
			SET @check = 1
		END
	ELSE IF @Quantity > @CheckQuantity
		BEGIN
			PRINT N'Hang trong kho khong du'
			SET @check = 1
		END

	ELSE IF @OrderId = @CheckOrderId AND @carId = ANY (SELECT CarId FROM OrderDetail WHERE @OrderID = OrderID)
		BEGIN
			PRINT N'ID nay da ton tai'
			SET @check = 1
		END
	ELSE IF @check = 1
		BEGIN
			PRINT  N'Sua that bai'
		END
	ELSE
		BEGIN
			UPDATE OrderDetail 
				SET Quantity = @Quantity
				WHERE @carId = CarId AND @OrderId = OrderId
			IF @Quantity > @CheckDiff
				BEGIN
					UPDATE Car
						SET Quantity = Quantity-(@Quantity-@CheckDiff)
						WHERE @carId = CarId
				END
			ELSE
				BEGIN
					UPDATE Car
						SET Quantity = Quantity+(@CheckDiff-@Quantity)
						WHERE @carId = CarId
				END
			PRINT N'Sua thanh cong'
		END		
END
EXEC UpdateOrderDetail 1, 5, 4
EXEC UpdateOrderDetail null, null, null
EXEC UpdateOrderDetail 5, 7, 3000000
EXEC UpdateOrderDetail 5, 7, null
SELECT * FROM OrderDetail
SELECT * FROM Car
DROP PROCEDURE UpdateOrderDetail

--Delete
CREATE PROCEDURE DeleteOrderDetail
	@OrderId INT
AS
BEGIN
	IF @OrderId IS NULL
		PRINT 'OrderID khong duoc null'
	ELSE IF NOT EXISTS (SELECT OrderId FROM [Order] WHERE OrderId = @OrderId)
		BEGIN
			PRINT 'Khong ton tai'
		END
	ELSE
		BEGIN
			PRINT 'Xoa thanh cong'
			DELETE FROM OrderDetail
				WHERE OrderID = @OrderId
			DELETE FROM [Order]
				WHERE OrderID = @OrderId
		END
END

EXEC DeleteOrderDetail 2
DROP PROCEDURE DeleteOrderDetail




