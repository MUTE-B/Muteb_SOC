#!/usr/bin/env python3


# =====================================================
# Muteb SOC Port Scanner
#
# الهدف:
# فحص المنافذ المفتوحة داخل بيئة مصرح بها
#
# الوظائف:
# - الاتصال بالمنافذ باستخدام TCP
# - معرفة المنافذ المتاحة
# - إنشاء تقرير بسيط
# =====================================================



import socket
from datetime import datetime



# عنوان الجهاز المراد فحصه

TARGET = "127.0.0.1"



# المنافذ الشائعة للفحص

PORTS = [
    22,
    80,
    443,
    3306,
    8080
]



def scan_port(target, port):

    """
    اختبار اتصال TCP بمنفذ محدد
    """


    try:

        # إنشاء اتصال Socket

        sock = socket.socket(
            socket.AF_INET,
            socket.SOCK_STREAM
        )


        # تحديد وقت الانتظار

        sock.settimeout(1)



        # محاولة الاتصال بالمنفذ

        result = sock.connect_ex(
            (target, port)
        )



        # إغلاق الاتصال

        sock.close()



        # إذا كانت النتيجة صفر فالمنفذ مفتوح

        if result == 0:

            return True


        else:

            return False



    except socket.error:


        return False





def main():


    print("==============================")

    print("Muteb SOC Port Scanner")

    print("==============================")



    print("Target:")

    print(TARGET)



    print("Scan Time:")

    print(datetime.now())



    print("")



    for port in PORTS:



        if scan_port(TARGET, port):

            print(
                f"Port {port} is OPEN"
            )


        else:

            print(
                f"Port {port} is CLOSED"
            )



    print("")

    print("Scan Completed")





if __name__ == "__main__":

    main()
