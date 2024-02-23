DECLARE @ngay DATE
SET @ngay = '2022-06-05'

DECLARE @thu VARCHAR(10)
SET @thu = DATENAME(WEEKDAY,@ngay)

IF @thu IN ('Saturday', 'Sunday')
	PRINT 'Di choi'
ELSE 
	PRINT 'Di hoc'