#!/usr/bin/env python3

# ==========================================================
# الملف:
# service_analyzer.py
#
# الهدف:
# تحليل خدمات النظام (System Services)
# وإنشاء تقرير احترافي يساعد محلل SOC
# على مراجعة الخدمات العاملة داخل النظام.
#
# يقوم هذا البرنامج بعرض:
#
# - الخدمات النشطة
# - الخدمات الفاشلة
# - الخدمات التي تعمل عند الإقلاع
# - حالة أهم الخدمات الأمنية
#
# يعتمد على systemctl لذلك يعمل على
# الأنظمة التي تستخدم Systemd.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
import subprocess
import datetime


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
    "service_analysis_report.txt"
)


# ----------------------------------------------------------
# دالة تنفيذ أوامر النظام
# ----------------------------------------------------------

def run_command(command):

    try:

        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True
        )

        return result.stdout.strip()

    except Exception as error:

        return f"Error : {error}"


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
        "               Service Analysis Report\n"
    )

    report.write(
        "============================================================\n\n"
    )


    report.write(
        f"Generated : {datetime.datetime.now()}\n\n"
    )


    report.write(
        "Active Services\n"
    )

    report.write(
        "------------------------------------------------------------\n"
    )

    report.write(
        run_command(
            "systemctl list-units --type=service --state=running"
        )
    )

    report.write("\n\n")


    report.write(
        "Failed Services\n"
    )

    report.write(
        "------------------------------------------------------------\n"
    )

    report.write(
        run_command(
            "systemctl list-units --type=service --state=failed"
        )
    )

    report.write("\n\n")


    report.write(
        "Enabled Services\n"
    )

    report.write(
        "------------------------------------------------------------\n"
    )

    report.write(
        run_command(
            "systemctl list-unit-files --type=service --state=enabled"
        )
    )

    report.write("\n\n")


    report.write(
        "Important Security Services\n"
    )

    report.write(
        "------------------------------------------------------------\n"
    )


    services = [

        "ssh",

        "ufw",

        "fail2ban",

        "apache2",

        "nginx",

        "docker"

    ]


    for service in services:

        report.write(f"{service}\n")

        report.write("----------------------------------------\n")

        report.write(

            run_command(

                f"systemctl status {service} --no-pager"

            )

        )

        report.write("\n\n")


    report.write(
        "============================================================\n"
    )

    report.write(
        "Analysis Completed Successfully\n"
    )

    report.write(
        "============================================================\n"
    )


# ----------------------------------------------------------
# عرض رسالة نجاح
# ----------------------------------------------------------

print()

print("============================================================")

print("Service analysis completed successfully.")

print()

print("Report saved to:")

print()

print(REPORT_FILE)

print()

print("============================================================")
