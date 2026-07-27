#!/usr/bin/env python3


# =====================================================
# Muteb SOC Log Analyzer
#
# الهدف:
# تحليل ملفات Linux Logs واكتشاف الأحداث الأمنية
#
# الوظائف:
# - قراءة ملفات السجلات
# - البحث عن محاولات الدخول الفاشلة
# - حساب عدد المحاولات
# - إنشاء ملخص أمني
# =====================================================



import os
from datetime import datetime



# مسار ملف تسجيل الدخول في Ubuntu

LOG_FILE = "/var/log/auth.log"



# كلمة البحث عن محاولات الدخول الفاشلة

FAILED_LOGIN = "Failed password"



def analyze_log():

    """
    قراءة وتحليل ملف Log
    """



    failed_attempts = 0



    # التأكد من وجود الملف

    if not os.path.exists(LOG_FILE):

        print("Log file not found")

        return



    # فتح ملف السجل للقراءة

    with open(LOG_FILE, "r") as file:



        for line in file:



            # البحث عن محاولات الدخول الفاشلة

            if FAILED_LOGIN in line:

                failed_attempts += 1



    print("==============================")

    print("Muteb SOC Log Analysis")

    print("==============================")


    print("Analysis Time:")

    print(datetime.now())



    print("")


    print("Failed Login Attempts:")

    print(failed_attempts)



    print("")

    print("Analysis Completed")





if __name__ == "__main__":


    analyze_log()
#!/usr/bin/env python3


# =====================================================
# Muteb SOC Log Analyzer
#
# الهدف:
# تحليل ملفات Log واكتشاف الأحداث الأمنية المهمة
#
# يقوم البرنامج بـ:
# - قراءة ملفات النظام
# - البحث عن محاولات الدخول الفاشلة
# - حساب عدد الأحداث
# - إنشاء تقرير أمني
# =====================================================



# استيراد المكتبات المطلوبة

import os
from datetime import datetime



# ملف السجل المراد تحليله

LOG_FILE = "/var/log/auth.log"



# ملف التقرير الناتج

REPORT_FILE = "log_analysis_report.txt"





# الكلمات التي نبحث عنها

SUSPICIOUS_EVENTS = [

    "Failed password",

    "Invalid user",

    "authentication failure"

]





# عداد الأحداث

event_counter = {}





# =====================================================
# التأكد من وجود ملف Log
# =====================================================


if not os.path.exists(LOG_FILE):


    print("Log file not found")

    exit(1)





# =====================================================
# فتح وتحليل الملف
# =====================================================


with open(LOG_FILE, "r", errors="ignore") as log:


    for line in log:


        for event in SUSPICIOUS_EVENTS:


            if event in line:


                if event not in event_counter:


                    event_counter[event] = 0


                event_counter[event] += 1





# =====================================================
# إنشاء التقرير
# =====================================================


with open(REPORT_FILE, "w") as report:


    report.write("=================================\n")

    report.write("      Muteb SOC Log Analysis      \n")

    report.write("=================================\n\n")


    report.write(

        f"Analysis Time: {datetime.now()}\n\n"

    )


    report.write("Detected Events:\n\n")



    for event, count in event_counter.items():


        report.write(

            f"{event}: {count}\n"

        )





# =====================================================
# عرض النتيجة
# =====================================================


print("=================================")

print("Log Analysis Completed")

print(f"Report saved: {REPORT_FILE}")

print("=================================")
