CREATE PROCEDURE InsertOrderDetail
	@OrderId INT,
	@ProductId INT,
	@Quantity INT
AS
BEGIN
	INSERT INTO OrderDetail VALUES 
		(@OrderId,@ProductId,@Quantity,dbo.GetPrice(@ProductId))
END
GO

EXEC InsertOrderDetail 3001,3000,99

SELECT * FROM OrderDetail WHERE OrderId = 3001