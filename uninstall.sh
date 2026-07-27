#!/bin/bash


# =====================================================
# Muteb SOC Uninstall Script
#
# الهدف:
# تنظيف مشروع Muteb SOC وإزالة الملفات المؤقتة
#
# يقوم السكربت بـ:
# - حذف بيئة Python الافتراضية
# - حذف ملفات التخزين المؤقت
# - تنظيف ملفات التقارير والسجلات
# - إزالة Git عند اختيار المستخدم
# =====================================================



# إيقاف التنفيذ عند حدوث خطأ

set -e



PROJECT_NAME="Muteb-SOC"



echo "===================================="

echo " Removing $PROJECT_NAME Temporary Files "

echo "===================================="



# =====================================================
# حذف Python Virtual Environment
# =====================================================


if [ -d "venv" ]; then


    echo "[+] Removing Python virtual environment"


    rm -rf venv


else


    echo "Python environment not found"


fi





# =====================================================
# حذف ملفات Python المؤقتة
# =====================================================


echo "[+] Removing Python cache files"



find . -type d -name "__pycache__" -exec rm -rf {} +





# =====================================================
# حذف الملفات المؤقتة
# =====================================================


echo "[+] Removing temporary files"



find . -type f -name "*.tmp" -delete



find . -type f -name "*.log" -delete





# =====================================================
# تنظيف التقارير الناتجة
# =====================================================


echo "[+] Cleaning generated reports"



rm -rf SOC/reports/generated/* 2>/dev/null || true





# =====================================================
# سؤال المستخدم عن Git
# =====================================================


read -p "Remove Git repository? (y/n): " REMOVE_GIT



if [ "$REMOVE_GIT" == "y" ]; then


    echo "[+] Removing Git repository"


    rm -rf .git


else


    echo "Keeping Git repository"


fi





# =====================================================
# نهاية العملية
# =====================================================


echo "===================================="

echo " Cleanup Completed Successfully "

echo "===================================="
#!/bin/bash

# ==========================================================
# الهدف:
# إزالة ملفات المشروع المحلية.
# ==========================================================

echo

read -p "Remove Python virtual environment? (y/n): " answer

if [[ "$answer" == "y" ]]; then

    rm -rf venv

fi

echo

find . -type d -name "__pycache__" -exec rm -rf {} +

find . -type f -name "*.pyc" -delete

echo

echo "Cleanup completed."
