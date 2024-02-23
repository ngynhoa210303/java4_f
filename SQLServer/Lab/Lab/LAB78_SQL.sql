USE LAB12
GO
--Cau 1
--a
CREATE TRIGGER UpdateOrder
	ON [Order]
	INSTEAD OF UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.CreatedDate > GETDATE())
		BEGIN
			PRINT'Ngay khong duoc lon hon ngay hien tai'
			ROLLBACK TRANSACTION
		END
END	
UPDATE [Order] SET CreatedDate = '2022-06-08' WHERE OrderId = 1

--Cau 2
CREATE TRIGGER DeleteOrder
	ON [Order]
	FOR DELETE
AS
BEGIN
	DECLARE @hoaDonCanXoa INT
	SELECT @hoaDonCanXoa = OrderId FROM deleted
	DELETE FROM OrderDetail WHERE OrderId = @hoaDonCanXoa
	DELETE FROM [Order] WHERE OrderId = @hoaDonCanXoa
	PRINT 'Xoa thanh cong'
END

BEGIN TRANSACTION 
DELETE FROM [Order] WHERE OrderId = 2
SELECT * FROM OrderDetail
ROLLBACK TRANSACTION

--Cau 3
--a
CREATE TRIGGER UpdateOrderDetail
	ON OrderDetail
	INSTEAD OF UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.Quantity <= 0)
		BEGIN
			PRINT'Quantity phai lon hon 0'
			ROLLBACK TRANSACTION
		END
END
UPDATE OrderDetail SET Quantity = 1 WHERE OrderId = 2
--b
CREATE TRIGGER InsertOrderDetail
	ON OrderDetail
	INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.Quantity <= 0)
		BEGIN
			PRINT'Quantity phai lon hon 0'
			ROLLBACK TRANSACTION
		END
END

INSERT INTO OrderDetail VALUES (2,3,1,550000000)

--Cau 4

--aI+bI
CREATE TRIGGER InsertCar
	ON Car
	INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.Quantity < 0)
		BEGIN
			PRINT'Quantity khong duoc am'
			ROLLBACK TRANSACTION
		END
	IF EXISTS (SELECT * FROM inserted WHERE inserted.CurrentPrice < 0)
		BEGIN
			PRINT'CurrentPrice khong duoc am'
			ROLLBACK TRANSACTION
		END
END
INSERT INTO Car VALUES(N'Toyota' ,Null,1,700000000,3300,1400,1)
--aII+bII
CREATE TRIGGER UpdateCar
	ON Car
	INSTEAD OF UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.Quantity < 0)
		BEGIN
			PRINT'Quantity khong duoc am'
			ROLLBACK TRANSACTION
		END
	IF EXISTS (SELECT * FROM inserted WHERE inserted.CurrentPrice < 0)
		BEGIN
			PRINT'CurrentPrice khong duoc am'
			ROLLBACK TRANSACTION
		END
END
UPDATE Car SET Quantity = 1, CurrentPrice = 2 WHERE CarId = 1

--Cau 5 + Cau 1b
ALTER TRIGGER OrderTrigger
	ON [Order]
	FOR INSERT
AS
BEGIN
	DECLARE @gender INT
	DECLARE @name VARCHAR(50)
	SELECT @name = inserted.UserName FROM inserted
	SELECT @gender = Gender FROM [User] WHERE UserName = @name

	DECLARE @thu VARCHAR(50)
	DECLARE @date DATE
	SELECT @date = inserted.CreatedDate FROM inserted
	SET @thu = DATENAME(WEEKDAY, @date)
	IF EXISTS (SELECT * FROM inserted WHERE inserted.CreatedDate > GETDATE())
		BEGIN
			PRINT'Ngay khong duoc lon hon ngay hien tai'
			ROLLBACK TRANSACTION
		END
	IF @thu IN ('Monday', 'Wednesday' , 'Friday') AND @gender = 0
		BEGIN
			PRINT 'Nam khong duoc mua hang vao thu 2,4,6'
			ROLLBACK TRANSACTION
		END
	IF @thu IN ('Tuesday', 'Thursday', 'Saturday') AND @gender = 1
		BEGIN
			PRINT 'Nu khong duoc mua hang vao thu 3,5,7'
			ROLLBACK TRANSACTION
		END
END
INSERT INTO [Order] VALUES ('2022-06-08','Dungnt')
INSERT INTO [Order] VALUES ('2022-06-05','Namtd')
DROP TRIGGER OrderTrigger
SELECT * FROM [Order]

