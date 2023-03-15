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
EXEC spThemDeAn @MaDeAn = '10', @TenDeAn = '', @DDiemDA = ''

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
        RAISERROR (N'Mã đề án đã tồn tại, đề nghị chọn mã đề án khác', 16, 1);
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

EXEC spThemDA 1, N'Đề án A', N'Mô tả cho Đề án A', 1;


EXEC spThemDA 1, N'Đề án B', N'Mô tả cho Đề án B', 1;


EXEC spThemDA 25, N'Đề án B', N'Mô tả cho Đề án B', 25;

----------CAU 7---------
CREATE PROCEDURE spXoaDeAn
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        PRINT N'Không thể xóa đề án này vì nó đã được phân công';
        RETURN;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END

EXEC spXoaDeAn @MaDA = '20'

----------CAU 8---------
CREATE PROCEDURE spXoaDA
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        DELETE FROM PHANCONG WHERE MaDA = @MaDA;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END

EXEC spXoaDA @MaDA = '20'


----------CAU 9---------
CREATE PROCEDURE spTongGioLamViec
    @MaNV INT,
    @TongGioLamViec INT OUTPUT
AS
BEGIN
    SELECT @TongGioLamViec = SUM(ThoiGian) FROM PHANCONG WHERE MaNV = @MaNV;
END
DECLARE @KetQua INT;
EXEC spTongGioLamViec 1, @KetQua OUTPUT;
SELECT @KetQua AS TongGioLamViec;

EXEC spTongGioLamViec @MaNV = '30'


---------10----------
CREATE PROCEDURE spTongTien
    @MaNV INT
AS
BEGIN
    DECLARE @Luong INT;
    DECLARE @LuongDeAn INT;
    DECLARE @TongTien INT;

    SELECT @Luong = Luong FROM NHANVIEN WHERE MaNV = @MaNV;
    SELECT @LuongDeAn = SUM(ThoiGian) * 100000 FROM PHANCONG WHERE MaNV = @MaNV;
    SET @TongTien = @Luong + ISNULL(@LuongDeAn, 0);

    PRINT 'Tổng tiền phải trả cho nhân viên ' + CAST(@MaNV AS NVARCHAR(10)) + ' là ' + CAST(@TongTien AS NVARCHAR(20)) + ' đồng';
END
EXEC spTongTien 333;


--------11-----------
SELECT @LuongDeAn = SUM(ThoiGian) * 100000 FROM PHANCONG WHERE MaNV = @MaNV;
    SET @TongTien = @Luong + ISNULL(@LuongDeAn, 0);

    PRINT 'Tổng tiền phải trả cho nhân viên ' + CAST(@MaNV AS NVARCHAR(10)) + ' là ' + CAST(@TongTien AS NVARCHAR(20)) + ' đồng';
END
EXEC spTongTien 333;

---11.
CREATE PROCEDURE spThemPhanCong
    @MaDA INT,
    @MaNV INT,
    @ThoiGian INT
AS
BEGIN
    IF @ThoiGian <= 0
    BEGIN
        PRINT 'Thời gian phải là một số dương';
        RETURN;
    END

    IF NOT EXISTS (SELECT * FROM DEAN WHERE MaDA = @MaDA)
    BEGIN
        PRINT 'Mã đề án không tồn tại trong bảng DEAN';
        RETURN;
    END

    IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @MaNV)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại trong bảng NHANVIEN';
        RETURN;
    END

    INSERT INTO PHANCONG(MaDA, MaNV, ThoiGian) VALUES (@MaDA, @MaNV, @ThoiGian);
END
EXEC spThemPhanCong 1, 2, 3;
