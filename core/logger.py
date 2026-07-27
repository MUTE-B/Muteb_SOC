#!/usr/bin/env python3

# ==========================================================
# ملف: logger.py
#
# الهدف:
# إنشاء نظام تسجيل (Logging) موحد لجميع أدوات المشروع.
#
# هذا الملف يقوم بـ:
# - إنشاء ملف سجل إذا لم يكن موجوداً.
# - حفظ جميع الرسائل داخل ملف logs/muteb_soc.log.
# - عرض الرسائل في الطرفية أثناء التشغيل.
#
# الفائدة:
# بدلاً من تكرار أوامر الطباعة في كل برنامج،
# يتم استدعاء هذا الملف واستخدام دواله.
# ==========================================================


# استيراد المكتبات القياسية

import logging
import os



# إنشاء مجلد السجلات إذا لم يكن موجوداً

os.makedirs("logs", exist_ok=True)



# اسم ملف السجل

LOG_FILE = "logs/muteb_soc.log"



# إعداد نظام التسجيل

logging.basicConfig(

    level=logging.INFO,

    format="%(asctime)s | %(levelname)s | %(message)s",

    handlers=[

        logging.FileHandler(LOG_FILE),

        logging.StreamHandler()

    ]

)



# إنشاء كائن التسجيل الرئيسي

logger = logging.getLogger("MutebSOC")
