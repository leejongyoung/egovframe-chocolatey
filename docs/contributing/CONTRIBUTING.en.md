# Contributing to eGovFrame Chocolatey Package

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/flat.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](CONTRIBUTING.fr.md)

## Before opening a pull request

Test your package build and installation locally using Chocolatey:

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

The CI workflow (`test.yml`) runs on `windows-latest` to verify package build and installation.

- Documentation entrypoints are generated: edit the `docs/` sources, then run `python3 scripts/sync_readme.py` to refresh `README.md`, `chocolatey-package-official-release-guidelines.md`, and the `.github/` entrypoints.

## Security

Do not report vulnerabilities in issues; follow the process in [SECURITY.en.md](../security/SECURITY.en.md).
