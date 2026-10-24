# إرشادات إصدار حزمة Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/flat.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

يوضح هذا المستند الإجراءات والمتطلبات للإصدار الرسمي والتوزيع والتحقق من حزمة `egovframe` على Chocolatey.

## إعداد حساب Chocolatey.org

لتوزيع الحزم في مستودع مجتمع Chocolatey، تحتاج إلى حساب على Chocolatey.org ومفتاح API.

1. أنشئ حسابًا على [Chocolatey.org](https://community.chocolatey.org/) وأكمل التحقق من البريد الإلكتروني.
2. احصل على مفتاح API من [صفحة إدارة مفاتيح API](https://community.chocolatey.org/account).
3. أضفه كـ Repository Secret باسم `CHOCOLATEY_API_KEY` في **Settings > Secrets and variables > Actions** في هذا المستودع.

## إجراءات إصدار نسخة جديدة

عند الإعلان رسميًا عن إصدار جديد من eGovFrame، قم بتحديث الحزمة بالخطوات التالية:

### 1. تحديث البيانات الوصفية للحزمة
افتح `egovframe.nuspec` وقم بتحديث:
- `<version>`: رقم الإصدار الجديد (مثال: `5.0.2`)
- `<releaseNotes>`: ملخص تغييرات الإصدار

### 2. التحقق من نص التثبيت وتحديثه
افتح `tools/chocolateyinstall.ps1` وقم بتحديث عناوين URL للتنزيل وتجزئات SHA-256:
- تحقق من عنوان URL للتنزيل والمجموع الاختباري SHA-256 لأحدث ملف ZIP من [صفحة تنزيل بوابة eGovFrame الرسمية](https://www.egovframe.go.kr/home/sub.do?menuNo=40).
- `url64`: عنوان URL لأحدث ملف ZIP لبيئة تطوير 64 بت
- `checksum64`: المجموع الاختباري SHA-256 المعلن رسميًا

### 3. بناء الحزمة واختبارها محليًا
```shell
# بناء الحزمة (إنشاء .nupkg)
choco pack

# اختبار التثبيت من المصدر المحلي
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. الفحص المسبق للبرامج الضارة (`malware-scan.yml`)
لإثبات مصدر وأمان ملف ZIP الرسمي (~1 جيجابايت) مسبقًا، قم بتشغيل سير عمل **Malware Scan**:
1. انتقل إلى علامة التبويب **Actions** في هذا المستودع.
2. حدد سير عمل **Malware Scan** وانقر على **Run workflow**.
3. ينتج سير العمل هذا ثلاثة أدلة:
   - **المصدر (Provenance)**: مقارنة SHA-256 مع تجزئات MD5/SHA1 المنشورة على البوابة
   - **Microsoft Defender**: فحص كامل مع توقيعات محدثة (يشمل عينة EICAR القياسية)
   - **ClamAV**: فحص كامل مع توقيعات محدثة (يشمل عينة EICAR القياسية)

## نشر الحزمة (Deployment)

توجد طريقتان لنشر الحزمة.

### الطريقة 1: النشر الآلي عبر GitHub Actions (موصى بها)
1. انتقل إلى علامة التبويب **Actions** في هذا المستودع.
2. حدد سير عمل **Chocolatey Package Test**.
3. انقر فوق **Run workflow**.
4. حدد خانة الاختيار **"Chocolatey에 패키지를 배포하시겠습니까?"** ثم انقر فوق **Run workflow**.
5. بعد اجتياز اختبارات البناء والتثبيت، سيتم رفع الحزمة تلقائيًا باستخدام `CHOCOLATEY_API_KEY`.

### الطريقة 2: النشر اليدوي المحلي (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## انتهاء مهلة أداة التحقق الآلي وطلب الإعفاء

أثناء التثبيت، تقوم الحزمة بتنزيل ملف ZIP رسمي (~1 جيجابايت). تحدد أداة التحقق التلقائية أوامر التثبيت وإلغاء التثبيت بـ **20 دقيقة** لكل منها ([التوثيق الرسمي](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### إرشادات طلب الإعفاء
- إذا فشل التحقق بسبب تجاوز المهلة المحددة (20 دقيقة)، يجب الرد خلال **15 يومًا** في تعليقات المراجعة لطلب **إعفاء من التحقق (exempt)**.
- قم بإرفاق الأدلة التالية في تعليقك:
  1. **نتائج اختبارات GitHub Actions**: مدة التثبيت الفعلية المسجلة في ملخص سير عمل `test.yml`
  2. **نتائج فحص الأمان**: مطابقة تجزئات MD5/SHA1 ونتائج فحص Defender / ClamAV من `malware-scan.yml`
  3. سجلات الاختبار الناجح في **Chocolatey Test Environment (Vagrant)**
