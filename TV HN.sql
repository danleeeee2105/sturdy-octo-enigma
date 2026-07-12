USE master;
GO

IF DB_ID('ThuVienHN') IS NOT NULL
BEGIN
    ALTER DATABASE ThuVienHN SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ThuVienHN;
END
GO
CREATE DATABASE ThuVienHN;
GO
USE ThuVienHN;
GO

-- Tác giả
CREATE TABLE TacGia (
    MaTacGia INT IDENTITY PRIMARY KEY,
    TenTacGia NVARCHAR(100),
    NamSinh INT,
    QuocTich NVARCHAR(50)
);

-- Nhà xuất bản
CREATE TABLE NhaXuatBan (
    MaNXB INT IDENTITY PRIMARY KEY,
    TenNXB NVARCHAR(150),
    DiaChi NVARCHAR(200)
);

-- Độc giả
CREATE TABLE DocGia (
    MaDocGia INT IDENTITY PRIMARY KEY,
    HoTen NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    SoDienThoai NVARCHAR(15),
    DiaChi NVARCHAR(200),
    NgayDangKy DATE DEFAULT GETDATE(),
    TrangThai NVARCHAR(20) DEFAULT N'Hoạt động'
);

-- Nhân viên
CREATE TABLE NhanVienThuVien (
    MaNhanVien INT IDENTITY PRIMARY KEY,
    HoTen NVARCHAR(100),
    ChucVu NVARCHAR(50)
);

-- Sách
CREATE TABLE Sach (
    MaSach INT IDENTITY PRIMARY KEY,
    TenSach NVARCHAR(200),
    MaTacGia INT,
    MaNXB INT,
    TheLoai NVARCHAR(100),
    NamXuatBan INT,
    FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia),
    FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB)
);

-- Bản sao sách
CREATE TABLE BanSaoSach (
    MaBanSao INT IDENTITY PRIMARY KEY,
    MaSach INT,
    ViTri NVARCHAR(50),
    TrangThai NVARCHAR(20),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- Mượn sách
CREATE TABLE MuonSach (
    MaMuon INT IDENTITY PRIMARY KEY,
    MaBanSao INT,
    MaDocGia INT,
    MaNhanVien INT,
    NgayMuon DATE,
    HanTra DATE,
    NgayTra DATE,
    FOREIGN KEY (MaBanSao) REFERENCES BanSaoSach(MaBanSao),
    FOREIGN KEY (MaDocGia) REFERENCES DocGia(MaDocGia),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVienThuVien(MaNhanVien)
);

-- Phạt
CREATE TABLE Phat (
    MaPhat INT IDENTITY PRIMARY KEY,
    MaMuon INT,
    SoTien DECIMAL(10,2),
    LyDo NVARCHAR(200),
    TrangThaiThanhToan NVARCHAR(50),
    FOREIGN KEY (MaMuon) REFERENCES MuonSach(MaMuon)
);
-------------------------------
INSERT INTO NhaXuatBan (TenNXB, DiaChi) VALUES
(N'NXB Trẻ', N'TP.HCM'),
(N'NXB Kim Đồng', N'Hà Nội'),
(N'Bloomsbury', N'Anh'),
(N'Penguin Random House', N'Mỹ'),
(N'NXB Thế Giới', N'Hà Nội');
INSERT INTO DocGia (HoTen, Email, SoDienThoai, DiaChi, NgayDangKy, TrangThai) VALUES
(N'Nguyễn Văn An', 'an@gmail.com', '0901111111', N'Hà Nội', '2026-04-01', N'Hoạt động'),
(N'Trần Thị Mai', 'mai@gmail.com', '0902222222', N'Hà Nội', '2026-04-02', N'Hoạt động'),
(N'Lê Hoàng Nam', 'nam@gmail.com', '0903333333', N'Hà Nội', '2026-04-03', N'Hoạt động'),
(N'Phạm Thu Hà', 'ha@gmail.com', '0904444444', N'Hà Nội', '2026-04-04', N'Hoạt động'),
(N'Đỗ Minh Khoa', 'khoa@gmail.com', '0905555555', N'Hà Nội', '2026-04-05', N'Hoạt động');
INSERT INTO NhanVienThuVien (HoTen, ChucVu) VALUES
(N'Nguyễn Thị Lan', N'Thủ thư'),
(N'Trần Minh Tuấn', N'Nhân viên'),
(N'Phạm Thu Hằng', N'Thủ thư'),
(N'Hoàng Đức Long', N'Quản lý'),
(N'Bùi Thu Trang', N'Nhân viên');
INSERT INTO Sach (TenSach, MaTacGia, MaNXB, TheLoai, NamXuatBan) VALUES
(N'Mắt Biếc', 1, 1, N'Văn học', 1990),
(N'Tôi thấy hoa vàng trên cỏ xanh', 1, 1, N'Văn học', 2010),
(N'Harry Potter và Hòn đá phù thủy', 3, 3, N'Fantasy', 1997),
(N'Rừng Na Uy', 2, 4, N'Tiểu thuyết', 1987),
(N'Sapiens: Lược sử loài người', 4, 5, N'Lịch sử', 2011);
INSERT INTO BanSaoSach (MaSach, ViTri, TrangThai) VALUES
(1, N'Kệ A1', N'Có sẵn'),
(2, N'Kệ A2', N'Có sẵn'),
(3, N'Kệ B1', N'Đang mượn'),
(4, N'Kệ B2', N'Có sẵn'),
(5, N'Kệ C1', N'Có sẵn');
INSERT INTO MuonSach (MaBanSao, MaDocGia, MaNhanVien, NgayMuon, HanTra, NgayTra) VALUES
(1, 1, 1, '2026-04-01', '2026-04-08', '2026-04-08'),
(3, 1, 1, '2026-04-01', '2026-05-08', '2026-06-08'),
(2, 2, 2, '2026-04-02', '2026-04-09', '2026-04-10'),
(3, 3, 3, '2026-04-03', '2026-04-10', NULL),
(4, 4, 4, '2026-04-04', '2026-04-11', '2026-04-11'),
(5, 5, 5, '2026-04-05', '2026-04-12', '2026-04-15');
INSERT INTO Phat (MaMuon, SoTien, LyDo, TrangThaiThanhToan) VALUES
(1, 20000, N'Trả trễ', N'Đã thanh toán'),
(2, 30000, N'Trả trễ', N'Đã thanh toán'),
(3, 50000, N'Chưa trả sách', N'Chưa thanh toán'),
(4, 10000, N'Hỏng sách', N'Đã thanh toán'),
(5, 40000, N'Trả trễ', N'Chưa thanh toán');
------------------
SELECT * FROM Sach;
SELECT * FROM DocGia;
SELECT * FROM MuonSach ms left JOIN BanSaoSach bs on bs.MaBanSao = ms.MaBanSao;
c
-------------------
-- khung nhin sach dang muon
CREATE VIEW vw_SachDangMuon AS
SELECT
    ms.MaMuon,
    dg.HoTen AS TenDocGia,
    s.TenSach,
    bs.MaBanSao,
    ms.NgayMuon,
    ms.HanTra,
    ms.NgayTra
FROM MuonSach ms
JOIN DocGia dg ON ms.MaDocGia = dg.MaDocGia
JOIN BanSaoSach bs ON ms.MaBanSao = bs.MaBanSao
JOIN Sach s ON bs.MaSach = s.MaSach
WHERE ms.NgayTra IS NULL;
GO
SELECT * FROM vw_SachDangMuon;
-- tao thu tuc muon sach
CREATE PROCEDURE sp_MuonSach
    @MaBanSao INT,
    @MaDocGia INT,
    @MaNhanVien INT
AS
BEGIN
    INSERT INTO MuonSach (MaBanSao, MaDocGia, MaNhanVien, NgayMuon, HanTra, NgayTra)
    VALUES (@MaBanSao, @MaDocGia, @MaNhanVien, GETDATE(), DATEADD(DAY, 7, GETDATE()), NULL);

    UPDATE BanSaoSach
    SET TrangThai = N'Đang mượn'
    WHERE MaBanSao = @MaBanSao;
END;
GO
EXEC sp_MuonSach @MaBanSao = 2, @MaDocGia = 3, @MaNhanVien = 2;
------------------
CREATE TRIGGER trg_TuDongPhatTre
ON MuonSach
AFTER UPDATE
AS
BEGIN
    INSERT INTO Phat (MaMuon, SoTien, LyDo, TrangThaiThanhToan)
    SELECT
        i.MaMuon,
        50000,
        N'Trả trễ hạn',
        N'Chưa thanh toán'
    FROM inserted i
    WHERE 
        i.NgayTra IS NOT NULL
        AND i.NgayTra > i.HanTra
        AND NOT EXISTS (
            SELECT 1 
            FROM Phat p 
            WHERE p.MaMuon = i.MaMuon
        );
END;
GO
UPDATE MuonSach
SET NgayTra = '2026-04-20'
WHERE MaMuon = 3;

SELECT COUNT(*) AS SoSachDangMuon
FROM MuonSach ms left JOIN BanSaoSach bs on bs.MaBanSao = ms.MaBanSao
WHERE NgayTra IS NULL;
DECLARE @MaDocGia INT = 1;

SELECT
    dg.HoTen,
    s.TenSach,
    ms.NgayMuon,
    ms.HanTra,
    ms.NgayTra,
    CASE 
        WHEN ms.NgayTra IS NULL THEN N'Đang mượn'
        ELSE N'Đã trả'
    END AS TrangThai
FROM MuonSach ms
JOIN DocGia dg ON ms.MaDocGia = dg.MaDocGia
JOIN BanSaoSach bs ON ms.MaBanSao = bs.MaBanSao
JOIN Sach s ON bs.MaSach = s.MaSach
WHERE dg.MaDocGia = @MaDocGia
ORDER BY ms.NgayMuon DESC;




