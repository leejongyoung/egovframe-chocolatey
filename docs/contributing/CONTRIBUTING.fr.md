# Contribuer au package Chocolatey eGovFrame

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/flat.svg)](CONTRIBUTING.fr.md)

## Avant d'ouvrir une pull request

Testez la création et l'installation du package localement à l'aide de Chocolatey :

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

Le workflow CI (`test.yml`) s'exécute sur `windows-latest` pour vérifier la compilation et l'installation.

- Les points d'entrée de la documentation sont générés : modifiez les sources dans `docs/`, puis exécutez `python3 scripts/sync_readme.py` pour actualiser `README.md`, `chocolatey-package-official-release-guidelines.md` et `.github/`.

## Security

Ne signalez pas les vulnérabilités dans les issues publiques ; suivez la procédure décrite dans [SECURITY.fr.md](../security/SECURITY.fr.md).
