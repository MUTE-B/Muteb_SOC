#!/bin/bash


# =====================================================
# Muteb SOC Update Script
#
# الهدف:
# تحديث مشروع Muteb SOC والمحافظة على بيئة العمل
#
# يقوم السكربت بـ:
# - تحديث نظام Ubuntu
# - تحديث مكتبات Python
# - تحديث مستودع Git
# - إعادة ضبط صلاحيات الملفات
# =====================================================



# إيقاف التنفيذ عند حدوث خطأ

set -e



PROJECT_NAME="Muteb-SOC"



echo "===================================="

echo " Updating $PROJECT_NAME "

echo "===================================="



# =====================================================
# تحديث Ubuntu
# =====================================================


echo "[+] Updating Ubuntu packages"



sudo apt update



sudo apt upgrade -y





# =====================================================
# تحديث Python Environment
# =====================================================


echo "[+] Updating Python environment"



if [ -d "venv" ]; then


    source venv/bin/activate


    pip install --upgrade pip


    pip install -r tools/requirements.txt


else


    echo "Python environment not found"

    echo "Run INSTALL.sh first"


fi





# =====================================================
# تحديث Git
# =====================================================


echo "[+] Updating Git repository"



if [ -d ".git" ]; then


    git pull


else


    echo "Git repository not initialized"


fi





# =====================================================
# إعادة تطبيق الصلاحيات
# =====================================================


echo "[+] Fixing permissions"



chmod +x automation/bash/*.sh



chmod +x automation/python/*.py





# =====================================================
# إنهاء التحديث
# =====================================================


echo "===================================="

echo " Update Completed Successfully "

echo "===================================="
#!/bin/bash

# ==========================================================
# الهدف:
# تحديث مشروع Muteb SOC.
# ==========================================================

set -e

echo "Updating project..."

sudo apt update

source venv/bin/activate

pip install --upgrade pip

pip install -r tools/requirements.txt

find . -type f -name "*.sh" -exec chmod +x {} \;

find . -type f -name "*.py" -exec chmod +x {} \;

git add .

echo

echo "Project update completed successfully."
