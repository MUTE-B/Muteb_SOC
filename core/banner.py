#!/usr/bin/env python3

# ==========================================================
# ملف: banner.py
#
# الهدف:
# عرض واجهة موحدة لجميع أدوات مشروع Muteb SOC.
#
# الفائدة:
# - توحيد مظهر الأدوات.
# - إظهار معلومات المشروع عند التشغيل.
# - تسهيل معرفة اسم الأداة والإصدار الحالي.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

# لمعرفة إصدار بايثون المستخدم
import platform

# للحصول على تاريخ ووقت التشغيل
from datetime import datetime

# قراءة معلومات المشروع من ملف الإعدادات
from core.config_loader import get


# ----------------------------------------------------------
# قراءة معلومات المشروع
# ----------------------------------------------------------

PROJECT_NAME = get("PROJECT", "name")

PROJECT_VERSION = get("PROJECT", "version")

PROJECT_DEVELOPER = get("PROJECT", "developer")


# ----------------------------------------------------------
# إنشاء واجهة البرنامج
# ----------------------------------------------------------

def show_banner(tool_name):

    """
    عرض معلومات المشروع قبل تشغيل أي أداة.
    """

    print("=" * 60)

    print(f"{PROJECT_NAME:^60}")

    print("Security Operations Center Laboratory".center(60))

    print("=" * 60)

    print(f"Tool       : {tool_name}")

    print(f"Version    : {PROJECT_VERSION}")

    print(f"Developer  : {PROJECT_DEVELOPER}")

    print(f"Python     : {platform.python_version()}")

    print(f"Platform   : {platform.system()}")

    print(f"Started    : {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    print("=" * 60)

    print()
