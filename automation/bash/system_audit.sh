#!/bin/bash


# =====================================================
# Muteb SOC System Audit
#
# الهدف:
# جمع معلومات النظام الأساسية
#
# المعلومات:
# - Kernel
# - CPU
# - Memory
# - Storage
# - Network
# - Users
# =====================================================



echo "Starting System Audit"


echo ""

echo "System Hostname"

hostname



echo ""

echo "Kernel Information"

uname -r



echo ""

echo "CPU Information"

lscpu | grep "Model name"



echo ""

echo "Memory Information"

free -h



echo ""

echo "Disk Information"

df -h



echo ""

echo "Network Information"

ip addr



echo ""

echo "Current Users"

who



echo ""

echo "Audit Completed"
#!/bin/bash


# =====================================================
# Muteb SOC System Audit Script
#
# الهدف:
# جمع معلومات أساسية عن نظام Linux
# لاستخدامها في عمليات المراقبة والتحليل الأمني
#
# يقوم السكربت بجمع:
# - معلومات النظام
# - المستخدم الحالي
# - الموارد
# - الشبكة
# - الخدمات
# - التخزين
# =====================================================



# إيقاف السكربت عند حدوث خطأ

set -e



# إنشاء اسم التقرير

REPORT="system_audit_report.txt"



# تنظيف التقرير القديم

rm -f $REPORT



# عنوان التقرير

echo "=================================" >> $REPORT

echo "      Muteb SOC System Audit      " >> $REPORT

echo "=================================" >> $REPORT

echo "" >> $REPORT





# =====================================================
# معلومات النظام
# =====================================================


echo "[+] System Information" >> $REPORT


echo "Hostname:" >> $REPORT

hostname >> $REPORT


echo "" >> $REPORT


echo "Operating System:" >> $REPORT

cat /etc/os-release >> $REPORT


echo "" >> $REPORT


echo "Kernel Version:" >> $REPORT

uname -r >> $REPORT






# =====================================================
# معلومات المستخدم
# =====================================================


echo "" >> $REPORT

echo "[+] User Information" >> $REPORT



echo "Current User:" >> $REPORT

whoami >> $REPORT



echo "" >> $REPORT


echo "Logged Users:" >> $REPORT

who >> $REPORT






# =====================================================
# معلومات المعالج والذاكرة
# =====================================================


echo "" >> $REPORT

echo "[+] System Resources" >> $REPORT



echo "CPU Information:" >> $REPORT

lscpu | head -15 >> $REPORT



echo "" >> $REPORT


echo "Memory Usage:" >> $REPORT

free -h >> $REPORT






# =====================================================
# مساحة التخزين
# =====================================================


echo "" >> $REPORT

echo "[+] Disk Usage" >> $REPORT



df -h >> $REPORT






# =====================================================
# معلومات الشبكة
# =====================================================


echo "" >> $REPORT

echo "[+] Network Information" >> $REPORT



echo "IP Addresses:" >> $REPORT

ip addr >> $REPORT



echo "" >> $REPORT


echo "Open Ports:" >> $REPORT

ss -tulpn >> $REPORT






# =====================================================
# الخدمات العاملة
# =====================================================


echo "" >> $REPORT

echo "[+] Running Services" >> $REPORT



systemctl --type=service --state=running >> $REPORT






# =====================================================
# نهاية التقرير
# =====================================================


echo "" >> $REPORT


echo "Audit Completed Successfully" >> $REPORT



echo "================================="

echo "System Audit Completed"

echo "Report saved: $REPORT"

echo "================================="
