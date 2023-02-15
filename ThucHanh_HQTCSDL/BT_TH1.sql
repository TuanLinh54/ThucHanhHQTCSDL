--Cau 1:
EXEC sp_addtype 'Mota', 'NVARCHAR(40)'
EXEC sp_addtype 'IDKH', 'CHAR(10)', 'NOT NULL'
EXEC sp_addtype 'DT', 'CHAR(12)'

--Cau 2:
CREATE TABLE SanPham (
	Masp char(6) primary key not null,
	Tensp varchar(20),
	NgayNhap date,
	DVT char(10),
	SoluongTon int,
	DongiaNhap money
)

CREATE TABLE KhachHang(
	MaKH IDKH primary key not null,
	TenKH nvarchar(30),
	Diachi nvarchar(40),
	Dienthoai DT
)

CREATE TABLE HoaDon(
	MaHD char(10) primary key not null,
	Ngaylap date,
	Ngaygiao date,
	MaKH IDKH foreign key references KhachHang(MaKH),
	Diengiai Mota
)

CREATE TABLE ChiTietHD(
	MaHD char(10) foreign key references HoaDon(MaHD) not null,
	Masp char(6) foreign key references SanPham(Masp) not null,
	Soluong int
	primary key(MaHD, Masp)
)

--Cau 3:
ALTER TABLE HoaDon
ALTER COLUMN DienGiai nvarchar(100)

--Cau 4:
ALTER TABLE SanPham
ADD TyLeHoaHong FLOAT

--Cau 5:
ALTER TABLE SanPham
DROP COLUMN NgayNhap

--Cau 6:

--Cau 7:
------NgayGiao >= NgayLap---------
ALTER TABLE HoaDon
ADD CONSTRAINT check_Ngaygiao CHECK (Ngaygiao >= Ngaylap);
------MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số-----
ALTER TABLE HoaDon
ADD CONSTRAINT check_MaHD CHECK(MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]');
------Giá trị mặc định ban đầu cho cột NgayLap luôn luôn là ngày hiện hành-----
ALTER TABLE HoaDon
ADD CONSTRAINT df_Ngaylap DEFAULT GETDATE() FOR Ngaylap;

--Cau 8:
------SoLuongTon chỉ nhập từ 0 đến 500----
ALTER TABLE SanPham
ADD CONSTRAINT check_SoluongTon CHECK (SoluongTon BETWEEN 0 AND 500)
------DonGiaNhap lớn hơn 0------
ALTER TABLE SanPham
ADD CONSTRAINT check_DongiaNhap CHECK (DongiaNhap > 0)
------Giá trị mặc định cho NgayNhap là ngày hiện hành-----
ALTER TABLE SanPham
ADD CONSTRAINT df_NgayNhap DEFAULT GETDATE() FOR NgayNhap;
------DVT chỉ nhập vào các giá trị ‘KG’, ‘Thùng’, ‘Hộp’, ‘Cái’----
ALTER TABLE SanPham
ADD CONSTRAINT df_DVT CHECK (DVT = N'KG' or DVT = N'Thùng' or DVT = N'Hộp' or DVT = N'Cái')
 
--Cau 9:
 INSERT INTO SanPham (Masp, Tensp, NgayNhap, DVT, SoluongTon, DongiaNhap, TyLeHoaHong)
 VALUES ('SP1', N'Bút chì', '2022-08-14', N'Cái', 200, 3000, 0.15)
 INSERT INTO SanPham (Masp, Tensp, NgayNhap, DVT, SoluongTon, DongiaNhap, TyLeHoaHong)
 VALUES ('SP2', N'Khẩu Trang', '2022-10-18', N'Thùng', 50, 2500, 0.10)

INSERT INTO KhachHang (MaKH, TenKH, Diachi, Dienthoai)
VALUES ('KH1', N'Thanh Lam', 'TP.HCM', '0945578442')
INSERT INTO KhachHang (MaKH, TenKH, Diachi, Dienthoai)
VALUES ('KH2', N'Toàn Thắng', 'Tây Ninh', '0945566778')

INSERT INTO HoaDon (MaHD, Ngaylap, Ngaygiao, MaKH, Diengiai)
VALUES ('HD0001', '2022-08-16', '2022-08-25', 'KH1', 'Sản phẩm bút chì loại 1')
INSERT INTO HoaDon (MaHD, Ngaylap, Ngaygiao, MaKH, Diengiai)
VALUES ('HD0002', '2022-10-20', '2022-11-05', 'KH2', 'Sản phẩm khẩu trang kháng khuẩn')

INSERT INTO ChiTietHD (MaHD, Masp, Soluong)
VALUES ('HD0001', 'SP1', 300)
INSERT INTO ChiTietHD (MaHD, Masp, Soluong)
VALUES ('HD0002', 'SP2', 800)

