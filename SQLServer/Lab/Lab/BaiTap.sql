/*Câu 1: Tạo cơ sở dữ liệu QLVT gồm 3 bảng. (1.5 điểm)
VATTU (MaVT, TenVT, DVTinh)
PHIEUXUAT (SoPX, NgayXuat)
CTPXUAT(SoPX, MaVT, SLXuat, DonGia)
Câu 2: Chèn thông tin vào các bảng (3 điểm)
- Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp vào bảng VATTU, PHIEUXUAT, CTPXUAT.
- Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Với các cột không chấp nhận thuộc tính Null.
- Với mỗi SP viết 3 lời gọi thành công.
Câu 3: Viết hàm các tham số đầu vào tương ứng với các cột của bảng VATTU.
Hàm này trả về MaVT thỏa mãn các giá trị được truyền tham số. (2 điểm)
Câu 4: Tạo View lưu thông tin của TOP 2 phiếu xuất có giá trị lớn nhất,
gồm các thông tin sau: MaVT, TenVT, NgayXuat, TenKH, SLXuat, DonGia, “Gia Tri Max”. (1.5 điểm)
Câu 5: Viết một SP nhận một tham số đầu vào là SLXuat.
SP này thực hiện thao tác xóa thông tin vật tư và phiếu xuất tương ứng. (2 điểm)*/

CREATE DATABASE BaiTap1
GO
USE BaiTap1
GO
CREATE TABLE VatTu(
	MaVT VARCHAR(10) NOT NULL,
	TenVT NVARCHAR(50) NOT NULL,
	DVTinh NVARCHAR(50)
);
GO

CREATE TABLE PhieuXuat(
	SoPX INT NOT NULL,
	NgayXuat INT
);
GO

CREATE TABLE CTPXuat(
	SoPX INT NOT NULL,
	MaVT VARCHAR(10) NOT NULL,
	SLXuat INT,
	DonGia INT
);
GO

ALTER TABLE VatTu ADD CONSTRAINT PK1 PRIMARY KEY (MaVT);
ALTER TABLE PhieuXuat ADD CONSTRAINT PK2 PRIMARY KEY (SoPX);
ALTER TABLE CTPXuat ADD CONSTRAINT PK3 PRIMARY KEY (SoPX,MaVT);

ALTER TABLE CTPXuat ADD CONSTRAINT FK1 FOREIGN KEY (SoPX) REFERENCES PhieuXuat(SoPX);
ALTER TABLE CTPXuat ADD CONSTRAINT FK2 FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT);

--Cau 2
CREATE PROCEDURE InserVatTu
	@MaVT VARCHAR(10),
	@TenVT NVARCHAR(50),
	@DVTinh NVARCHAR(50)
AS
BEGIN
	IF @MaVT IS NULL OR @TenVT IS NULL OR @DVTinh IS NULL
		PRINT 'Cac thong tin tren khong duoc null!'
	ELSE IF EXISTS (SELECT MaVT FROM VatTu WHERE MaVT = @MaVT)
		PRINT 'MaVT da ton tai'
	ELSE
		INSERT INTO VatTu VALUES (@MaVT,@TenVT,@DVTinh);
		PRINT 'Insert thanh cong'
END

CREATE PROCEDURE InsertPhieuXuat
	@SoPX INT,
	@NgayXuat INT
AS
BEGIN
	IF @SoPX IS NULL OR @NgayXuat IS NULL
		PRINT 'Cac thong tin tren khong duoc null'
	ELSE IF EXISTS (SELECT SoPX FROM PhieuXuat WHERE SoPX = @SoPX)
		PRINT 'SoPX da ton tai'
	ELSE
		INSERT INTO PhieuXuat VALUES (@SoPX,@NgayXuat);
		PRINT 'Insert thanh cong'
END

CREATE PROCEDURE InsertCTPXuat
	@SoPX INT,
	@MaVT VARCHAR(10),
	@SLXuat INT,
	@DonGia INT
AS
BEGIN
	IF @SoPX IS NULL OR @MaVT IS NULL OR @SLXuat IS NULL OR @DonGia IS NULL
		PRINT 'Cac thong tin tren khong duoc null'
	ELSE IF EXISTS (SELECT MaVT,SoPX FROM CTPXuat WHERE MaVT = @MaVT AND SoPX = @SoPX)
		PRINT 'MaVT,SoPX da ton tai'
	ELSE
		INSERT INTO CTPXuat VALUES (@SoPX,@MaVT,@SLXuat,@DonGia);
		PRINT ' INSERT Thanh cong'
END
--Cau 3
CREATE FUNCTION Cau3(@TenVT NVARCHAR(50), @DVTinh NVARCHAR(50))
RETURNS TABLE
AS
RETURN (SELECT MAVT FROM VatTu WHERE  TenVT = @TenVT AND DVTinh = @DVTinh)
GO

--Câu 4: Tạo View lưu thông tin của TOP 2 phiếu xuất có giá trị lớn nhất, 
--gồm các thông tin sau: MaVT, TenVT, NgayXuat, TenKH, SLXuat, DonGia, “Gia Tri Max”. (1.5 điểm)
CREATE VIEW Top2
AS
SELECT TOP 2 A.MAVT,TENVT,NGAYXUAT,SLXUAT,DONGIA,MAX(DONGIA) AS 'GIA TRI MAX'
FROM VATTU A INNER JOIN CTPXUAT ON CTPXUAT.MAVT = A.MAVT
INNER JOIN PHIEUXUAT ON PHIEUXUAT.SOPX = CTPXUAT.SOPX
GROUP BY A.MAVT,TENVT,NGAYXUAT,SLXUAT,DONGIA
ORDER BY MAX(DONGIA) DESC 
--Cau 5:
CREATE PROCEDURE Cau5
	@SLXuat INT
AS
BEGIN
		DECLARE @VatTu TABLE (MAVT VARCHAR(10), SoPX VARCHAR(10))
		INSERT INTO @VatTu
		SELECT VatTu.MaVT, SLXuat FROM VatTu
		JOIN CTPXuat ON VatTu.MaVT = CTPXuat.MaVT JOIN PhieuXuat ON CTPXuat.SoPX = PhieuXuat.SoPX
		GROUP BY VatTu.MaVT
		DELETE FROM VatTu
		WHERE MaVT IN (SELECT MaVT FROM @VatTu) AND  IN (SELECT SoPX FROM @VatTu)
END