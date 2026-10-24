# Đóng góp cho gói Chocolatey eGovFrame

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/flat.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](CONTRIBUTING.fr.md)

## Trước khi mở pull request

Kiểm tra việc đóng gói và cài đặt cục bộ bằng Chocolatey:

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

Workflow CI (`test.yml`) chạy trên `windows-latest` để xác minh việc đóng gói và cài đặt.

- Các điểm vào tài liệu được tạo tự động: chỉnh sửa các nguồn trong `docs/`, sau đó chạy `python3 scripts/sync_readme.py` để làm mới `README.md`, `release-guidelines.md` và `.github/`.

## Security

Không báo cáo lỗ hổng trong issue công khai; vui lòng làm theo quy trình trong [SECURITY.vi.md](../security/SECURITY.vi.md).
