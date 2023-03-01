-------CAU 1---------
SELECT * FROM NHANVIEN

-------CAU 2---------
SELECT * FROM NHANVIEN
WHERE Phong = 5

-------CAU 3---------
SELECT (HoNV + TenLot + TenNV) AS N'Họ Tên', Phong
FROM NHANVIEN
WHERE Luong > 6000000

-------CAU 4---------
SELECT * FROM NHANVIEN
WHERE Luong > 6000000 AND Phong = 1 OR Luong > 5000000 AND Phong = 4

-------CAU 5---------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', Diachi
FROM NHANVIEN
WHERE Diachi = N'Tp Quãng Ngãi'

-------CAU 6---------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên'
FROM NHANVIEN
WHERE HoNV LIKE 'N%'

-------CAU 7---------
SELECT HoNV, TenLot, TenNV, NgSinh, Diachi
FROM NHANVIEN
WHERE HoNV = N'Cao' AND TenLot = N'Thanh' AND TenNV = N'Huyền'

-------CAU 8---------
SELECT * FROM NHANVIEN
WHERE YEAR(NgSinh) BETWEEN 1955 AND 1975

-------CAU 9---------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', YEAR(NgSinh) AS N'Năm sinh'
FROM NHANVIEN

-------CAU 10--------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', YEAR(GETDATE()) - YEAR(NgSinh) AS N'Tuổi'
FROM NHANVIEN

-------CAU 11--------
SELECT (HoNV+ ' ' +TenLot+ ' ' +TenNV) AS N'Họ Tên Trưởng Phòng'
FROM PHONGBAN,NHANVIEN
WHERE PHONGBAN.TrPhg = NHANVIEN.MaNV


-------CAU 12--------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', Diachi, TenPhg
FROM NHANVIEN, PHONGBAN
WHERE PHONGBAN.MaPhg = NHANVIEN.Phong AND TenPhg LIKE N'Điều hành'

-------CAU 13--------
SELECT TenDA, TenPhg, HoNV, TenLot, TenNV
FROM NHANVIEN,PHONGBAN,DEAN
WHERE NHANVIEN.MaNV = PHONGBAN.TrPhg and PHONGBAN.MaPhg = DEAN.Phong and DEAN.DDiemDA like N'Tp Quãng Ngãi'

-------CAU 14--------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', TenTN AS N'Tên người thân', NHANVIEN.Phai
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MaNV = THANNHAN.MaNV AND NHANVIEN.Phai LIKE N'Nữ'

-------CAU 15--------
SELECT nv.HoNV + ' ' + nv.TenLot + ' ' + nv.TenNV AS N'Họ Tên NV', tp.HoNV + ' ' + tp.TenLot + ' ' +tp.TenNV AS N'Họ Tên Trưởng Phòng'
from NHANVIEN nv, NHANVIEN tp, PHONGBAN pb
where tp.MaNV = pb.TRPHG and nv.Phong = tp.Phong

-------CAU 16--------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', TenPhg AS N'Tên phòng', TenDA AS N'Tên đề án'
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA, PHONGBAN
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg AND PHONGBAN.TenPhg = N'Nghiên cứu' AND DEAN.TenDA LIKE N'Xây dựng nhà máy chế biến thủy sản'
GROUP BY TenPhg, TenDA, HoNV, TenLot, TenNV

-------CAU 17--------
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', DEAN.TenDA
FROM NHANVIEN,PHANCONG,DEAN
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND PHANCONG.MaDA= DEAN.MaDA AND HoNV = N'Trần' AND TenLot = N'Thanh' AND TenNV = N'Tâm'