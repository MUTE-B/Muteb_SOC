#!/bin/bash


# =====================================================
# Muteb SOC Backup Manager
#
# الهدف:
# إنشاء نسخة احتياطية من مشروع Muteb SOC
#
# الوظائف:
# - تحديد مسار المشروع
# - إنشاء مجلد النسخ الاحتياطية
# - ضغط ملفات المشروع
# - إضافة تاريخ النسخة
# =====================================================



echo "Starting Backup Process"



# اسم المشروع

PROJECT_NAME="Muteb-SOC"



# مسار المشروع الحالي

PROJECT_PATH=$(pwd)



# مجلد النسخ الاحتياطية

BACKUP_DIR="$PROJECT_PATH/backups"



# إنشاء مجلد النسخ إذا لم يكن موجوداً

mkdir -p "$BACKUP_DIR"



# إنشاء تاريخ للنسخة

DATE=$(date +"%Y-%m-%d_%H-%M-%S")



# اسم ملف النسخة

BACKUP_FILE="$BACKUP_DIR/${PROJECT_NAME}_backup_$DATE.tar.gz"



echo "Creating backup file"



tar -czf "$BACKUP_FILE" \
--exclude="./venv" \
--exclude="./backups" \
.



# التحقق من نجاح العملية

if [ $? -eq 0 ]

then

    echo "Backup completed successfully"

    echo "Backup location: $BACKUP_FILE"


else

    echo "Backup failed"

fi


#!/bin/bash


# =====================================================
# Muteb SOC Backup Manager Script
#
# الهدف:
# إنشاء نسخة احتياطية من ملفات مشروع Muteb SOC
#
# يقوم السكربت بـ:
# - إنشاء مجلد Backup
# - ضغط ملفات المشروع
# - إضافة التاريخ والوقت للنسخة
# - حفظ نسخة قابلة للاسترجاع
# =====================================================



# إيقاف السكربت عند حدوث خطأ

set -e



# اسم المشروع

PROJECT_NAME="Muteb-SOC"



# مكان حفظ النسخ الاحتياطية

BACKUP_DIR="backup"



# إنشاء تاريخ النسخة

DATE=$(date +"%Y-%m-%d_%H-%M-%S")



# اسم ملف النسخة

BACKUP_FILE="$BACKUP_DIR/${PROJECT_NAME}_backup_$DATE.tar.gz"





# =====================================================
# إنشاء مجلد النسخ الاحتياطية
# =====================================================


echo "[+] Checking backup directory"



mkdir -p $BACKUP_DIR





# =====================================================
# إنشاء النسخة الاحتياطية
# =====================================================


echo "[+] Creating backup"



tar -czf $BACKUP_FILE \

--exclude="./venv" \

--exclude="./.git" \

.





# =====================================================
# التحقق من نجاح العملية
# =====================================================


if [ -f "$BACKUP_FILE" ]; then


    echo "Backup created successfully"


    echo "Location: $BACKUP_FILE"


else


    echo "Backup failed"


    exit 1


fi





# =====================================================
# عرض حجم النسخة
# =====================================================


echo "[+] Backup size"



du -h $BACKUP_FILE





echo "================================="

echo "Backup Process Completed"

echo "================================="
