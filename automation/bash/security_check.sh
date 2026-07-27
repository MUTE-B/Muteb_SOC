#!/bin/bash


# =====================================================
# Muteb SOC Security Check
#
# الهدف:
# إجراء فحص أمني أساسي على نظام Linux
#
# الفحوصات:
# - Open Ports
# - Firewall Status
# - Failed Login Attempts
# - Active Network Services
# - Current User
# =====================================================



echo "Starting Security Check"


echo ""
echo "=============================="
echo "Current User"
echo "=============================="


whoami



echo ""
echo "=============================="
echo "Open Network Ports"
echo "=============================="


ss -tulnp



echo ""
echo "=============================="
echo "Firewall Status"
echo "=============================="


sudo ufw status



echo ""
echo "=============================="
echo "Failed Login Attempts"
echo "=============================="


if [ -f /var/log/auth.log ]
then

    grep "Failed password" /var/log/auth.log | wc -l

else

    echo "Authentication log file not found"

fi



echo ""
echo "=============================="
echo "Active Services"
echo "=============================="


systemctl --type=service --state=running



echo ""

echo "Security Check Completed"
#!/bin/bash


# =====================================================
# Muteb SOC Security Check Script
#
# الهدف:
# تنفيذ فحص أمني أساسي على نظام Linux
#
# يقوم السكربت بفحص:
# - Firewall
# - المستخدمين
# - محاولات الدخول الفاشلة
# - المنافذ المفتوحة
# - صلاحيات الملفات
#
# إنشاء تقرير أمني للاستخدام في SOC
# =====================================================



# إيقاف السكربت عند حدوث خطأ

set -e



# اسم ملف التقرير

REPORT="security_check_report.txt"



# حذف التقرير السابق

rm -f $REPORT



echo "=================================" >> $REPORT

echo "     Muteb SOC Security Check     " >> $REPORT

echo "=================================" >> $REPORT



echo "" >> $REPORT





# =====================================================
# فحص Firewall
# =====================================================


echo "[+] Firewall Status" >> $REPORT



ufw status verbose >> $REPORT 2>&1





# =====================================================
# معلومات المستخدمين
# =====================================================


echo "" >> $REPORT

echo "[+] User Accounts" >> $REPORT



cat /etc/passwd >> $REPORT





# =====================================================
# فحص محاولات SSH الفاشلة
# =====================================================


echo "" >> $REPORT

echo "[+] Failed SSH Login Attempts" >> $REPORT



grep "Failed password" /var/log/auth.log >> $REPORT 2>/dev/null || echo "No failed login detected" >> $REPORT





# =====================================================
# المستخدمون الذين لديهم صلاحيات sudo
# =====================================================


echo "" >> $REPORT

echo "[+] Sudo Users" >> $REPORT



getent group sudo >> $REPORT





# =====================================================
# المنافذ المفتوحة
# =====================================================


echo "" >> $REPORT

echo "[+] Open Network Ports" >> $REPORT



ss -tulpn >> $REPORT





# =====================================================
# البحث عن ملفات بصلاحية التنفيذ للجميع
# =====================================================


echo "" >> $REPORT

echo "[+] Dangerous File Permissions" >> $REPORT



find / -type f -perm -002 2>/dev/null >> $REPORT





# =====================================================
# حالة الخدمات
# =====================================================


echo "" >> $REPORT

echo "[+] Active Services" >> $REPORT



systemctl --type=service --state=running >> $REPORT





# =====================================================
# نهاية التقرير
# =====================================================


echo "" >> $REPORT

echo "Security Check Completed" >> $REPORT



echo "================================="

echo "Security Check Finished"

echo "Report saved: $REPORT"

echo "================================="
