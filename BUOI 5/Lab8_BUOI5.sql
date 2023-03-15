----------CAU 1---------
CREATE PROC spTangLuong
AS
    UPDATE NHANVIEN SET Luong = Luong * 1.1
GO

EXEC spTangLuong

----------CAU 2---------
ALTER TABLE NHANVIEN
ADD NgayNghiHuu SMALLDATETIME

CREATE PROC spNghiHuu
AS
BEGIN
    UPDATE NHANVIEN
    SET NgayNghiHuu = DATEADD(DAY, 100, GETDATE())
    WHERE (Phai = N'Nam' AND DATEDIFF(YEAR, NgSinh, GETDATE()) >= 60)
    OR (Phai = N'Nữ' AND DATEDIFF(YEAR, NgSinh, GETDATE()) >= 55)
END;

EXEC spNghiHuu

----------CAU 3---------
CREATE PROCEDURE spXemDeAn @DDiemDA NVARCHAR(255)
AS
BEGIN
    SELECT * FROM DeAn
    WHERE DDiemDA = @DDiemDA
END;

EXEC spXemDeAn @DDiemDA = N'Dung Quất';


----------CAU 4---------