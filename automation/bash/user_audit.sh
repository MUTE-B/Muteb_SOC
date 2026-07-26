#!/bin/bash


# =====================================================
# Muteb SOC User Audit
#
# الهدف:
# مراجعة حسابات المستخدمين في نظام Linux
#
# الفحوصات:
# - قائمة المستخدمين
# - الحسابات التي لديها Shell
# - مستخدمو sudo
# - آخر عمليات الدخول
# =====================================================



echo "Starting User Audit"



echo ""
echo "=============================="
echo "System Users"
echo "=============================="


cat /etc/passwd



echo ""
echo "=============================="
echo "Users With Login Shell"
echo "=============================="


cat /etc/passwd | grep -v "/nologin" | grep -v "/false"



echo ""
echo "=============================="
echo "Users With Sudo Access"
echo "=============================="


getent group sudo



echo ""
echo "=============================="
echo "Last Login Records"
echo "=============================="


last



echo ""

echo "User Audit Completed"
