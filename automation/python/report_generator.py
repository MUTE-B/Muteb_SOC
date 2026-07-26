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
