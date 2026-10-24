# Hướng dẫn phát hành chính thức gói Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/flat.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

Tài liệu này giải thích quy trình và yêu cầu để phát hành chính thức gói Chocolatey.

## Tạo tài khoản Chocolatey.org
Để phân phối gói Chocolatey, bạn cần có tài khoản tại Chocolatey.org.

### Quy trình
1. Truy cập trang web Chocolatey.org và đăng ký tài khoản.
2. Kích hoạt tài khoản qua email xác nhận.

## Thiết lập siêu dữ liệu gói
Siêu dữ liệu gói bao gồm tên, phiên bản, mô tả, tác giả, v.v. Tham khảo tệp `egovframe.nuspec`.

### Các trường bắt buộc
```
- ID: Mã định danh duy nhất (ví dụ: egovframe)
- Version: Phiên bản gói (ví dụ: 5.0.2)
- Title: Tiêu đề gói
- Authors: Tác giả gói
- Owners: Chủ sở hữu gói
- Description: Mô tả chi tiết gói
- LicenseUrl: URL giấy phép (ví dụ: Apache 2.0 License)
- ProjectUrl: URL trang chủ dự án
- Tags: Từ khóa mô tả gói
```

## Đóng gói và kiểm thử

### Đóng gói
```shell
choco pack
```

### Kiểm thử
```shell
choco install egovframe --version=5.0.2
```

## Tạo API Key và tải gói lên

### Tạo API Key
1. Truy cập [Trang quản lý API Key](https://community.chocolatey.org/account).
2. Sao chép API Key.

### Tải gói lên
```shell
choco apikey --key <API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### Xem xét và phê duyệt gói
Đội ngũ Chocolatey sẽ xem xét mã, siêu dữ liệu và các phần phụ thuộc. Quá trình này thường mất vài giờ đến vài ngày.

### Quá thời gian xác minh tự động (verifier) và yêu cầu miễn trừ
Gói này tải tệp zip chính thức (khoảng 1 GB) khi cài đặt. Trình xác minh tự động giới hạn lệnh cài đặt/gỡ cài đặt ở mức **20 phút** mỗi lệnh.
- Nếu xác minh hết thời gian chờ, hãy yêu cầu **miễn trừ xác minh (exempt)** trong phần bình luận đánh giá. Cung cấp kết quả kiểm thử từ GitHub Actions và Chocolatey Test Environment.
- Phản hồi trong vòng 15 ngày kể từ khi nhận thông báo lỗi để tránh bị từ chối tự động.

### Cập nhật gói
```shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
