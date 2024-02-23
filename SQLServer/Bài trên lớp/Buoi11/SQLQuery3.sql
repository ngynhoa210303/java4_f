SELECT * FROM OrderDetail
SELECT * FROM Product

INSERT INTO OrderDetail VALUES (1,1,7,10000)

-- DELETE FROM OrderDetail WHERE OrderId = 1
BEGIN TRANSACTION -- Danh dau trang thai hien tai
DELETE FROM [Order] WHERE OrderId = 2
SELECT * FROM OrderDetail
ROLLBACK TRANSACTION -- Quay ve trang thai danh dau
-- COMMIT TRANSACTION -- Luu trang thai thay doi
