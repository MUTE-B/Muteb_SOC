#!/bin/bash


# =====================================================
# Muteb SOC Installation Script
#
# الهدف:
# تجهيز بيئة Ubuntu لتشغيل مختبر SOC
#
# الوظائف:
# - تثبيت أدوات النظام
# - إنشاء بيئة Python
# - تثبيت المكتبات
# - تجهيز صلاحيات الملفات
# - إعداد Git
# =====================================================


# إيقاف التنفيذ عند حدوث أي خطأ
set -e



# اسم المشروع
PROJECT_NAME="Muteb-SOC"



echo "Starting $PROJECT_NAME installation"



# تحديث قائمة البرامج في Ubuntu

echo "Updating system packages"

sudo apt update



# تثبيت الأدوات الأساسية

echo "Installing required tools"


sudo apt install -y \
git \
python3 \
python3-pip \
python3-venv \
curl \
wget \
nmap \
net-tools \
ufw



# إنشاء بيئة Python مستقلة للمشروع

echo "Creating Python virtual environment"


python3 -m venv venv



# تشغيل البيئة الافتراضية

echo "Activating Python environment"


source venv/bin/activate



# تثبيت مكتبات Python المطلوبة

echo "Installing Python libraries"


pip install \
requests \
psutil \
python-dotenv \
reportlab



# إعطاء صلاحيات التشغيل للملفات

echo "Applying permissions"


chmod +x automation/bash/*.sh

chmod +x tools/*.sh



# إنشاء مستودع Git

echo "Initializing Git"


git init



# إضافة ملفات المشروع

echo "Adding project files"


git add .



# إنشاء أول حفظ

echo "Creating initial commit"


git commit -m "Initial Muteb SOC project setup"



echo "Installation completed successfully"
#!/bin/bash


# =====================================================
# Muteb SOC Installation Script
#
# الهدف:
# تجهيز بيئة مشروع Muteb SOC على Ubuntu
#
# يقوم السكربت بـ:
# - تحديث النظام
# - تثبيت الأدوات المطلوبة
# - إنشاء بيئة Python
# - تثبيت المكتبات
# - ضبط صلاحيات الملفات
# - تجهيز Git
# =====================================================



# إيقاف السكربت عند حدوث أي خطأ
set -e



# اسم المشروع

PROJECT_NAME="Muteb-SOC"



echo "===================================="

echo " Starting $PROJECT_NAME Installation "

echo "===================================="



# =====================================================
# التحقق من نظام التشغيل
# =====================================================


echo "[+] Checking operating system"



if [ -f /etc/os-release ]; then


    source /etc/os-release


    echo "Detected OS: $NAME"


else


    echo "Cannot detect operating system"

    exit 1


fi





# =====================================================
# تحديث مستودعات Ubuntu
# =====================================================


echo "[+] Updating Ubuntu packages"



sudo apt update



sudo apt upgrade -y





# =====================================================
# تثبيت الأدوات الأساسية
# =====================================================


echo "[+] Installing required packages"



sudo apt install -y \

git \

python3 \

python3-pip \

python3-venv \

curl \

wget \

tree \

nmap \

net-tools \

ufw





# =====================================================
# إنشاء بيئة Python
# =====================================================


echo "[+] Creating Python Virtual Environment"



python3 -m venv venv





# =====================================================
# تفعيل البيئة وتثبيت المكتبات
# =====================================================


echo "[+] Installing Python libraries"



source venv/bin/activate



pip install --upgrade pip



pip install \

requests \

psutil \

python-dotenv \

reportlab





# =====================================================
# إعطاء صلاحيات التشغيل
# =====================================================


echo "[+] Applying permissions"



chmod +x automation/bash/*.sh



chmod +x automation/python/*.py





# =====================================================
# تهيئة Git
# =====================================================


echo "[+] Initializing Git repository"



if [ ! -d ".git" ]; then


    git init


else


    echo "Git already initialized"


fi





# =====================================================
# إضافة ملفات المشروع
# =====================================================


echo "[+] Adding project files"



git add .





# =====================================================
# إنشاء أول Commit
# =====================================================


echo "[+] Creating initial commit"



git commit -m "Initial Muteb SOC project setup" || true





# =====================================================
# نهاية التثبيت
# =====================================================


echo "===================================="

echo " Muteb SOC Installation Completed "

echo "===================================="



echo ""

echo "Next steps:"

echo "1- Activate environment:"

echo "source venv/bin/activate"


echo ""

echo "2- Run security tools"

echo "./automation/bash/system_audit.sh"

#!/bin/bash

# ==========================================================
# الهدف:
# تثبيت وإعداد مشروع Muteb SOC.
# ==========================================================

set -e

PROJECT_NAME="Muteb-SOC"

clear

echo "============================================================"
echo "              $PROJECT_NAME Installer"
echo "============================================================"

echo
echo "[1/10] Updating Ubuntu repositories..."
sudo apt update

echo
echo "[2/10] Installing required packages..."
sudo apt install -y \
git \
curl \
wget \
tree \
net-tools \
nmap \
ufw \
python3 \
python3-pip \
python3-venv

echo
echo "[3/10] Creating Python virtual environment..."
python3 -m venv venv

echo
echo "[4/10] Activating virtual environment..."
source venv/bin/activate

echo
echo "[5/10] Upgrading pip..."
python -m pip install --upgrade pip

echo
echo "[6/10] Installing Python requirements..."
pip install -r tools/requirements.txt

echo
echo "[7/10] Creating project directories..."

mkdir -p logs
mkdir -p reports
mkdir -p backup
mkdir -p screenshots

echo
echo "[8/10] Applying executable permissions..."

find . -type f -name "*.sh" -exec chmod +x {} \;
find . -type f -name "*.py" -exec chmod +x {} \;

echo
echo "[9/10] Initializing Git repository..."

if [ ! -d ".git" ]; then
    git init
fi

git add .

if ! git rev-parse HEAD >/dev/null 2>&1; then
    git commit -m "Initial project setup"
fi

echo
echo "[10/10] Installation completed."

echo
echo "============================================================"
echo "Muteb SOC is ready."
echo "============================================================"

echo
echo "Activate Python Environment:"
echo
echo "source venv/bin/activate"

echo
echo "Start Dashboard:"
echo
echo "./dashboard.sh"

echo
echo "System Audit:"
echo
echo "./automation/bash/system_audit.sh"
