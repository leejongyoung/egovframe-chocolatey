# eGovFrame Chocolatey 패키지 기여 안내

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/flat.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](CONTRIBUTING.fr.md)

## 풀 리퀘스트를 열기 전에

Chocolatey를 사용하여 로컬에서 패키지 빌드 및 설치를 테스트하세요:

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

CI 워크플로우(`test.yml`)는 `windows-latest` 환경에서 패키지 빌드 및 설치를 자동으로 검증합니다.

- 문서 진입점은 자동 생성됩니다. `docs/`의 원본을 수정한 뒤 `python3 scripts/sync_readme.py`를 실행해 `README.md`, `release-guidelines.md`, `.github/` 진입점을 갱신하세요.

## Security

보안 취약점은 공개 이슈로 등록하지 마시고 [SECURITY.ko.md](../security/SECURITY.ko.md)의 절차를 따라주세요.
