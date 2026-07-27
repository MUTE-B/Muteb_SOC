# Insider Threat Incident Response Playbook

---

# Incident Information

| Field | Value |
|-------|-------|
| Incident ID | |
| Detection Date | |
| Analyst | |
| Severity | Medium / High / Critical |
| Status | Open / In Progress / Closed |

---

# Executive Summary

قم بتوثيق ملخص الحادث، مع توضيح طبيعة التهديد الداخلي، والأصول المتأثرة، والإجراءات الأولية المتخذة.

---

# Detection Source

- SIEM
- UEBA
- Microsoft Sentinel
- Wazuh
- Microsoft Defender
- Audit Logs
- User Report
- HR Notification
- Other

---

# Suspected User

| Field | Value |
|------|-------|
| Username | |
| Full Name | |
| Department | |
| Job Title | |
| Manager | |
| Account Status | |

---

# Affected Assets

| Asset | Hostname | IP Address | Owner |
|-------|----------|------------|-------|
| | | | |

---

# Indicators of Suspicious Activity

## Unauthorized Access

-

## Privilege Misuse

-

## Sensitive File Access

-

## Data Exfiltration

-

## USB Device Usage

-

## Cloud Storage Activity

-

## Email Activity

-

## Remote Access

-

---

# Initial Investigation

قم بتوثيق نتائج التحليل الأولي.

- مراجعة سجلات تسجيل الدخول.
- مراجعة صلاحيات المستخدم.
- مراجعة الوصول إلى الملفات.
- مراجعة عمليات النسخ والطباعة.
- مراجعة استخدام البريد الإلكتروني.
- مراجعة استخدام أجهزة USB.
- مراجعة نشاط VPN.

---

# Containment

الإجراءات التي تم تنفيذها.

- تعطيل الحساب.
- إعادة تعيين كلمة المرور.
- إنهاء الجلسات النشطة.
- عزل الجهاز.
- إلغاء الصلاحيات الإدارية.
- حظر الوصول عن بعد.
- حفظ الأدلة الرقمية.

---

# Eradication

- إزالة الصلاحيات غير الضرورية.
- حذف الحسابات غير المستخدمة.
- إزالة البرامج غير المصرح بها.
- تحديث السياسات الأمنية.
- تحديث الأنظمة.

---

# Recovery

- إعادة تفعيل الحساب إذا ثبتت سلامته.
- إعادة الجهاز للعمل.
- مراقبة النشاط لفترة زمنية.
- مراجعة السجلات الأمنية.
- التحقق من سلامة البيانات.

---

# Evidence

| Evidence | Location |
|----------|----------|
| | |

---

# MITRE ATT&CK Mapping

| Technique | ID |
|-----------|----|
| Valid Accounts | T1078 |
| Exfiltration | T1020 |
| Account Discovery | T1087 |
| File and Directory Discovery | T1083 |

---

# Timeline

| Time | Activity |
|------|----------|
| | |

---

# Commands Executed

```bash

```

---

# Lessons Learned

## Root Cause

-

## Security Weaknesses

-

## Required Improvements

-

## Policy Changes

-

---

# Final Recommendation

- تطبيق مبدأ أقل الصلاحيات (Least Privilege).
- مراجعة صلاحيات المستخدمين بشكل دوري.
- تفعيل MFA.
- مراقبة الأنشطة غير الطبيعية باستخدام UEBA.
- تفعيل تسجيل الأحداث (Audit Logging).
- مراجعة الحسابات غير المستخدمة بشكل دوري.
- تنفيذ برامج توعية أمنية للموظفين.
- مراجعة سياسات الوصول إلى البيانات الحساسة.

---

# Analyst Approval

| Name | Role | Signature |
|------|------|-----------|
| | | |
