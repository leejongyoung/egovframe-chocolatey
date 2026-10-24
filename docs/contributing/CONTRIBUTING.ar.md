# المساهمة في حزمة Chocolatey لـ eGovFrame

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](CONTRIBUTING.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](CONTRIBUTING.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](CONTRIBUTING.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](CONTRIBUTING.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/flat.svg)](CONTRIBUTING.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](CONTRIBUTING.fr.md)

## قبل فتح طلب سحب

اختبر بناء الحزمة وتثبيتها محليًا باستخدام Chocolatey:

```shell
choco pack
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

يعمل سير عمل CI (`test.yml`) على `windows-latest` للتحقق من بناء الحزمة وتثبيتها.

- يتم إنشاء نقاط الدخول للتوثيق تلقائيًا: قم بتعديل المصادر في `docs/` ثم شغّل `python3 scripts/sync_readme.py` لتحديث `README.md` و `chocolatey-package-official-release-guidelines.md` ونقاط دخول `.github/`.

## Security

لا تبلغ عن الثغرات الأمنية في المشكلات العامة؛ اتبع الإجراء في [SECURITY.ar.md](../security/SECURITY.ar.md).
