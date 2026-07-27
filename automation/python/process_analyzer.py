#!/usr/bin/env python3

# ==========================================================
# الملف:
# process_analyzer.py
#
# الهدف:
# تحليل العمليات (Processes) العاملة داخل النظام
# وإنشاء تقرير احترافي يساعد محلل SOC
# في اكتشاف العمليات غير الطبيعية.
#
# يقوم هذا البرنامج بعرض:
#
# - PID
# - اسم العملية
# - المستخدم
# - استهلاك المعالج
# - استهلاك الذاكرة
# - وقت تشغيل العملية
#
# يتم ترتيب العمليات حسب استهلاك المعالج.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
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
    "process_analysis_report.txt"
)


# ----------------------------------------------------------
# إنشاء قائمة العمليات
# ----------------------------------------------------------

processes = []

for process in psutil.process_iter(

    [

        "pid",

        "name",

        "username",

        "cpu_percent",

        "memory_percent",

        "create_time"

    ]

):

    try:

        processes.append(process.info)

    except (

        psutil.NoSuchProcess,

        psutil.AccessDenied,

        psutil.ZombieProcess

    ):

        continue


# ----------------------------------------------------------
# ترتيب العمليات حسب استهلاك المعالج
# ----------------------------------------------------------

processes.sort(

    key=lambda process: process["cpu_percent"],

    reverse=True

)


# ----------------------------------------------------------
# إنشاء التقرير
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

        "               Process Analysis Report\n"

    )

    report.write(

        "============================================================\n\n"

    )


    report.write(

        f"Generated : {datetime.datetime.now()}\n\n"

    )


    report.write(

        "{:<8} {:<25} {:<18} {:>8} {:>10}\n".format(

            "PID",

            "Process",

            "User",

            "CPU%",

            "MEM%"

        )

    )

    report.write(

        "-" * 80

    )

    report.write(

        "\n"

    )


    for process in processes[:50]:

        report.write(

            "{:<8} {:<25} {:<18} {:>8} {:>9.2f}\n".format(

                process["pid"],

                str(process["name"])[:24],

                str(process["username"])[:17],

                process["cpu_percent"],

                process["memory_percent"]

            )

        )


    report.write(

        "\n============================================================\n"

    )

    report.write(

        "Summary\n"

    )

    report.write(

        "============================================================\n\n"

    )

    report.write(

        f"Total Running Processes : {len(processes)}\n"

    )

    report.write(

        f"Logical CPUs            : {psutil.cpu_count()}\n"

    )

    report.write(

        f"CPU Usage               : {psutil.cpu_percent(interval=1)} %\n"

    )

    report.write(

        f"Memory Usage            : {psutil.virtual_memory().percent} %\n"

    )


# ----------------------------------------------------------
# عرض رسالة نجاح
# ----------------------------------------------------------

print()

print("============================================================")

print("Process analysis completed successfully.")

print()

print("Report saved to:")

print()

print(REPORT_FILE)

print()

print("============================================================")
