CREATE PROCEDURE ThemSanPham
	@TenSanPham VARCHAR 
AS BEGIN
IF @GiaTien IS NULL
	BEGIN
		PRINT 'Gia tien khong duoc bo trong'
	END
ELSE IF @SoLuong IS NULL
	BEGIN
		PRINT 'So luong khong duoc bo trong'
	END
ELSE
	BEGIN
		INSERT INTO Product(Price, ProductName, 