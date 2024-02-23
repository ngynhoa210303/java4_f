ALTER TRIGGER ThemSanPham
	ON dbo.Product
	AFTER INSERT
AS
BEGIN
	PRINT 'Ban vua them san pham'
	SELECT * FROM inserted
END
GO

INSERT INTO dbo.Product (ProductName,Price,Quantity) VALUES (N'San pham 1',10000,100);
