CREATE TRIGGER XoaHoaDon
	ON [Order]
	INSTEAD OF DELETE
AS
BEGIN
	DECLARE @hoaDonCanXoa INT
	SELECT @hoaDonCanXoa = OrderId FROM deleted
	DELETE FROM OrderDetail WHERE OrderId = @hoaDonCanXoa
	DELETE FROM [Order] WHERE OrderId = @hoaDonCanXoa
END