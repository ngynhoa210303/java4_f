CREATE PROCEDURE ThemHoaDon
	@sdtKhachHang VARCHAR(20)
AS
BEGIN
	INSERT INTO [Order] VALUES(GETDATE(),@sdtKhachHang)
END

EXEC dbo.ThemHoaDon '091234566'
SELECT * FROM [Order]
ORDER BY OrderId DESC
EXEC dbo.ThemHoaDon NULL
EXEC dbo.ThemHoaDon '01234'
EXEC dbo.ThemHoaDon '012344658746959645679854'


ALTER PROCEDURE ThemHoaDon
	@sdtKhachHang VARCHAR(20)
AS
BEGIN
	IF @sdtKhachHang IS NULL
		PRINT 'Sdt khach hang khong duoc trong'
	ELSE
		BEGIN
			IF LEN(@sdtKhachHang) >= 9 AND LEN(@sdtKhachHang) <= 12
				BEGIN
					INSERT INTO [Order] VALUES(GETDATE(),@sdtKhachHang)
					PRINT 'Them thanh cong'
				END
			ELSE
				BEGIN
					PRINT 'So dien thoai khong hop le'
				END
		END
END