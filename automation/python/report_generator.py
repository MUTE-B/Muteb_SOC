#!/usr/bin/env python3


# =====================================================
# Muteb SOC Report Generator
#
# الهدف:
# إنشاء تقرير أمني PDF تلقائياً
#
# الوظائف:
# - جمع معلومات النظام
# - إنشاء تقرير احترافي
# - حفظ التقرير بصيغة PDF
# =====================================================



import platform
import os
from datetime import datetime

from reportlab.lib.pagesizes import A4
from reportlab.platypus import (
    SimpleDocTemplate,
    Paragraph,
    Spacer
)

from reportlab.lib.styles import getSampleStyleSheet



# اسم التقرير

REPORT_NAME = "Muteb_SOC_Security_Report.pdf"




def collect_system_information():

    """
    جمع معلومات النظام
    """



    information = []


    information.append(
        f"Hostname: {platform.node()}"
    )


    information.append(
        f"Operating System: {platform.system()} {platform.release()}"
    )


    information.append(
        f"Current User: {os.getlogin()}"
    )


    information.append(
        f"Report Time: {datetime.now()}"
    )



    return information





def create_report(data):

    """
    إنشاء ملف PDF
    """



    document = SimpleDocTemplate(
        REPORT_NAME,
        pagesize=A4
    )



    styles = getSampleStyleSheet()



    content = []



    title = Paragraph(
        "Muteb SOC Security Report",
        styles["Title"]
    )


    content.append(title)



    content.append(
        Spacer(1,20)
    )



    for item in data:


        paragraph = Paragraph(
            item,
            styles["Normal"]
        )


        content.append(paragraph)


        content.append(
            Spacer(1,10)
        )



    document.build(content)





def main():



    print("Generating Security Report")



    system_information = collect_system_information()



    create_report(
        system_information
    )



    print(
        "Report Created Successfully"
    )

    print(
        REPORT_NAME
    )





if __name__ == "__main__":

    main()
#!/usr/bin/env python3


# =====================================================
# Muteb SOC Security Report Generator
#
# الهدف:
# إنشاء تقرير أمني PDF من نتائج أدوات المشروع
#
# يقوم البرنامج بـ:
# - قراءة تقارير الفحص
# - دمج النتائج
# - إنشاء ملف PDF
# - توثيق حالة النظام
# =====================================================



# استيراد المكتبات

import os

from datetime import datetime


from reportlab.platypus import (

    SimpleDocTemplate,

    Paragraph,

    Spacer

)


from reportlab.lib.styles import getSampleStyleSheet





# اسم التقرير النهائي

PDF_REPORT = "Muteb_SOC_Security_Report.pdf"





# التقارير التي سيتم جمعها

REPORT_FILES = [

    "system_audit_report.txt",

    "security_check_report.txt",

    "user_audit_report.txt",

    "service_monitor_report.txt",

    "log_analysis_report.txt",

    "port_scan_report.txt",

    "ip_reputation_report.txt"

]





# =====================================================
# إنشاء ملف PDF
# =====================================================


document = SimpleDocTemplate(
    PDF_REPORT
)



styles = getSampleStyleSheet()



content = []





# عنوان التقرير

content.append(

    Paragraph(

        "Muteb SOC Security Report",

        styles["Title"]

    )

)



content.append(

    Spacer(1,20)

)





# وقت إنشاء التقرير

content.append(

    Paragraph(

        f"Generated Time: {datetime.now()}",

        styles["Normal"]

    )

)



content.append(

    Spacer(1,20)

)





# =====================================================
# قراءة التقارير
# =====================================================


for report_file in REPORT_FILES:


    content.append(

        Paragraph(

            f"Report: {report_file}",

            styles["Heading2"]

        )

    )



    if os.path.exists(report_file):


        with open(

            report_file,

            "r",

            errors="ignore"

        ) as file:


            data = file.read()



            content.append(

                Paragraph(

                    data.replace(

                        "\n",

                        "<br/>"

                    ),

                    styles["Normal"]

                )

            )



    else:


        content.append(

            Paragraph(

                "Report not found",

                styles["Normal"]

            )

        )



    content.append(

        Spacer(1,20)

    )





# =====================================================
# بناء ملف PDF
# =====================================================


document.build(content)



print("=================================")

print("Security Report Generated")

print(f"File: {PDF_REPORT}")

print("=================================")
