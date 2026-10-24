# حزمة Chocolatey لـ eGovFrame

<!-- latest-badge:start -->
[![الإطار القياسي للحكومة الإلكترونية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/unversioned/flat-ar.svg)](https://www.egovframe.go.kr/)
[![Chocolatey Package Test](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
<!-- latest-badge:end -->

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](README.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](README.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](README.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](README.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/flat.svg)](README.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](README.fr.md)

## مقدمة
مرحبًا بك في حزمة Chocolatey الخاصة بـ eGovFrame. إن Chocolatey هو مدير حزم لنظام Windows يتيح للمستخدمين تثبيت البرامج بسهولة عبر سطر الأوامر. توفر هذه الحزمة طريقة بسيطة لتثبيت eGovFrame، وهو إطار عمل مفتوح المصدر طورته حكومة كوريا الجنوبية. تم تصميم eGovFrame لتطوير تطبيقات القطاع العام ويُستخدم على نطاق واسع كمنصة معيارية لمشاريع تكنولوجيا المعلومات في كوريا.

- [الحزمة الرسمية على Chocolatey](https://community.chocolatey.org/packages/egovframe)

## حول eGovFrame
- **الاسم**: eGovFrame (الإطار القياسي للحكومة الإلكترونية)
- **الإصدار**: 5.0.2 (بيئة تطوير لنظام Windows 64 بت، Eclipse 2025-03، Java 21)
- **الوصف**: eGovFrame هو إطار عمل مفتوح المصدر توفره حكومة كوريا الجنوبية لتطوير الخدمات العامة القائمة على الويب. تم بناؤه باستخدام Java وإطار عمل Spring.
- **الموقع الإلكتروني**: [الموقع الرسمي لـ eGovFrame](https://www.egovframe.go.kr/)

## دليل التثبيت

### تثبيت eGovFrame عبر Chocolatey

بمجرد تثبيت Chocolatey، يمكنك بسهولة تثبيت eGovFrame عن طريق تشغيل الأمر التالي في PowerShell أو موجه الأوامر:

```shell
choco install egovframe
```

لتثبيت هذا الإصدار المحدد:
```shell
choco install egovframe --version=5.0.2
```

### مسار تثبيت التطبيق
بشكل افتراضي، يتم تثبيت eGovFrame في موقع أدوات Chocolatey، `C:\tools\eGovFrame` (`$env:ChocolateyToolsLocation\eGovFrame`). يتم استخدام هذا المسار بدلاً من Program Files لكي تظل تحديثات إضافات Eclipse ومشاريعك قابلة للكتابة دون الحاجة إلى صلاحيات المسؤول.

| المجلد | المحتوى |
|---|---|
| `eclipse` | Eclipse IDE (يتم استبداله عند الترقية) |
| `workspace-egov` | مساحة عمل مهيأة مسبقًا ببيئة منظور eGovFrame (**لا يتم استبدالها أبدًا عند الترقية، وتُحفظ عند إزالة التثبيت**) |
| `notice` | ملاحظات تصحيح Amateras Modeler |

تقوم الحزمة بتنزيل الملف الرسمي `eGovFrameDev-5.0.2-Windows-64bit.zip` (حوالي 1.04 جيجابايت)، والتحقق من المجموع الاختباري SHA-256، ثم تثبيته. يعتمد وقت التثبيت على سرعة الشبكة والقرص لديك.

## الإعداد بعد التثبيت

1. **اختصار سطح المكتب**: بعد التثبيت، يتم إنشاء اختصار لـ `eGovFrame` على سطح المكتب. يمكنك أيضًا تشغيل `C:\tools\eGovFrame\eclipse\eclipse.exe` مباشرة.
2. **مساحة العمل**: يختار المشغل مسبقًا المسار `C:\tools\eGovFrame\workspace-egov`. قم بتأكيد المسار وانقر فوق Launch.
3. **Java**: يأتي eGovFrame 5.0.2 مع بيئة تشغيل Java 21 خاصة به، لذلك يبدأ Eclipse بدون الحاجة إلى JDK منفصل، وهذه الحزمة لا تعتمد على Java. إذا كانت أدوات البناء الخاصة بك (Maven, Gradle, ...) بحاجة إلى JDK 21 في سطر الأوامر، فقم بتثبيته بشكل منفصل، مثل `choco install temurin21`.

## استكشاف الأخطاء وإصلاحها (Troubleshooting)

1. **خطأ JVM ("Failed to create the Java Virtual Machine")**:
   قم بتحرير `eclipse\eclipse.ini` في مجلد التثبيت وأضف المسار إلى JDK 21 الخاص بك:
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **مشاكل ترميز الأحرف**:
   لتجنب تلف الأحرف الكورية، أضف `-Dfile.encoding=UTF-8` إلى ملف `eclipse.ini` الخاص بك.
3. **أحرف غير مقروءة في ملف DML الخاص بالقالب**: قم بتغيير ترميز ملف DML المتأثر إلى EUC-KR.
4. **مشغل Eclipse لا يجد مكتبته المشتركة**: أصلح المسارين `-startup` و `-launcher.library` في `eclipse.ini`.

## دليل الصيانة (GitHub Actions)

يتضمن هذا المستودع سير عمل GitHub Actions للاختبار الآلي والنشر اليدوي.

### الاختبار الآلي
كل push أو pull request إلى فرع `main` يؤدي إلى تشغيل اختبار البناء والتثبيت على بيئة `windows-latest`.

### النشر اليدوي (Deployment)
لنشر إصدار جديد في مستودع مجتمع Chocolatey:
1. انتقل إلى علامة التبويب **Actions** في مستودع GitHub هذا.
2. حدد سير العمل **Chocolatey Package Test**.
3. انقر على **Run workflow**.
4. حدد خانة الاختيار **"Chocolatey에 패키지를 배포하시겠습니까?"** ثم انقر فوق **Run workflow**.
   - *ملاحظة: يتطلب تعيين `CHOCOLATEY_API_KEY` في Repository Secrets.*

## الترخيص
يخضع eGovFrame لترخيص Apache 2.0.

## جهة الاتصال
لمزيد من المعلومات، تفضل بزيارة [الموقع الرسمي لـ eGovFrame](https://www.egovframe.go.kr/).
