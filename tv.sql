CREATE DATABASE ThuVienDH;
GO
USE ThuVienDH;
GO

-- 1. Tác gi?
CREATE TABLE TacGia (
    MaTacGia INT IDENTITY(1,1) PRIMARY KEY,
    TenTacGia NVARCHAR(100) NOT NULL,
    NamSinh INT NULL,
    QuocTich NVARCHAR(50) NULL
);
GO

-- 2. Nhà xu?t b?n
CREATE TABLE NhaXuatBan (
    MaNXB INT IDENTITY(1,1) PRIMARY KEY,
    TenNXB NVARCHAR(150) NOT NULL,
    DiaChi NVARCHAR(200) NULL
);
GO

-- 3. Ngý?i dùng
CREATE TABLE NguoiDung (
    MaNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(15) NULL,
    CONSTRAINT UQ_NguoiDung_Email UNIQUE (Email)
);
GO

-- 4. Nhân viên thý vi?n
CREATE TABLE NhanVienThuVien (
    MaNhanVien INT IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(100) NOT NULL
);
GO

-- 5. Sách
CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(200) NOT NULL,
    MaTacGia INT NOT NULL,
    MaNXB INT NOT NULL,
    NamXuatBan INT NULL,
    CONSTRAINT FK_Sach_TacGia
        FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia),
    CONSTRAINT FK_Sach_NhaXuatBan
        FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB)
);
GO

-- 6. Sinh viên
CREATE TABLE SinhVien (
    MaNguoiDung INT PRIMARY KEY,
    MaSinhVien NVARCHAR(20) NOT NULL,
    Khoa NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_SinhVien_MaSinhVien UNIQUE (MaSinhVien),
    CONSTRAINT FK_SinhVien_NguoiDung
        FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);
GO

-- 7. Gi?ng viên
CREATE TABLE GiangVien (
    MaNguoiDung INT PRIMARY KEY,
    MaGiangVien NVARCHAR(20) NOT NULL,
    BoMon NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_GiangVien_MaGiangVien UNIQUE (MaGiangVien),
    CONSTRAINT FK_GiangVien_NguoiDung
        FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);
GO

-- 8. B?n sao sách
CREATE TABLE BanSaoSach (
    MaBanSao INT IDENTITY(1,1) PRIMARY KEY,
    MaSach INT NOT NULL,
    TrangThai NVARCHAR(20) NOT NULL,
    CONSTRAINT CK_BanSaoSach_TrangThai
        CHECK (TrangThai IN (N'Có s?n', N'Ðang mý?n')),
    CONSTRAINT FK_BanSaoSach_Sach
        FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);
GO

-- 9. Mý?n sách
CREATE TABLE MuonSach (
    MaMuon INT IDENTITY(1,1) PRIMARY KEY,
    MaBanSao INT NOT NULL,
    MaNguoiDung INT NOT NULL,
    MaNhanVien INT NOT NULL,
    NgayMuon DATE NOT NULL,
    NgayTra DATE NULL,
    CONSTRAINT FK_MuonSach_BanSaoSach
        FOREIGN KEY (MaBanSao) REFERENCES BanSaoSach(MaBanSao),
    CONSTRAINT FK_MuonSach_NguoiDung
        FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung),
    CONSTRAINT FK_MuonSach_NhanVien
        FOREIGN KEY (MaNhanVien) REFERENCES NhanVienThuVien(MaNhanVien)
);
GO

-- 10. Ph?t
CREATE TABLE Phat (
    MaPhat INT IDENTITY(1,1) PRIMARY KEY,
    MaMuon INT NOT NULL,
    SoTien DECIMAL(12,2) NOT NULL,
    LyDo NVARCHAR(200) NOT NULL,
    CONSTRAINT CK_Phat_SoTien CHECK (SoTien > 0),
    CONSTRAINT FK_Phat_MuonSach
        FOREIGN KEY (MaMuon) REFERENCES MuonSach(MaMuon)
);
GO
---------------------------------------
-- 1. Tác gi?
INSERT INTO TacGia (TenTacGia, NamSinh, QuocTich)
VALUES
(N'Nguy?n Nh?t Ánh', 1955, N'Vi?t Nam'),
(N'Haruki Murakami', 1949, N'Nh?t B?n'),
(N'J. K. Rowling', 1965, N'Anh'),
(N'Yuval Noah Harari', 1976, N'Israel'),
(N'Paulo Coelho', 1947, N'Brazil');
GO

-- 2. Nhà xu?t b?n
INSERT INTO NhaXuatBan (TenNXB, DiaChi)
VALUES
(N'NXB Tr?', N'TP. H? Chí Minh'),
(N'NXB Kim Ð?ng', N'Hà N?i'),
(N'Bloomsbury', N'London, Anh'),
(N'Penguin Random House', N'New York, Hoa K?'),
(N'NXB H?i Nhà vãn', N'Hà N?i');
GO

-- 3. Sách
INSERT INTO Sach (TenSach, MaTacGia, MaNXB, NamXuatBan)
VALUES
(N'M?t Bi?c', 1, 1, 1990),
(N'Tôi th?y hoa vàng trên c? xanh', 1, 1, 2010),
(N'Harry Potter và H?n ðá phù th?y', 3, 3, 1997),
(N'R?ng Na Uy', 2, 4, 1987),
(N'Sapiens: Lý?c s? loài ngý?i', 4, 4, 2011);
GO

-- 4. Ngý?i dùng
INSERT INTO NguoiDung (Ten, Email, SoDienThoai)
VALUES
(N'Nguy?n Vãn An', 'an.nguyen@gmail.com', '0901000001'),
(N'Tr?n Th? Mai', 'mai.tran@gmail.com', '0901000002'),
(N'Lê Hoàng Nam', 'nam.le@gmail.com', '0901000003'),
(N'Ph?m Thu Hà', 'ha.pham@gmail.com', '0901000004'),
(N'Ð? Minh Khoa', 'khoa.do@gmail.com', '0901000005');
GO

-- 5. Sinh viên
INSERT INTO SinhVien (MaNguoiDung, MaSinhVien, Khoa)
VALUES
(1, N'SV001', N'Công ngh? thông tin'),
(2, N'SV002', N'Tài chính - Ngân hàng'),
(3, N'SV003', N'K? toán');
GO

-- 6. Gi?ng viên
INSERT INTO GiangVien (MaNguoiDung, MaGiangVien, BoMon)
VALUES
(4, N'GV001', N'Kinh t?'),
(5, N'GV002', N'H? th?ng thông tin');
GO

-- 7. Nhân viên thý vi?n
INSERT INTO NhanVienThuVien (Ten)
VALUES
(N'Nguy?n Th? Lan'),
(N'Tr?n Minh Tu?n'),
(N'Ph?m Thu H?ng'),
(N'Hoàng Ð?c Long'),
(N'Bùi Thu Trang');
GO

-- 8. B?n sao sách
INSERT INTO BanSaoSach (MaSach, TrangThai)
VALUES
(1, N'Có s?n'),
(2, N'Ðang mý?n'),
(3, N'Có s?n'),
(4, N'Có s?n'),
(5, N'Có s?n');
GO

-- 9. Mý?n sách
INSERT INTO MuonSach (MaBanSao, MaNguoiDung, MaNhanVien, NgayMuon, NgayTra)
VALUES
(1, 1, 1, '2026-04-01', '2026-04-08'),
(2, 2, 2, '2026-04-02', '2026-04-10'),
(3, 3, 3, '2026-04-03', '2026-04-11'),
(4, 4, 4, '2026-04-04', '2026-04-12'),
(5, 5, 5, '2026-04-05', '2026-04-15');
GO

-- 10. Ph?t
INSERT INTO Phat (MaMuon, SoTien, LyDo)
VALUES
(1, 20000, N'Tr? tr? 1 ngày'),
(2, 50000, N'Tr? tr? 2 ngày'),
(3, 30000, N'Làm rách trang sách'),
(4, 10000, N'Bôi b?n b?a sách'),
(5, 40000, N'Tr? tr? theo quy ð?nh');
GO