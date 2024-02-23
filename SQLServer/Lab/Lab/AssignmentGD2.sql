USE ASSIGNMENT
GO
-----CAU 1 
--A
CREATE PROCEDURE InsertOrderDetail
	@orderId INT,
	@carId INT,
	@quantity INT
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
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
			PRINT N'Them thanh cong'
			INSERT INTO OrderDetail VALUES (@OrderID, @carId, @Quantity, @Price)
			UPDATE Car SET Quantity = @CheckQuantity - @quantity WHERE CarId = @carId			
		END
		COMMIT TRANSACTION
			END TRY
				BEGIN CATCH
					PRINT N'Loi truy van du lieu, du lieu tu dong hoan tra'
					ROLLBACK TRANSACTION
				END CATCH
END

--B
CREATE PROCEDURE UpdateCategory
	@CategoryId		INT,
	@CategoryName	NVARCHAR(50)
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
	IF @CategoryId IS NULL
		BEGIN
			PRINT N'CategoryId khong duoc null!'
		END
	ELSE IF @CategoryName IS NULL
		BEGIN
			PRINT N'CategoryName khong duoc null!'
		END
	ELSE IF EXISTS ( SELECT CategoryId FROM Category WHERE CategoryId = @CategoryId)
		BEGIN
			PRINT N'CategoryId khong hop le'
		END
	ELSE
		BEGIN
			PRINT N'Update thanh cong'
			UPDATE Category SET CategoryName = @CategoryName WHERE CategoryId = @CategoryId
		END
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT N'Truy van that bai'
		ROLLBACK TRANSACTION
	END CATCH
END

--C
CREATE PROCEDURE XoaOrder
	@OrderId INT
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
	DECLARE @check BIT
		SET @check=0
	IF NOT EXISTS (SELECT OrderID FROM [Order] WHERE OrderId = @OrderId)
		BEGIN
			PRINT 'OrderId khong hop le'
			SET @check=1
		END
	ELSE IF @OrderId IS NULL
		BEGIN
			PRINT 'OrderId khong duoc null'
		END
	ELSE IF @check=1
		PRINT 'Xoa that bai'
	ELSE
		BEGIN
			DELETE FROM OrderDetail
				WHERE OrderId = @OrderId
			DELETE FROM [Order]
				WHERE OrderId=@OrderId
		END
	COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			PRINT N'Xoa that bai'
			ROLLBACK TRANSACTION
		END CATCH
END

--D
CREATE PROCEDURE TimKiemCar @CategoryId INT
AS
BEGIN
	IF @CategoryId IS NULL
		PRINT N'CategoryId khong duoc de trong'
	ELSE IF NOT EXISTS(SELECT Category.CategoryId FROM Category WHERE CategoryId = @CategoryId)
		PRINT N'Khong co danh muc nay'
	ELSE IF NOT EXISTS (SELECT Car.CategoryId FROM Car WHERE CategoryId = @CategoryId )
		PRINT N'Khong tim thay'
	ELSE
		SELECT * FROM Car WHERE CategoryId = @CategoryId
END
EXEC TimKiemCar 8
SELECT * FROM Car
--Cau 2

--A
CREATE FUNCTION GiaTrietKhau (@Price MONEY)
RETURNS MONEY
AS 
BEGIN
       SET @Price  *=0.13
	   RETURN @Price
END
SELECT Price,dbo.GiaTrietKhau(Price) AS 'Gia triet khau' FROM OrderDetail

--B
CREATE FUNCTION ChuyenDoiGia (@Price MONEY)
RETURNS MONEY
AS 
BEGIN
       DECLARE @ChucTrieu MONEY
	   SET @ChucTrieu = @Price/10000000
	   RETURN @ChucTrieu
END
SELECT Price,CAST(dbo.ChuyenDoiGia(Price) AS NVARCHAR) + N' Chục Triệu' FROM OrderDetail

--Cau 3
CREATE VIEW HienThiOrder 
AS
SELECT  [Order].OrderId ,CreatedDate,UserName,SUM(Price*Quantity) N'Tổng tiền hàng'
	FROM dbo.[Order] JOIN dbo.OrderDetail ON OrderDetail.OrderId = [Order].OrderId
	GROUP BY [Order].OrderId,CreatedDate,UserName

SELECT * FROM HienThiOrder

/* SELECT  [Order].OrderId ,CreatedDate,UserName,SUM(Quantity) 'số lượng',Price,SUM(Price*Quantity) N'Tổng tiền hàng'
	FROM dbo.[Order] JOIN dbo.OrderDetail ON OrderDetail.OrderId = [Order].OrderId
	GROUP BY [Order].OrderId,Quantity,CreatedDate,UserName,Price */

--Cau 4:Tạo View Top 4 sản phẩm bán được nhiều nhất sắp xếp theo giá sản phẩm hiện tại trong ngày
ALTER VIEW HienThiTop4
AS
	SELECT TOP 4 Car.CarId, SUM(OrderDetail.Quantity) AS 'So san pham ban duoc',
	Car.CurrentPrice AS 'Gia hien tai', [Order].CreatedDate FROM Car 
	JOIN OrderDetail ON Car.CarId = OrderDetail.CarId 
	JOIN [Order] ON OrderDetail.OrderId = [Order].OrderId
	WHERE DATENAME(DAY, CreatedDate) = 11  AND DATENAME(YEAR, CreatedDate) = 2022
GROUP BY Car.CarId, Car.CurrentPrice, [Order].CreatedDate
ORDER BY SUM(OrderDetail.Quantity) DESC, Car.CurrentPrice DESC
--AND DATENAME(MONTH, CreatedDate) = 'MAY'
SELECT * FROM HienThiTop4
SELECT * FROM Car
SELECT * FROM OrderDetail


SELECT Car.CarId, SUM(OrderDetail.Quantity) AS 'So san pham ban duoc', Car.CurrentPrice AS 'Gia hien tai' FROM Car 
	JOIN OrderDetail ON Car.CarId = OrderDetail.CarId 
	--JOIN [Order] ON OrderDetail.OrderId = [Order].OrderId
	--WHERE DATENAME(DAY, CreatedDate) = 11 AND DATENAME(MONTH, CreatedDate) = 'MAY' AND DATENAME(YEAR, CreatedDate) = 2022
GROUP BY Car.CarId, Car.CurrentPrice
ORDER BY SUM(OrderDetail.Quantity) DESC, Car.CurrentPrice DESC
--Cau 5
BACKUP DATABASE [ASSIGNMENT] TO  DISK = N'D:\SQL Sever\MSSQL15.SQLEXPRESS\MSSQL\Backup\backupAss.bak' WITH NOFORMAT, NOINIT,  NAME = N'ASSIGNMENT-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--
USE [master]
RESTORE DATABASE [ASSIGNMENT] FROM  DISK = N'D:\SQL Sever\MSSQL15.SQLEXPRESS\MSSQL\Backup\backupAss.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO
--

	   