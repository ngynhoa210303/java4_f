-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
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
ALTER FUNCTION HienThiCar 
(	
	--@CarId int
	@Min MONEY,
	@Max MONEY
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM Car 
		Where CurrentPrice between @Min And @Max
)
GO

SELECT * FROM HienThiCar(0,500000000000)
