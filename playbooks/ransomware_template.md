# Ransomware Incident Response Playbook

---

# Incident Information

| Field | Value |
|-------|-------|
| Incident ID | |
| Detection Date | |
| Analyst | |
| Severity | High / Critical |
| Status | Open / In Progress / Closed |

---

# Executive Summary

قم بتوثيق ملخص الحادث، مع توضيح نطاق الإصابة، والأنظمة المتأثرة، والإجراءات العاجلة التي تم تنفيذها.

---

# Detection Source

- EDR
- Antivirus
- SIEM
- Microsoft Sentinel
- Wazuh
- User Report
- File Integrity Monitoring
- Other

---

# Incident Scope

| Asset | Hostname | IP Address | Status |
|-------|----------|------------|--------|
| | | | |

---

# Initial Indicators

## Ransom Note

-

## Encrypted File Extension

-

## Ransomware Family

-

## File Hashes

-

## IP Addresses

-

## Domains

-

## Wallet Address

-

---

# Indicators of Compromise (IOCs)

## File Names

-

## File Paths

-

## SHA256

-

## Registry Keys

-

## Scheduled Tasks

-

## Services

-

## Processes

-

---

# Immediate Containment

نفذ الإجراءات التالية إذا كانت مناسبة للحادث.

- عزل الأجهزة المصابة.
- فصل الأجهزة عن الشبكة.
- تعطيل الحسابات المتأثرة.
- إيقاف المشاركة الشبكية.
- حظر عناوين IP المشبوهة.
- حفظ الأدلة الرقمية.
- عدم حذف الملفات قبل اكتمال التحقيق.

---

# Eradication

- إزالة البرمجية الخبيثة.
- حذف الخدمات الضارة.
- إزالة المهام المجدولة.
- تحديث النظام.
- تحديث برامج الحماية.
- تغيير كلمات المرور.
- التحقق من عدم وجود Backdoor.

---

# Recovery

- استعادة الملفات من النسخ الاحتياطية.
- اختبار الأنظمة.
- إعادة الخدمات.
- مراقبة النظام.
- التأكد من إزالة جميع مؤشرات الإصابة.

---

# Business Impact

| Item | Description |
|------|-------------|
| Downtime | |
| Affected Users | |
| Critical Systems | |
| Data Loss | |
| Financial Impact | |

---

# MITRE ATT&CK Mapping

| Technique | ID |
|-----------|----|
| Data Encrypted for Impact | T1486 |
| Inhibit System Recovery | T1490 |
| Service Stop | T1489 |

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

## Root Cause

-

## Security Gaps

-

## Required Improvements

-

## Preventive Controls

-

---

# Final Recommendation

- تطبيق مبدأ أقل الصلاحيات (Least Privilege).
- استخدام MFA للحسابات الحساسة.
- تفعيل النسخ الاحتياطية غير المتصلة (Offline Backups).
- اختبار النسخ الاحتياطية بشكل دوري.
- تحديث الأنظمة باستمرار.
- تفعيل مراقبة سلامة الملفات (FIM).
- مراجعة التنبيهات الأمنية بشكل يومي.
- تدريب الموظفين على التصيد الإلكتروني والهندسة الاجتماعية.

---

# Analyst Approval

| Name | Role | Signature |
|------|------|-----------|
| | | |insider_threat.md
