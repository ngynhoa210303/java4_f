USE LAB12
GO

-- Cau 1
SELECT [Order].OrderId,UserName, CONVERT(VARCHAR, CreatedDate, 110) AS 'CreatedDate'
FROM [Order]
-- Cau 2
SELECT 
	CarName,(CAST([Lenght] AS VARCHAR) + 'mm') 
	AS 'Lenght',(CAST(Mass AS VARCHAR) + 'kg') 
	AS 'Mass'
FROM Car
-- Cau 3
SELECT CarName, CurrentPrice AS 'Gia chua duoc xu ly',
dbo.F_ToVND(CurrentPrice) AS 'Gia da duoc xu ly'
FROM Car
-- Cau 4
SELECT CurrentPrice AS 'Gia chua duoc xu ly', dbo.F_ToVND(dbo.F_Discount(CEILING(CurrentPrice*27/100))) AS 'Tien sau khi da chiet khau' 
FROM Car
-- Cau 5
SELECT OrderId, CarName, (CAST(OrderDetail.Quatity AS VARCHAR) + 'chiec') AS 'Quantity', dbo.F_ToVND(Price) AS 'Don Gia',
dbo.F_ToVND((OrderDetail.Quatity*Price)*OrderDetail.Quatity) AS 'Thanh Tien',
dbo.F_ToVND(Price*27/100*OrderDetail.Quatity) AS 'Duoc Giam'
FROM Car JOIN OrderDetail ON Car.CarId = OrderDetail.CarId
-- Cau 6
SELECT N'       Text     ' AS 'Chua xu ly',
dbo.F_Trim(N'       Text     ') AS 'Da xu ly'
-- Cau 7
AlTER VIEW ThongTin
AS
SELECT [Order].OrderId, [Order].CreatedDate, [Order].UserName,
dbo.F_ToVND((OrderDetail.Quatity*CurrentPrice)*OrderDetail.Quatity) AS N'Thanh Tien',
dbo.F_ToVND(dbo.F_Discount(CurrentPrice*OrderDetail.Quatity)) AS N'Chiet Khau',
(dbo.F_ToVND(OrderDetail.Quatity*CurrentPrice*OrderDetail.Quatity-CurrentPrice*27/100*OrderDetail.Quatity)) as N'Tong Thanh Toan'
FROM [User] JOIN [Order] ON [User].UserName=[Order].Username
		 JOIN OrderDetail ON [Order].OrderId=OrderDetail.OrderId
		JOIN Car ON Car.CarId=OrderDetail.CarId
SELECT * FROM ThongTin

