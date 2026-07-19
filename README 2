# Dự án: Thiết kế Cơ sở Dữ liệu Quản lý Thư viện Hà Nội

## 1. Thành viên nhóm & Vai trò
* **Lê Tài Đức Anh** - Nhóm trưởng
* **Vũ Ngọc Diệp** - Thành viên.
---
## 2. Phân tích yêu cầu hệ thống

### A. Yêu cầu chức năng
Hệ thống bao gồm 11 chức năng quản lý trọng tâm sau:
* **CN01 - Quản lý tác giả:** Cho phép Thủ thư thêm, sửa, xóa và tra cứu các thông tin liên quan đến tác giả (họ tên, năm sinh, quốc tịch).
* **CN02 - Quản lý nhà xuất bản:** Cho phép Thủ thư thêm, sửa, xóa và tra cứu thông tin của các đơn vị xuất bản sách.
* **CN03 - Quản lý sách:** Quản lý thông tin tổng quan của các đầu sách bao gồm tên sách, thể loại, năm xuất bản, nhà xuất bản và tác giả.
* **CN04 - Quản lý bản sao sách:** Theo dõi và cập nhật trạng thái (Có sẵn, Đang mượn, Mất) cùng vị trí vật lý cụ thể của từng cuốn sách trên kệ.
* **CN05 - Quản lý độc giả:** Thêm mới độc giả khi đăng ký thẻ, sửa và cập nhật thông tin cá nhân cũng như trạng thái hoạt động của tài khoản.
* **CN06 - Quản lý nhân viên:** Lưu trữ, cập nhật hồ sơ thông tin và phân quyền cho nhân viên thư viện (do tài khoản Quản lý thực hiện).
* **CN07 - Mượn sách:** Ghi nhận thông tin giao dịch khi độc giả mượn sách, lập phiếu mượn gồm mã độc giả, mã sách, ngày mượn, hạn trả; hệ thống tự động cập nhật giảm số lượng bản sao sách hiện có.
* **CN08 - Trả sách:** Cập nhật thông tin ngày trả thực tế của độc giả và tự động hoàn trả trạng thái cuốn sách thành "Có sẵn" trong kho phục vụ lượt mượn kế tiếp.
* **CN09 - Quản lý phạt:** Tự động tính toán số tiền và lưu lý do phạt nếu độc giả có hành vi trả sách muộn quá hạn hoặc làm hư hỏng sách vật lý.
* **CN10 - Tra cứu sách:** Giúp Độc giả dễ dàng tìm kiếm nhanh sách theo tiêu chí như tên sách, tác giả, hoặc thể loại.
* **CN11 - Báo cáo thống kê:** Hỗ trợ kết xuất dữ liệu thống kê số lượng sách, lượt mượn/trả theo tháng, độc giả mượn nhiều nhất, hay danh sách nợ phạt (do Quản lý thực hiện).

### B. Thao tác của các đối tượng người dùng
* **Thủ thư (Nhân viên):** Thực hiện quản lý danh mục (sách, tác giả, NXB, bản sao), quản lý hồ sơ độc giả, xử lý nghiệp vụ lập phiếu mượn/trả sách, kiểm tra tình trạng sách và lập phiếu phạt.
* **Độc giả (Người mượn):** Thao tác tra cứu thông tin sách, kiểm tra trạng thái khả dụng của tài liệu trực tuyến và thực hiện mượn trả tại quầy.
* **Quản lý thư viện:** Theo dõi hoạt động tổng quan, xem hệ thống báo cáo thống kê phục vụ ra quyết định và quản lý phân quyền tài khoản cho nhân viên.

### C. Yêu cầu phi chức năng
* **Lưu trữ dữ liệu bền vững:** Toàn bộ thông tin được lưu trữ và quản lý tập trung trong hệ quản trị CSDL, đảm bảo dữ liệu không bị mất sau khi tắt ứng dụng hoặc hệ thống ngừng hoạt động.
* **Giao diện dễ sử dụng:** Các thao tác tra cứu, cập nhật thông tin được thiết kế tối ưu, giúp giảm bớt thời gian xử lý thủ công cho cả1. Sơ đồ quan hệ

Từ mô hình ERD đã xây dựng, hệ thống được chuyển đổi sang mô hình quan hệ gồm các bảng sau:

- **TAC_GIA** (`MaTacGia`, `TenTacGia`, `NamSinh`, `QuocTich`)
- **NHA_XUAT_BAN** (`MaNXB`, `TenNXB`, `DiaChi`)
- **SACH** (`MaSach`, `TenSach`, `MaTacGia`, `MaNXB`, `TheLoai`, `NamXuatBan`)
- **BAN_SAO_SACH** (`MaBanSao`, `MaSach`, `ViTri`, `TrangThai`)
- **DOC_GIA** (`MaDocGia`, `HoTen`, `Email`, `SoDienThoai`, `DiaChi`, `NgayDangKy`, `TrangThai`)
- **NHAN_VIEN_THU_VIEN** (`MaNhanVien`, `HoTen`, `ChucVu`)
- **MUON_SACH** (`MaMuon`, `MaBanSao`, `MaDocGia`, `MaNhanVien`, `NgayMuon`, `HanTra`, `NgayTra`)
- **PHAT** (`MaPhat`, `MaMuon`, `SoTien`, `LyDo`, `TrangThaiThanhToan`)

### Khóa chính

Mỗi bảng đều sử dụng một khóa chính (`PRIMARY KEY`) dạng mã định danh tự tăng (`IDENTITY`):

| Bảng | Khóa chính |
|------|------------|
| TAC_GIA | `MaTacGia` |
| NHA_XUAT_BAN | `MaNXB` |
| SACH | `MaSach` |
| BAN_SAO_SACH | `MaBanSao` |
| DOC_GIA | `MaDocGia` |
| NHAN_VIEN_THU_VIEN | `MaNhanVien` |
| MUON_SACH | `MaMuon` |
| PHAT | `MaPhat` |

### Khóa ngoại

Các bảng được liên kết với nhau thông qua các khóa ngoại nhằm đảm bảo tính toàn vẹn dữ liệu:

| Bảng | Khóa ngoại | Tham chiếu |
|------|------------|------------|
| SACH | `MaTacGia` | `TAC_GIA(MaTacGia)` |
| SACH | `MaNXB` | `NHA_XUAT_BAN(MaNXB)` |
| BAN_SAO_SACH | `MaSach` | `SACH(MaSach)` |
| MUON_SACH | `MaBanSao` | `BAN_SAO_SACH(MaBanSao)` |
| MUON_SACH | `MaDocGia` | `DOC_GIA(MaDocGia)` |
| MUON_SACH | `MaNhanVien` | `NHAN_VIEN_THU_VIEN(MaNhanVien)` |
| PHAT | `MaMuon` | `MUON_SACH(MaMuon)` |

### Mô tả

Thiết kế cơ sở dữ liệu mức logic được xây dựng dựa trên mô hình ERD, trong đó mỗi thực thể được chuyển thành một bảng dữ liệu. Các khóa chính giúp định danh duy nhất từng bản ghi, trong khi các khóa ngoại đảm bảo mối quan hệ giữa tác giả, nhà xuất bản, sách, bản sao sách, độc giả, nhân viên, giao dịch mượn và thông tin xử phạt. Thiết kế này giúp dữ liệu nhất quán, hạn chế dư thừa và thuận lợi cho việc truy vấn cũng như mở rộng hệ thống trong tương lai.
## 5. Thiết kế cơ sở dữ liệu mức logic

### 5.1. Sơ đồ quan hệ

Từ mô hình ERD đã xây dựng, hệ thống được chuyển đổi sang mô hình quan hệ gồm các bảng sau:

- **TAC_GIA** (`MaTacGia`, `TenTacGia`, `NamSinh`, `QuocTich`)
- **NHA_XUAT_BAN** (`MaNXB`, `TenNXB`, `DiaChi`)
- **SACH** (`MaSach`, `TenSach`, `MaTacGia`, `MaNXB`, `TheLoai`, `NamXuatBan`)
- **BAN_SAO_SACH** (`MaBanSao`, `MaSach`, `ViTri`, `TrangThai`)
- **DOC_GIA** (`MaDocGia`, `HoTen`, `Email`, `SoDienThoai`, `DiaChi`, `NgayDangKy`, `TrangThai`)
- **NHAN_VIEN_THU_VIEN** (`MaNhanVien`, `HoTen`, `ChucVu`)
- **MUON_SACH** (`MaMuon`, `MaBanSao`, `MaDocGia`, `MaNhanVien`, `NgayMuon`, `HanTra`, `NgayTra`)
- **PHAT** (`MaPhat`, `MaMuon`, `SoTien`, `LyDo`, `TrangThaiThanhToan`)

### Khóa chính

Mỗi bảng đều sử dụng một khóa chính (`PRIMARY KEY`) dạng mã định danh tự tăng (`IDENTITY`):

| Bảng | Khóa chính |
|------|------------|
| TAC_GIA | `MaTacGia` |
| NHA_XUAT_BAN | `MaNXB` |
| SACH | `MaSach` |
| BAN_SAO_SACH | `MaBanSao` |
| DOC_GIA | `MaDocGia` |
| NHAN_VIEN_THU_VIEN | `MaNhanVien` |
| MUON_SACH | `MaMuon` |
| PHAT | `MaPhat` |

### Khóa ngoại

Các bảng được liên kết với nhau thông qua các khóa ngoại nhằm đảm bảo tính toàn vẹn dữ liệu:

| Bảng | Khóa ngoại | Tham chiếu |
|------|------------|------------|
| SACH | `MaTacGia` | `TAC_GIA(MaTacGia)` |
| SACH | `MaNXB` | `NHA_XUAT_BAN(MaNXB)` |
| BAN_SAO_SACH | `MaSach` | `SACH(MaSach)` |
| MUON_SACH | `MaBanSao` | `BAN_SAO_SACH(MaBanSao)` |
| MUON_SACH | `MaDocGia` | `DOC_GIA(MaDocGia)` |
| MUON_SACH | `MaNhanVien` | `NHAN_VIEN_THU_VIEN(MaNhanVien)` |
| PHAT | `MaMuon` | `MUON_SACH(MaMuon)` |

### Mô tả

Thiết kế cơ sở dữ liệu mức logic được xây dựng dựa trên mô hình ERD, trong đó mỗi thực thể được chuyển thành một bảng dữ liệu. Các khóa chính giúp định danh duy nhất từng bản ghi, trong khi các khóa ngoại đảm bảo mối quan hệ giữa tác giả, nhà xuất bản, sách, bản sao sách, độc giả, nhân viên, giao dịch mượn và thông tin xử phạt. Thiết kế này giúp dữ liệu nhất quán, hạn chế dư thừa và thuận lợi cho việc truy vấn cũng như mở rộng hệ thống trong tương lai.
