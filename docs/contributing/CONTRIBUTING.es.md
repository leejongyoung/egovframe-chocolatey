# Contribución al paquete Chocolatey de eGovFrame

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/flat.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](CONTRIBUTING.fr.md)

## Antes de abrir un pull request

Pruebe la compilación e instalación del paquete localmente con Chocolatey:

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

El flujo de trabajo CI (`test.yml`) se ejecuta en `windows-latest` para verificar la compilación e instalación.

- Los puntos de entrada de documentación se generan: edite las fuentes en `docs/` y ejecute `python3 scripts/sync_readme.py` para actualizar `README.md`, `release-guidelines.md` y `.github/`.

## Security

No informe vulnerabilidades en issues públicos; siga el proceso en [SECURITY.es.md](../security/SECURITY.es.md).
