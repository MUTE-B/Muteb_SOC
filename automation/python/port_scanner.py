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
#!/usr/bin/env python3


# =====================================================
# Muteb SOC Port Scanner
#
# الهدف:
# فحص منافذ TCP داخل بيئة المختبر
#
# يقوم البرنامج بـ:
# - اختبار المنافذ
# - اكتشاف المنافذ المفتوحة
# - إنشاء تقرير فحص
# =====================================================



# استيراد المكتبات

import socket
from datetime import datetime





# عنوان الجهاز المراد فحصه

TARGET = "127.0.0.1"



# المنافذ التي سيتم اختبارها

PORTS = [

    22,
    80,
    443,
    3306,
    8080

]



# ملف التقرير

REPORT_FILE = "port_scan_report.txt"





# =====================================================
# دالة فحص المنفذ
# =====================================================


def scan_port(port):


    # إنشاء اتصال TCP


    sock = socket.socket(
        socket.AF_INET,
        socket.SOCK_STREAM
    )


    # تحديد وقت الانتظار

    sock.settimeout(1)



    # محاولة الاتصال

    result = sock.connect_ex(
        (TARGET, port)
    )



    # إغلاق الاتصال

    sock.close()



    return result == 0





# =====================================================
# بدء عملية الفحص
# =====================================================


open_ports = []



for port in PORTS:


    if scan_port(port):


        open_ports.append(port)





# =====================================================
# إنشاء التقرير
# =====================================================


with open(REPORT_FILE, "w") as report:


    report.write(
        "=================================\n"
    )


    report.write(
        "      Muteb SOC Port Scan         \n"
    )


    report.write(
        "=================================\n\n"
    )


    report.write(
        f"Target: {TARGET}\n"
    )


    report.write(
        f"Time: {datetime.now()}\n\n"
    )



    report.write(
        "Open Ports:\n\n"
    )



    if open_ports:


        for port in open_ports:


            report.write(
                f"Port {port} is OPEN\n"
            )


    else:


        report.write(
            "No open ports detected\n"
        )





# =====================================================
# عرض النتيجة
# =====================================================


print("=================================")

print("Port Scan Completed")

print(f"Report saved: {REPORT_FILE}")

print("=================================")
