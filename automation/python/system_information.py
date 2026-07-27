#!/usr/bin/env python3

# ==========================================================
# الملف:
# system_information.py
#
# الهدف:
# جمع معلومات النظام وإنشاء تقرير احترافي.
#
# يقوم هذا البرنامج بعرض:
#
# - اسم الجهاز
# - نظام التشغيل
# - إصدار Kernel
# - المعالج
# - الذاكرة
# - الأقراص
# - وقت التشغيل
# - عنوان IP
#
# يستخدم داخل مختبر Muteb SOC
# كجزء من مرحلة جمع المعلومات.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات المطلوبة
# ----------------------------------------------------------

import os
import platform
import socket
import datetime

import psutil


# ----------------------------------------------------------
# تحديد المجلد الرئيسي للمشروع
# ----------------------------------------------------------

PROJECT_ROOT = os.path.abspath(

    os.path.join(

        os.path.dirname(__file__),

        "..",

        ".."

    )

)


# ----------------------------------------------------------
# تحديد مجلد التقارير
# ----------------------------------------------------------

REPORT_DIR = os.path.join(

    PROJECT_ROOT,

    "reports"

)


os.makedirs(

    REPORT_DIR,

    exist_ok=True

)


# ----------------------------------------------------------
# تحديد اسم التقرير
# ----------------------------------------------------------

REPORT_FILE = os.path.join(

    REPORT_DIR,

    "system_information_report.txt"

)


# ----------------------------------------------------------
# كتابة التقرير
# ----------------------------------------------------------

with open(

    REPORT_FILE,

    "w",

    encoding="utf-8"

) as report:


    report.write(

        "============================================================\n"

    )

    report.write(

        "              System Information Report\n"

    )

    report.write(

        "============================================================\n\n"

    )


    report.write(

        f"Generated : {datetime.datetime.now()}\n\n"

    )


    report.write(

        "Hostname\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{socket.gethostname()}\n\n"

    )


    report.write(

        "Operating System\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{platform.platform()}\n\n"

    )


    report.write(

        "Kernel Version\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{platform.release()}\n\n"

    )


    report.write(

        "Processor\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{platform.processor()}\n\n"

    )


    report.write(

        "CPU Cores\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{psutil.cpu_count(logical=False)}\n\n"

    )


    report.write(

        "Logical Processors\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{psutil.cpu_count()}\n\n"

    )


    report.write(

        "Memory\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    memory = psutil.virtual_memory()

    report.write(

        f"Total : {memory.total / (1024 ** 3):.2f} GB\n"

    )

    report.write(

        f"Used  : {memory.used / (1024 ** 3):.2f} GB\n"

    )

    report.write(

        f"Free  : {memory.available / (1024 ** 3):.2f} GB\n\n"

    )


    report.write(

        "Disk Usage\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    disk = psutil.disk_usage("/")

    report.write(

        f"Total : {disk.total / (1024 ** 3):.2f} GB\n"

    )

    report.write(

        f"Used  : {disk.used / (1024 ** 3):.2f} GB\n"

    )

    report.write(

        f"Free  : {disk.free / (1024 ** 3):.2f} GB\n\n"

    )


    report.write(

        "IP Address\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    report.write(

        f"{socket.gethostbyname(socket.gethostname())}\n\n"

    )


    report.write(

        "System Uptime\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )

    uptime = datetime.datetime.now() - datetime.datetime.fromtimestamp(

        psutil.boot_time()

    )

    report.write(

        f"{uptime}\n\n"

    )


    report.write(

        "============================================================\n"

    )

    report.write(

        "Report Completed Successfully\n"

    )

    report.write(

        "============================================================\n"

    )


print()

print("============================================================")

print("System information collected successfully.")

print()

print(f"Report saved to:\n\n{REPORT_FILE}")

print()

print("============================================================")
