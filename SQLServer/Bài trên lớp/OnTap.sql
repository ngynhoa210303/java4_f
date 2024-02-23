SELECT OrderId AS 'Ma hoa don',
	OrderDetail.ProductId AS 'Ma san pham',
	Product.ProductName AS 'Ten san pham',
	OrderDetail.PurchasedQuantity AS 'So luong mua',
	OrderDetail.PurchasedMoney AS 'Don gia mua',
	OrderDetail.PurchasedMoney * OrderDetail.PurchasedQuantity AS 'Thành tiền',
	OrderDetail.PurchasedMoney * OrderDetail.PurchasedQuantity * 0.2 AS 'Chiết Khấu',
	(OrderDetail.PurchasedMoney * OrderDetail.PurchasedQuantity) - (OrderDetail.PurchasedMoney * OrderDetail.PurchasedQuantity * 0.2) AS 'Tien thanh toan',
	Product.Price AS 'Gia hien tai',
	Product.Quantity AS 'So luong hien tai'
	FROM OrderDetail JOIN Product ON OrderDetail.ProductId = Product.ProductId

DECLARE @giaThapNhat MONEY = 1000
DECLARE @giaCaoNhat MONEY = 100000
SELECT * FROM Product WHERE Price BETWEEN @giaThapNhat AND @giaCaoNhat

DECLARE @ten NVARCHAR(MAX) = N'a'
SELECT * FROM Product
	WHERE ProductName LIKE '%' + @ten+ '%'

-- DECLARE @danhmuc INT = 1
-- SELECT * FROM Product WHERE CategoryID = @danhmuc


SELECT CreatedDate AS 'Ngay lap don',
	GETDATE() AS 'Ngay hien tai'
	FROM [Order] WHERE DATENAME(MONTH, CreatedDate) = DATENAME(MONTH, GETDATE())
					AND DATENAME(YEAR, CreatedDate) = DATENAME(YEAR, GETDATE())
