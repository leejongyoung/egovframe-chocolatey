# إرشادات الإصدار الرسمي لحزمة Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/flat.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

يوضح هذا الدليل الإجراءات والمتطلبات للإصدار الرسمي لحزمة Chocolatey.

## إنشاء حساب على Chocolatey.org
لتوزيع حزم Chocolatey، يجب أن تمتلك حسابًا على Chocolatey.org.

### الخطوات
1. قم بزيارة موقع Chocolatey.org وإنشاء حساب.
2. تفعيل الحساب عبر رسالة التأكيد المرسلة إلى بريدك الإلكتروني.

## تكوين البيانات الوصفية للحزمة
تتضمن البيانات الوصفية الاسم والإصدار والوصف والمؤلفين وما إلى ذلك. راجع ملف `egovframe.nuspec`.

### الحقول المطلوبة
```
- ID: المعرف الفريد للحزمة (مثال: egovframe)
- Version: إصدار الحزمة (مثال: 5.0.2)
- Title: عنوان الحزمة
- Authors: مؤلفو الحزمة
- Owners: مالكو الحزمة
- Description: وصف تفصيلي للحزمة
- LicenseUrl: عنوان URL للترخيص (مثال: ترخيص Apache 2.0)
- ProjectUrl: عنوان URL لصفحة المشروع
- Tags: الكلمات المفتاحية التي تصف الحزمة
```

## بناء الحزمة واختبارها

### البناء
```shell
choco pack
```

### الاختبار
```shell
choco install egovframe --version=5.0.2
```

## إنشاء مفتاح API ورفع الحزمة

### إنشاء مفتاح API
1. انتقل إلى [صفحة إدارة مفاتيح API](https://community.chocolatey.org/account).
2. انسخ مفتاح API.

### رفع الحزمة
```shell
choco apikey --key <API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### مراجعة الحزمة والموافقة عليها
يقوم فريق Chocolatey بمراجعة الكود والبيانات الوصفية والتبعيات. يستغرق ذلك عادة من بضع ساعات إلى بضعة أيام.

### انتهاء مهلة أداة التحقق الآلي وطلب الإعفاء
تقوم هذه الحزمة بتنزيل ملف zip الرسمي (حوالي 1 جيجابايت) أثناء التثبيت. تحدد أداة التحقق التلقائية أوامر التثبيت/إلغاء التثبيت بـ **20 دقيقة** لكل منها.
- في حال فشل التحقق بسبب المهلة، اطلب **إعفاء من أداة التحقق (exempt)** في تعليقات المراجعة، مع إرفاق نتائج اختبارات GitHub Actions وبيئة اختبار Chocolatey.
- يجب الرد خلال 15 يومًا لتجنب الرفض التلقائي.

### تحديث الحزمة
```shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
