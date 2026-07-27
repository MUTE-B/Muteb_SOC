#!/bin/bash


# =====================================================
# Muteb SOC Dashboard
#
# الهدف:
# عرض حالة النظام الأمنية بشكل سريع
#
# يعرض:
# - اسم الجهاز
# - نظام التشغيل
# - استخدام المعالج
# - الذاكرة
# - مساحة التخزين
# - حالة SSH
# - حالة Firewall
# =====================================================



clear


# عرض عنوان الأداة

echo "================================="
echo "        Muteb SOC Dashboard"
echo "================================="



# عرض اسم الجهاز

echo ""
echo "Hostname:"

hostname



# عرض معلومات نظام التشغيل

echo ""

echo "Operating System:"

lsb_release -d



# عرض استخدام المعالج

echo ""

echo "CPU Usage:"

top -bn1 | grep Cpu



# عرض الذاكرة

echo ""

echo "Memory Usage:"

free -h



# عرض مساحة التخزين

echo ""

echo "Disk Usage:"

df -h /



# فحص خدمة SSH

echo ""

echo "SSH Service Status:"

systemctl status ssh --no-pager | grep Active



# فحص Firewall

echo ""

echo "Firewall Status:"

sudo ufw status



echo ""

echo "Dashboard Completed"
