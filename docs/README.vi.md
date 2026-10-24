# Gói Chocolatey cho eGovFrame

<!-- latest-badge:start -->
[![Khung chuẩn Chính phủ điện tử](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/unversioned/flat-vi.svg)](https://www.egovframe.go.kr/)
[![Chocolatey Package Test](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml)
[![Malware Scan](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml/badge.svg)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](../LICENSE)
<!-- latest-badge:end -->

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](README.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](README.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](README.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/flat.svg)](README.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](README.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](README.fr.md)

## Giới thiệu
Chào mừng bạn đến với gói Chocolatey của eGovFrame. Chocolatey là trình quản lý gói cho Windows cho phép người dùng cài đặt phần mềm dễ dàng qua dòng lệnh. Gói này cung cấp cách thức đơn giản để cài đặt eGovFrame, một khung mã nguồn mở do chính phủ Hàn Quốc phát triển. eGovFrame được thiết kế để phát triển ứng dụng trong khu vực công và được sử dụng rộng rãi như một nền tảng tiêu chuẩn hóa cho các dự án CNTT tại Hàn Quốc.

- [Gói chính thức trên Chocolatey](https://community.chocolatey.org/packages/egovframe)

## Về eGovFrame
- **Tên**: eGovFrame (Khung chuẩn Chính phủ điện tử)
- **Phiên bản**: 5.0.2 (Môi trường phát triển Windows 64-bit, Eclipse 2025-03, Java 21)
- **Mô tả**: eGovFrame là khung mã nguồn mở do chính phủ Hàn Quốc cung cấp để phát triển các dịch vụ công trực tuyến. Nó được xây dựng bằng Java và Spring framework.
- **Trang chủ**: [Trang web chính thức của eGovFrame](https://www.egovframe.go.kr/)

## Hướng dẫn cài đặt

### Cài đặt eGovFrame qua Chocolatey

Khi Chocolatey đã được cài đặt, bạn có thể dễ dàng cài đặt eGovFrame bằng cách chạy lệnh sau trong PowerShell hoặc Command Prompt:

```shell
choco install egovframe
```

Để cài đặt phiên bản cụ thể này:
```shell
choco install egovframe --version=5.0.2
```

### Đường dẫn cài đặt ứng dụng
Theo mặc định, eGovFrame được cài đặt tại vị trí công cụ Chocolatey, `C:\tools\eGovFrame` (`$env:ChocolateyToolsLocation\eGovFrame`). Đường dẫn này được sử dụng thay vì Program Files để các cập nhật tiện ích mở rộng Eclipse và dự án của bạn có thể ghi được mà không cần quyền quản trị viên.

| Thư mục | Nội dung |
|---|---|
| `eclipse` | Eclipse IDE (được thay thế khi nâng cấp) |
| `workspace-egov` | Không gian làm việc được định cấu hình sẵn phối cảnh eGovFrame (**không bao giờ bị ghi đè khi nâng cấp, được giữ lại khi gỡ cài đặt**) |
| `notice` | Ghi chú bản vá Amateras Modeler |

Gói tải xuống tệp chính thức `eGovFrameDev-5.0.2-Windows-64bit.zip` (khoảng 1.04 GB), xác minh tổng kiểm tra SHA-256 và cài đặt. Thời gian cài đặt phụ thuộc vào tốc độ mạng và ổ đĩa của bạn.

## Thiết lập sau cài đặt

1. **Phím tắt**: Sau khi cài đặt, một phím tắt `eGovFrame` sẽ được tạo trên màn hình nền. Bạn cũng có thể chạy trực tiếp `C:\tools\eGovFrame\eclipse\eclipse.exe`.
2. **Không gian làm việc**: Trình khởi chạy chọn sẵn `C:\tools\eGovFrame\workspace-egov`. Xác nhận đường dẫn và nhấp vào Launch.
3. **Java**: eGovFrame 5.0.2 đi kèm với môi trường chạy Java 21 riêng, do đó Eclipse khởi động mà không cần JDK riêng và gói này không phụ thuộc vào Java. Nếu công cụ xây dựng của bạn (Maven, Gradle, ...) cần JDK 21 trên dòng lệnh, hãy cài đặt riêng, ví dụ: `choco install temurin21`.

## Xử lý sự cố (Troubleshooting)

1. **Lỗi JVM ("Failed to create the Java Virtual Machine")**:
   Chỉnh sửa `eclipse\eclipse.ini` trong thư mục cài đặt và thêm đường dẫn đến JDK 21 của bạn:
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **Sự cố mã hóa ký tự**:
   Để tránh vỡ ký tự tiếng Hàn, hãy thêm `-Dfile.encoding=UTF-8` vào tệp `eclipse.ini` của bạn.
3. **Ký tự bị lỗi trong tệp DML mẫu**: Thay đổi mã hóa của tệp DML bị ảnh hưởng thành EUC-KR.
4. **Trình khởi chạy Eclipse không tìm thấy thư viện dùng chung**: Sửa đường dẫn `-startup` và `-launcher.library` trong `eclipse.ini`.

## Hướng dẫn bảo trì (GitHub Actions)

Kho lưu trữ này bao gồm một workflow GitHub Actions để kiểm thử tự động và triển khai thủ công.

### Kiểm thử tự động
Mỗi lần push hoặc pull request tới nhánh `main` sẽ kích hoạt kiểm thử xây dựng và cài đặt trên môi trường `windows-latest`.

### Triển khai thủ công (Deployment)
Để phát hành phiên bản mới lên Chocolatey Community Repository:
1. Chuyển đến tab **Actions** trong kho lưu trữ GitHub này.
2. Chọn workflow **Chocolatey Package Test**.
3. Nhấp vào **Run workflow**.
4. Chọn hộp kiểm **"Chocolatey에 패키지를 배포하시겠습니까?"** và nhấp vào **Run workflow**.
   - *Lưu ý: Yêu cầu thiết lập `CHOCOLATEY_API_KEY` trong Repository Secrets.*

## Giấy phép
eGovFrame được cấp phép theo giấy phép Apache 2.0.

## Liên hệ
Để biết thêm thông tin, vui lòng truy cập [Trang web chính thức của eGovFrame](https://www.egovframe.go.kr/).
