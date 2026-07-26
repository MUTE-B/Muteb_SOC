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
