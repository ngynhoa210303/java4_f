-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER ThemSanPhamVaoHoaDon
   ON  OrderDetail
   AFTER INSERT 
AS 
BEGIN
	DECLARE @soLuongConLai INT
	DECLARE @sanPhamVuaThem INT

	SELECT @sanPhamVuaThem = ProductId 
		FROM inserted
	-- Luong con lai = Luong hien tai - luong da mua
	DECLARE @luongHienTai INT
	DECLARE @luongDaMua INT
	--Luong hien tai lay tu bang san pham
	SELECT @luongHienTai = Quantity
		FROM Product
		WHERE ProductId = @sanPhamVuaThem
	SELECT @luongDaMua = PurchasedQuantity 
		FROM inserted
	SET @soLuongConLai = @luongHienTai - @luongDaMua

	UPDATE Product
		SET Quantity = @soLuongConLai
		WHERE ProductId = @sanPhamVuaThem

END
GO
