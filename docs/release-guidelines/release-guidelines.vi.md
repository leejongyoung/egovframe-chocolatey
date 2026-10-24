# Hướng dẫn phát hành gói Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/flat.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

Tài liệu này giải thích quy trình và yêu cầu để phát hành, phân phối và xác minh chính thức gói Chocolatey `egovframe`.

## Chuẩn bị tài khoản Chocolatey.org

Để phân phối gói lên Chocolatey Community Repository, bạn cần có tài khoản Chocolatey.org và API key.

1. Tạo tài khoản tại [Chocolatey.org](https://community.chocolatey.org/) và hoàn tất xác thực email.
2. Lấy API key từ [Trang quản lý API Key](https://community.chocolatey.org/account).
3. Đăng ký thành Repository Secret tên là `CHOCOLATEY_API_KEY` trong **Settings > Secrets and variables > Actions** của kho lưu trữ GitHub này.

## Quy trình phát hành phiên bản mới

Khi phiên bản eGovFrame mới được công bố chính thức, hãy cập nhật gói theo các bước sau:

### 1. Cập nhật siêu dữ liệu gói
Mở `egovframe.nuspec` và cập nhật:
- `<version>`: Số phiên bản mới (ví dụ: `5.0.2`)
- `<releaseNotes>`: Tóm tắt các thay đổi trong bản phát hành

### 2. Xác minh và cập nhật script cài đặt
Mở `tools/chocolateyinstall.ps1` và cập nhật URL tải xuống cùng mã băm SHA-256:
- Kiểm tra URL tải xuống và mã băm SHA-256 của tệp ZIP mới nhất từ [Trang tải xuống cổng eGovFrame](https://www.egovframe.go.kr/home/sub.do?menuNo=40).
- `url64`: URL tệp ZIP môi trường phát triển 64-bit mới nhất
- `checksum64`: Mã băm SHA-256 chính thức

### 3. Đóng gói và kiểm thử cục bộ
```shell
# Đóng gói (.nupkg)
choco pack

# Kiểm thử cài đặt từ nguồn cục bộ
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. Quét mã độc trước phát hành (`malware-scan.yml`)
Để chứng minh nguồn gốc và tính bảo mật của tệp ZIP chính thức (~1 GB), hãy chạy workflow **Malware Scan**:
1. Chuyển đến tab **Actions** trong kho lưu trữ GitHub này.
2. Chọn workflow **Malware Scan** và nhấp vào **Run workflow**.
3. Workflow này tạo ra ba bằng chứng:
   - **Nguồn gốc (Provenance)**: So sánh SHA-256 từ script cài đặt với mã băm MD5/SHA1 được công bố
   - **Microsoft Defender**: Quét toàn bộ với cơ sở dữ liệu mới nhất (bao gồm kiểm soát dương EICAR)
   - **ClamAV**: Quét toàn bộ với cơ sở dữ liệu mới nhất (bao gồm kiểm soát dương EICAR)

## Phân phối gói (Deployment)

Có hai phương pháp để phân phối gói.

### Phương pháp 1: Phân phối tự động qua GitHub Actions (Khuyến nghị)
1. Chuyển đến tab **Actions** trong kho lưu trữ GitHub này.
2. Chọn workflow **Chocolatey Package Test**.
3. Nhấp vào **Run workflow**.
4. Chọn hộp kiểm **"Chocolatey에 패키지를 배포하시겠습니까?"** và nhấp vào **Run workflow**.
5. Sau khi vượt qua kiểm thử trên môi trường Windows, gói sẽ tự động được đẩy lên kho cộng đồng bằng `CHOCOLATEY_API_KEY`.

### Phương pháp 2: Phân phối thủ công cục bộ (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## Quá thời gian xác minh tự động và yêu cầu miễn trừ

Gói này tải tệp ZIP chính thức (~1 GB) trong khi cài đặt. Trình xác minh gói Chocolatey giới hạn các lệnh cài đặt và gỡ cài đặt ở mức **20 phút** mỗi lệnh ([tài liệu chính thức](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### Hướng dẫn yêu cầu miễn trừ
- Nếu xác minh thất bại do vượt quá thời gian 20 phút, hãy phản hồi trong vòng **15 ngày** trong phần bình luận đánh giá để yêu cầu **miễn trừ xác minh (exempt)**.
- Đính kèm các bằng chứng sau vào bình luận:
  1. **Kết quả kiểm thử GitHub Actions**: Thời gian cài đặt thực tế ghi trong tóm tắt workflow `test.yml`
  2. **Kết quả quét bảo mật**: Đối chiếu mã băm MD5/SHA1 và kết quả quét Defender / ClamAV từ `malware-scan.yml`
  3. Nhật ký kiểm thử thành công trên **Chocolatey Test Environment (Vagrant)**
