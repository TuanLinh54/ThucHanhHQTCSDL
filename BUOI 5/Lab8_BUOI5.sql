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
    SELECT * FROM DEAN
    WHERE DDiemDA = @DDiemDA
END;

EXEC spXemDeAn @DDiemDA = N'NHẬP TÊN ĐỊA ĐIỂM CẦN XEM';

----------CAU 4---------
CREATE PROCEDURE spCapNhatDeAn @diadiem_cu NVARCHAR(255), @diadiem_moi NVARCHAR(255)
AS
BEGIN
    UPDATE DEAN
    SET DDiemDA = @diadiem_moi
    WHERE DDiemDA = @diadiem_cu
END;

EXEC spCapNhatDeAn @diadiem_cu = N'<địa điểm cũ>', @diadiem_moi = N'<địa điểm mới>';

----------CAU 5---------
CREATE PROCEDURE spThemDeAn
    @MaDeAn INT,
    @TenDeAn NVARCHAR(50),
    @DDiemDA NVARCHAR(255)
AS
BEGIN
    INSERT INTO DEAN (MaDA, TenDA, DDiemDA)
    VALUES (@MaDeAn, @TenDeAn, @DDiemDA)
END

----------CAU 6---------
CREATE PROCEDURE spThemDA
    @MaDeAn INT,
    @TenDeAn NVARCHAR(50),
    @DDiemDA NVARCHAR(255),
    @MaPhongBan INT
AS
BEGIN
    IF EXISTS (SELECT * FROM DEAN WHERE MaDA = @MaDeAn)
    BEGIN
        RAISERROR ('Mã đề án đã tồn tại, đề nghị chọn mã đề án khác', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT * FROM PHONGBAN WHERE MaPhg = @MaPhongBan)
    BEGIN
        RAISERROR ('Mã phòng không tồn tại', 16, 1);
        RETURN;
    END

    INSERT INTO DEAN (MaDA, TenDA, DDiemDA)
    VALUES (@MaDeAn, @TenDeAn, @DDiemDA)
END

EXEC spThemDA 1, 'Đề án A', 'Mô tả cho Đề án A', 1;


EXEC spThemDA 1, 'Đề án B', 'Mô tả cho Đề án B', 1;


EXEC spThemDA 25, 'Đề án B', 'Mô tả cho Đề án B', 25;

----------CAU 7---------
