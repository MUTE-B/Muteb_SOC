# Phishing Incident Response Playbook

---

# Incident Information

| Field | Value |
|-------|-------|
| Incident ID | |
| Detection Date | |
| Analyst | |
| Severity | Low / Medium / High / Critical |
| Status | Open / In Progress / Closed |

---

# Executive Summary

قم بكتابة ملخص يوضح تفاصيل رسالة التصيد، وعدد المستخدمين المتأثرين، والإجراءات الأولية التي تم اتخاذها.

---

# Detection Source

- Microsoft Defender
- Microsoft Sentinel
- Email Security Gateway
- Microsoft 365
- User Report
- Wazuh
- Splunk
- Other

---

# Email Information

| Field | Value |
|------|-------|
| Sender | |
| Recipient | |
| Subject | |
| Date | |
| Reply-To | |
| Return-Path | |
| Message-ID | |

---

# Indicators of Compromise (IOCs)

## Sender Email

-

## Reply-To Address

-

## URLs

-

## Domains

-

## IP Addresses

-

## Attachments

-

## SHA256 Hashes

-

---

# Initial Analysis

قم بتوثيق نتائج التحليل الأولي للرسالة.

- هل الرسالة تحتوي على روابط؟
- هل تحتوي على ملفات مرفقة؟
- هل تم فتح الرابط؟
- هل تم تحميل الملف؟
- هل تم إدخال بيانات اعتماد؟

---

# Containment

الإجراءات التي تم تنفيذها.

- حذف الرسالة من جميع الصناديق البريدية.
- حظر المرسل.
- حظر النطاق.
- حظر الرابط.
- عزل الجهاز المتأثر.
- إعادة تعيين كلمة المرور.
- إنهاء الجلسات النشطة.

---

# Eradication

الإجراءات المستخدمة لإزالة آثار الهجوم.

- حذف الملفات الخبيثة.
- إزالة المهام المجدولة.
- إزالة البرمجيات غير المرغوبة.
- تحديث النظام.
- تحديث برنامج الحماية.

---

# Recovery

خطوات إعادة الخدمة.

- إعادة الجهاز للعمل.
- مراقبة الحساب.
- مراجعة سجلات تسجيل الدخول.
- التحقق من عدم وجود نشاط إضافي.

---

# MITRE ATT&CK Mapping

| Technique | ID |
|-----------|----|
| Phishing | T1566 |
| Spearphishing Attachment | T1566.001 |
| Spearphishing Link | T1566.002 |

---

# Timeline

| Time | Activity |
|------|----------|
| | |

---

# Evidence

| Evidence | Location |
|----------|----------|
| | |

---

# Commands Executed

```bash

```

---

# Lessons Learned

- كيف نجح الهجوم؟
- لماذا لم يتم اكتشافه مبكرًا؟
- ما الضوابط الأمنية المطلوب تحسينها؟
- ما التوصيات الخاصة بتوعية المستخدمين؟

---

# Final Recommendation

- تفعيل MFA لجميع الحسابات.
- تطبيق سياسات DMARC وSPF وDKIM.
- توعية المستخدمين بشكل دوري.
- حظر المرفقات الخطرة.
- استخدام بوابة حماية البريد الإلكتروني.
- مراقبة سجلات Microsoft 365 بشكل مستمر.

---

# Analyst Approval

| Name | Role | Signature |
|------|------|-----------|
| | | |ransomware_template.md
insider_threat.md
