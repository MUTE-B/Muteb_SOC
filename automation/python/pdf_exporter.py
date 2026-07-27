#!/usr/bin/env python3

# ==========================================================
# الملف:
# pdf_exporter.py
#
# الهدف:
# إنشاء تقرير PDF احترافي يحتوي على جميع
# التقارير النصية الموجودة داخل المشروع.
#
# يقوم هذا البرنامج بـ:
#
# - البحث عن جميع ملفات TXT.
# - دمج محتوياتها.
# - إنشاء تقرير PDF واحد.
#
# يعتمد على مكتبة ReportLab.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
import datetime

from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import SimpleDocTemplate
from reportlab.platypus import Paragraph
from reportlab.platypus import Spacer


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
# تحديد اسم ملف PDF
# ----------------------------------------------------------

PDF_FILE = os.path.join(

    REPORTS_DIR,

    "Muteb_SOC_Report.pdf"

)


# ----------------------------------------------------------
# إنشاء مستند PDF
# ----------------------------------------------------------

document = SimpleDocTemplate(

    PDF_FILE

)


styles = getSampleStyleSheet()

story = []


# ----------------------------------------------------------
# عنوان التقرير
# ----------------------------------------------------------

story.append(

    Paragraph(

        "<b>Muteb SOC Security Report</b>",

        styles["Title"]

    )

)

story.append(

    Spacer(

        1,

        20

    )

)

story.append(

    Paragraph(

        f"Generated : {datetime.datetime.now()}",

        styles["Normal"]

    )

)

story.append(

    Spacer(

        1,

        20

    )

)


# ----------------------------------------------------------
# قراءة جميع ملفات TXT
# ----------------------------------------------------------

REPORT_FILES = sorted(

    os.listdir(

        REPORTS_DIR

    )

)


for report in REPORT_FILES:

    if not report.endswith(".txt"):

        continue


    report_path = os.path.join(

        REPORTS_DIR,

        report

    )


    story.append(

        Paragraph(

            f"<b>{report}</b>",

            styles["Heading2"]

        )

    )

    story.append(

        Spacer(

            1,

            10

        )

    )


    try:

        with open(

            report_path,

            "r",

            encoding="utf-8",

            errors="ignore"

        ) as file:


            content = file.read()


            content = (

                content

                .replace("&", "&amp;")

                .replace("<", "&lt;")

                .replace(">", "&gt;")

            )


            story.append(

                Paragraph(

                    content.replace(

                        "\n",

                        "<br/>"

                    ),

                    styles["Code"]

                )

            )


            story.append(

                Spacer(

                    1,

                    20

                )

            )


    except Exception:

        continue


# ----------------------------------------------------------
# إنشاء ملف PDF
# ----------------------------------------------------------

document.build(

    story

)


# ----------------------------------------------------------
# عرض رسالة النجاح
# ----------------------------------------------------------

print()

print("============================================================")

print("PDF report generated successfully.")

print()

print("PDF File")

print()

print(PDF_FILE)

print()

print("============================================================")
