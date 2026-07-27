#!/usr/bin/env python3

# ==========================================================
# الملف:
# threat_summary.py
#
# الهدف:
# إنشاء ملخص أمني اعتماداً على نتائج الأدوات
# الموجودة داخل مجلد التقارير.
#
# يقوم هذا البرنامج بـ:
#
# - قراءة جميع التقارير.
# - حساب عدد التنبيهات الأمنية.
# - حساب عدد الملفات التي تم تحليلها.
# - عرض حالة النظام.
# - إنشاء تقرير ملخص.
#
# يستخدم كمرحلة أخيرة قبل إنشاء التقرير النهائي.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
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

REPORTS_DIR = os.path.join(

    PROJECT_ROOT,

    "reports"

)


# ----------------------------------------------------------
# إنشاء مجلد التقارير إذا لم يكن موجوداً
# ----------------------------------------------------------

os.makedirs(

    REPORTS_DIR,

    exist_ok=True

)


# ----------------------------------------------------------
# تحديد اسم التقرير
# ----------------------------------------------------------

SUMMARY_REPORT = os.path.join(

    REPORTS_DIR,

    "threat_summary_report.txt"

)


# ----------------------------------------------------------
# البحث عن ملفات التقارير
# ----------------------------------------------------------

REPORT_FILES = []


for file_name in os.listdir(REPORTS_DIR):

    if file_name.endswith(".txt"):

        REPORT_FILES.append(file_name)


# ----------------------------------------------------------
# عداد النتائج
# ----------------------------------------------------------

TOTAL_REPORTS = len(REPORT_FILES)

TOTAL_ALERTS = 0

TOTAL_LINES = 0


# ----------------------------------------------------------
# الكلمات المفتاحية الأمنية
# ----------------------------------------------------------

KEYWORDS = [

    "failed",

    "error",

    "warning",

    "denied",

    "attack",

    "critical",

    "unauthorized",

    "invalid",

    "malware",

    "alert"

]


# ----------------------------------------------------------
# تحليل جميع التقارير
# ----------------------------------------------------------

for report in REPORT_FILES:

    report_path = os.path.join(

        REPORTS_DIR,

        report

    )


    try:

        with open(

            report_path,

            "r",

            encoding="utf-8",

            errors="ignore"

        ) as file:


            for line in file:

                TOTAL_LINES += 1

                text = line.lower()

                for keyword in KEYWORDS:

                    if keyword in text:

                        TOTAL_ALERTS += 1


    except Exception:

        continue


# ----------------------------------------------------------
# تحديد مستوى الخطورة
# ----------------------------------------------------------

if TOTAL_ALERTS == 0:

    RISK_LEVEL = "LOW"

elif TOTAL_ALERTS <= 20:

    RISK_LEVEL = "MEDIUM"

elif TOTAL_ALERTS <= 50:

    RISK_LEVEL = "HIGH"

else:

    RISK_LEVEL = "CRITICAL"


# ----------------------------------------------------------
# إنشاء التقرير
# ----------------------------------------------------------

with open(

    SUMMARY_REPORT,

    "w",

    encoding="utf-8"

) as report:


    report.write(

        "============================================================\n"

    )

    report.write(

        "                Threat Summary Report\n"

    )

    report.write(

        "============================================================\n\n"

    )


    report.write(

        f"Generated : {datetime.datetime.now()}\n\n"

    )


    report.write(

        f"Reports Analyzed : {TOTAL_REPORTS}\n"

    )

    report.write(

        f"Total Lines      : {TOTAL_LINES}\n"

    )

    report.write(

        f"Security Alerts  : {TOTAL_ALERTS}\n"

    )

    report.write(

        f"Risk Level       : {RISK_LEVEL}\n\n"

    )


    report.write(

        "Reports Included\n"

    )

    report.write(

        "------------------------------------------------------------\n"

    )


    for report_name in REPORT_FILES:

        report.write(

            f"{report_name}\n"

        )


    report.write(

        "\n============================================================\n"

    )

    report.write(

        "Threat Summary Completed Successfully\n"

    )

    report.write(

        "============================================================\n"

    )


# ----------------------------------------------------------
# عرض ملخص التنفيذ
# ----------------------------------------------------------

print()

print("============================================================")

print("Threat summary completed successfully.")

print()

print(f"Reports analyzed : {TOTAL_REPORTS}")

print(f"Alerts detected  : {TOTAL_ALERTS}")

print(f"Risk level       : {RISK_LEVEL}")

print()

print("Report saved to:")

print()

print(SUMMARY_REPORT)

print()

print("============================================================")
