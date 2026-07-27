#!/bin/bash

# ==========================================================
# الملف:
# ssh_audit.sh
#
# الهدف:
# إجراء تدقيق كامل لخدمة SSH.
#
# يقوم هذا السكربت بعرض:
#
# - حالة خدمة SSH
# - إصدار SSH
# - ملف الإعدادات
# - المنافذ المستخدمة
# - المستخدمين المسموح لهم
# - المفاتيح العامة
# - آخر عمليات تسجيل الدخول
# - محاولات الدخول الفاشلة
#
# يستخدم أثناء مراجعة خوادم Linux
# وتحليل الحوادث الأمنية داخل SOC.
# ==========================================================


set -e


# ----------------------------------------------------------
# تحديد المجلد الرئيسي للمشروع
# ----------------------------------------------------------

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"


# ----------------------------------------------------------
# تحديد مجلد التقارير
# ----------------------------------------------------------

REPORT_DIR="$PROJECT_ROOT/reports"


# ----------------------------------------------------------
# تحديد اسم التقرير
# ----------------------------------------------------------

REPORT_FILE="$REPORT_DIR/ssh_audit_report.txt"


# ----------------------------------------------------------
# إنشاء مجلد التقارير
# ----------------------------------------------------------

mkdir -p "$REPORT_DIR"


# ----------------------------------------------------------
# إنشاء التقرير
# ----------------------------------------------------------

{

echo "============================================================"

echo "                   SSH Audit Report"

echo "============================================================"

echo

echo "Generated : $(date)"

echo

echo "Hostname"

echo "------------------------------------------------------------"

hostname

echo

echo "SSH Service Status"

echo "------------------------------------------------------------"

systemctl status ssh --no-pager 2>/dev/null || echo "SSH service is not installed."

echo

echo "SSH Version"

echo "------------------------------------------------------------"

ssh -V 2>&1

echo

echo "SSH Configuration"

echo "------------------------------------------------------------"

if [ -f /etc/ssh/sshd_config ]; then

    grep -Ev "^[[:space:]]*#|^[[:space:]]*$" /etc/ssh/sshd_config

else

    echo "sshd_config not found."

fi

echo

echo "Listening SSH Ports"

echo "------------------------------------------------------------"

ss -tlnp | grep ssh || true

echo

echo "Authorized Keys"

echo "------------------------------------------------------------"

find /home -name authorized_keys -exec ls -lh {} \; 2>/dev/null

echo

echo "PermitRootLogin"

echo "------------------------------------------------------------"

grep "^PermitRootLogin" /etc/ssh/sshd_config 2>/dev/null || true

echo

echo "PasswordAuthentication"

echo "------------------------------------------------------------"

grep "^PasswordAuthentication" /etc/ssh/sshd_config 2>/dev/null || true

echo

echo "AllowUsers"

echo "------------------------------------------------------------"

grep "^AllowUsers" /etc/ssh/sshd_config 2>/dev/null || true

echo

echo "Last Successful Logins"

echo "------------------------------------------------------------"

last | head -20

echo

echo "Failed Login Attempts"

echo "------------------------------------------------------------"

grep "Failed password" /var/log/auth.log 2>/dev/null | tail -50 || true

echo

echo "Successful Login Attempts"

echo "------------------------------------------------------------"

grep "Accepted password" /var/log/auth.log 2>/dev/null | tail -50 || true

echo

echo "============================================================"

echo "SSH Audit Completed Successfully"

echo "============================================================"

} > "$REPORT_FILE"


# ----------------------------------------------------------
# عرض ملخص التنفيذ
# ----------------------------------------------------------

echo

echo "============================================================"

echo "SSH audit completed successfully."

echo

echo "Report saved to:"

echo

echo "$REPORT_FILE"

echo

echo "============================================================"
