CREATE FUNCTION GetPrice(@ProductId INT)
RETURNS MONEY 
AS
BEGIN
	DECLARE @Price MONEY
	SELECT @Price = Price FROM Product
		WHERE ProductId = @ProductId
	RETURN @Price
END

PRINT dbo.GetPrice(3333)