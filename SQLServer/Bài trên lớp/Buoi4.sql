DECLARE @soThuNhat INT --int soThuNhat
SET @soThuNhat = 2
DECLARE @soThuHai INT 
SET @soThuHai = 3
DECLARE @tong INT
SET @tong = @soThuNhat + @soThuHai
--SELECT @tong
--PRINT @tong
PRINT CAST(@tong AS VARCHAR) + ' VND'
PRINT CONVERT(VARCHAR, @tong) + ' VND'

PRINT GETDATE() -- lay ra ngay gio thang nam hien tai
PRINT 'Hom nay : ' + CAST(GETDATE() AS VARCHAR)
PRINT 'Hom nay : ' + CONVERT(VARCHAR, GETDATE(), 101) -- Dinh dang ngay thang : 101 --https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/

PRINT DATENAME(DAY, GETDATE()) -- lay ra thanh phan cua ngay thang nam hien tai
PRINT DATENAME(MONTH, GETDATE())
PRINT DATENAME(YEAR, GETDATE())
PRINT DATENAME(HOUR, GETDATE())
PRINT DATENAME(MINUTE, GETDATE())
PRINT DATENAME(WEEK, GETDATE()) -- Tuan trong nam
PRINT DATENAME(WEEKDAY, GETDATE()) -- Thu trong tuan

--Mot so ham tinh toan co ban trong SQL
PRINT SQRT(25) -- can bac 2
PRINT SQUARE(5) -- binh phuong
PRINT ABS(-5) -- tri tuyet doi
PRINT CEILING(2.5) -- lam tron len
PRINT FLOOR(2.5) -- lam tron xuong
PRINT ROUND(2.5, 0) -- lam tron sau dau phay
PRINT ROUND(2.55,1) --
PRINT ROUND(2.5,1)

--Ham cat chuoi
DECLARE @chuoi VARCHAR(100)
SET @chuoi = 'Hello SQL'
PRINT SUBSTRING(@chuoi, 1, 4)
--Ham trong SQL giong ham trong excel
PRINT LEFT(@chuoi, 5)
PRINT RIGHT(@chuoi, 3)

PRINT REPLACE(' Hello      a    b',' ','') -- dung de thay the

DECLARE @chuoi2 VARCHAR(100)
SET @chuoi2 = '         Hello SQL         '
PRINT LEN(@chuoi2) -- tra ve so luong ky tu trong chuoi tinh ca ky tu trang dau chuoi
PRINT LTRIM(@chuoi2) -- xoa khoang trang ben trai
PRINT RTRIM(@chuoi2) -- xoa khoang trang ben phai
PRINT LTRIM(RTRIM(@chuoi2)) -- xoa khoang trang o ca hai ben

PRINT REVERSE('Hello SQL') -- dao nguoc thu tu chuoi
PRINT UPPER('Hello SQL') -- viet hoa het
PRINT LOWER('Hello SQL') -- viet thuong het
