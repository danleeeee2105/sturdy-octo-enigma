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
* **Giao diện dễ sử dụng:** Các thao tác tra cứu, cập nhật thông tin được thiết kế tối ưu, giúp giảm bớt thời gian xử lý thủ công cho cả thủ thư và người đọc.
* **Độ ổn định cao & Hạn chế lỗi:** Cơ sở dữ liệu được tổ chức chặt chẽ theo dạng chuẩn 3 (3NF) giúp giảm thiểu tối đa hiện tượng dư thừa dữ liệu và loại bỏ các lỗi bất thường (Anomalies) khi thao tác thêm/sửa/xóa.

---

## 3. Mô tả ngắn gọn dự án
* **Tên dự án:** Hệ thống Quản lý Thư viện Hà Nội.
* **Mục tiêu dự án:** Hiện đại hóa quy trình quản lý lưu trữ thủ công trước đây; xây dựng một nền tảng dữ liệu khoa học giúp tối ưu hóa quy trình mượn - trả, tra cứu thông tin chính xác và nâng cao văn hóa đọc cho cộng đồng.
* **Mô tả chức năng chính:** Quản lý dữ liệu thư viện (Sách, Độc giả, Nhân viên, Đối tác); Vận hành cốt lõi nghiệp vụ Mượn - Trả sách; Kiểm soát rủi ro thông qua xử lý vi phạm nợ phạt và kết xuất báo cáo định kỳ.
* **Công nghệ dự kiến sử dụng:** Hệ quản trị cơ sở dữ liệu **Microsoft SQL Server** (Ngôn ngữ T-SQL hỗ trợ lập trình Table, View, Stored Procedure, Trigger) và **Microsoft Excel** để tổng hợp trực quan hóa biểu đồ thống kê.

---

## 4. Thiết kế Cơ sở Dữ liệu chi tiết

### A. Danh sách Thực thể, Thuộc tính và Khóa chính
Hệ thống được thiết kế bao gồm 8 thực thể chính dưới đây:

1. **TAC_GIA** (Lưu thông tin tác giả)
   * *Khóa chính:* `MaTacGia` (INT)
   * *Thuộc tính:* `TenTacGia` (NVARCHAR), `NamSinh` (INT), `QuocTich` (NVARCHAR).

2. **NHA_XUAT_BAN** (Lưu thông tin đơn vị xuất bản)
   * *Khóa chính:* `MaNXB` (INT)
   * *Thuộc tính:* `TenNXB` (NVARCHAR), `DiaChi` (NVARCHAR).

3. **SACH** (Danh mục các đầu sách trong thư viện)
   * *Khóa chính:* `MaSach` (INT)
   * *Thuộc tính:* `TenSach` (NVARCHAR), `TheLoai` (NVARCHAR), `NamXuatBan` (INT).
   * *Khóa ngoại:* `MaTacGia` (Liên kết bảng TAC_GIA), `MaNXB` (Liên kết bảng NHA_XUAT_BAN).

4. **BAN_SAO_SACH** (Quản lý các cuốn sách vật lý trên giá)
   * *Khóa chính:* `MaBanSao` (INT)
   * *Thuộc tính:* `TrangThai` (NVARCHAR), `ViTri` (NVARCHAR).
   * *Khóa ngoại:* `MaSach` (Liên kết bảng SACH).

5. **DOC_GIA** (Thông tin bạn đọc đăng ký thẻ thư viện)
   * *Khóa chính:* `MaDocGia` (INT)
   * *Thuộc tính:* `HoTen` (NVARCHAR), `Email` (NVARCHAR - Ràng buộc Duy nhất), `SoDienThoai` (CHAR), `DiaChi` (NVARCHAR), `NgayDangKy` (DATE), `TrangThai` (NVARCHAR).

6. **NHAN_VIEN_THU_VIEN** (Hồ sơ nhân viên vận hành)
   * *Khóa chính:* `MaNhanVien` (INT)
   * *Thuộc tính:* `HoTen` (NVARCHAR), `ChucVu` (NVARCHAR).

7. **MUON_SACH** (Ghi nhận thông tin chi tiết mỗi giao dịch mượn trả)
   * *Khóa chính:* `MaMuon` (INT)
   * *Thuộc tính:* `NgayMuon` (DATE), `HanTra` (DATE), `NgayTra` (DATE - Cho phép NULL khi chưa trả sách).
   * *Khóa ngoại:* `MaBanSao` (bảng BAN_SAO_SACH), `MaDocGia` (bảng DOC_GIA), `MaNhanVien` (bảng NHAN_VIEN_THU_VIEN).

8. **PHAT** (Theo dõi các khoản phạt phát sinh do vi phạm)
   * *Khóa chính:* `MaPhat` (INT)
   * *Thuộc tính:* `SoTien` (DECIMAL), `LyDo` (NVARCHAR), `NgayPhat` (DATE), `TrangThaiThanhToan` (NVARCHAR).
   * *Khóa ngoại:* `MaMuon` (Liên kết bảng MUON_SACH).

### B. Mối quan hệ giữa các Thực thể (Bản số 1 - N)
* **TAC_GIA – SACH (1 – N):** Một tác giả có thể sáng tác nhiều đầu sách; mã tác giả được đưa vào bảng Sách làm khóa ngoại để phân định.
* **NHA_XUAT_BAN – SACH (1 – N):** Một nhà xuất bản có quyền phát hành nhiều đầu sách khác nhau phục vụ thư viện.
* **SACH – BAN_SAO_SACH (1 – N):** Một đầu sách (thông tin định danh chung) có thể tồn tại nhiều bản sao vật lý được xếp trên kệ sách.
* **BAN_SAO_SACH – MUON_SACH (1 – N):** Một bản sao sách cụ thể có thể tham gia vào nhiều giao dịch mượn trả tại các thời điểm khác nhau.
* **DOC_GIA – MUON_SACH (1 – N):** Một độc giả sở hữu thẻ thư viện hợp lệ được thực hiện nhiều lượt mượn sách trong suốt quá trình sử dụng.
* **NHAN_VIEN_THU_VIEN – MUON_SACH (1 – N):** Một thủ thư chịu trách nhiệm tiếp nhận và thực hiện giám sát cho nhiều giao dịch mượn trả tại quầy.
* **MUON_SACH – PHAT (1 – N):** Một lượt mượn sách nếu xảy ra sự cố vi phạm (quá hạn hoặc hỏng sách) có thể bị lập một hoặc nhiều hóa đơn phạt.
