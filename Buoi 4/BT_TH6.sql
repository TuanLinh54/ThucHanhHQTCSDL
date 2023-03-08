---------------------CAU 1------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Nhan vien co it nhat 1 than nhan'
FROM NHANVIEN
WHERE NHANVIEN.MANV IN (SELECT THANNHAN.MaNV
						FROM NHANVIEN, THANNHAN
						WHERE NHANVIEN.MANV = THANNHAN.MaNV)

---------------------CAU 2------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Nhan vien khong co than nhan nao'
FROM NHANVIEN
WHERE NHANVIEN.MANV NOT IN (SELECT THANNHAN.MaNV
							FROM NHANVIEN, THANNHAN
							WHERE NHANVIEN.MANV = THANNHAN.MaNV)

---------------------CAU 3------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Nhan vien co tren 2 than nhan'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MaNV = THANNHAN.MaNV
GROUP BY HoNV, TenLot, TenNV
HAVING COUNT(THANNHAN.MaNV) > 2

---------------------CAU 4------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten truong phong co it nhat 1 than nhan'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MaNV = PHONGBAN.TRPHG AND PHONGBAN.TRPHG IN (SELECT THANNHAN.MaNV
															FROM NHANVIEN, THANNHAN
															WHERE NHANVIEN.MaNV = THANNHAN.MaNV)

---------------------CAU 6------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien'
FROM NHANVIEN
WHERE NHANVIEN.Luong > (SELECT AVG(NHANVIEN.Luong)
						FROM NHANVIEN, PHONGBAN
						WHERE NHANVIEN.Phong = PHONGBAN.MaPhg AND PHONGBAN.TenPhg = N'Quản lý')

---------------------CAU 7------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien'
FROM NHANVIEN
WHERE NHANVIEN.Luong > (SELECT AVG(NHANVIEN.Luong)
						FROM NHANVIEN, PHONGBAN
						WHERE NHANVIEN.Phong = PHONGBAN.MaPhg)

---------------------CAU 8------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MaNV = PHONGBAN.TRPHG AND PHONGBAN.MaPhg = (SELECT TOP 1 PHONGBAN.MaPhg
															FROM NHANVIEN, PHONGBAN
															WHERE NHANVIEN.Phong = PHONGBAN.MaPhg
															GROUP BY PHONGBAN.MaPhg
															ORDER BY COUNT(NHANVIEN.Phong) DESC)

---------------------CAU 9------------------------
SELECT MaDA AS 'Ma de an chua tham gia'
FROM DEAN
WHERE DEAN.MaDA NOT IN (SELECT PHANCONG.MaDA
							FROM PHANCONG
							WHERE PHANCONG.MaNV = '456')

---------------------CAU 10------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien', Diachi
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (DiaChi NOT LIKE N'TP Quảng Ngãi' AND DEAN.DDiemDA LIKE N'TP Quảng Ngãi') OR (DiaChi NOT LIKE N'TP Quảng Ngãi' AND DEAN.DDiemDA LIKE N'TP Quảng Ngãi')
GROUP BY HoNV, TenLot, TenNV, NHANVIEN.MaNV, DiaChi, DDiemDA

---------------------CAU 11------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien', Diachi, DDiemDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (DiaChi NOT LIKE DEAN.DDiemDA)
GROUP BY HoNV, TenLot, TenNV, NHANVIEN.MaNV, DiaChi, DDiemDA

---------------------CAU 12------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien', MaDA
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.MaNV = PHONGBAN.TRPHG, PHANCONG
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND NHANVIEN.HoNV = N'Lê'

---------------------CAU 13------------------------
SELECT NHANVIEN.MaNV, (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien', TenDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE NHANVIEN.MaNV = '123' AND NHANVIEN.MaNV = '789'
GROUP BY NHANVIEN.MaNV, HoNV, TenLot, TenNV, DEAN.TenDA

---------------------CAU 14------------------------
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Ho ten nhan vien', TenDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (HoNV = N'Đinh' AND TenLot = N'Bá' AND TenNV = N'Tiến') AND (HoNV = N'Trần' AND TenLot = N'Thanh' AND TenNV = N'Tâm')
GROUP BY HoNV, TenLot, TenNV, DEAN.TenDA

---------------------CAU 15------------------------
SELECT pc.MaNV, nv.TENNV, nv.PHAI
FROM PHANCONG pc, NHANVIEN nv
WHERE pc.MaNV = nv.MANV AND NOT EXISTS(SELECT d.MADA FROM DeAn d 
										WHERE NOT EXISTS(SELECT pc.MADA
										FROM PHANCONG pc 
										WHERE pc.MADA = d.MADA AND pc.MaNV = nv.MANV));