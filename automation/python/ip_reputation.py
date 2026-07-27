#!/usr/bin/env python3


# =====================================================
# Muteb SOC IP Reputation Checker
#
# الهدف:
# تجهيز أداة لتحليل سمعة عناوين IP
#
# الوظائف:
# - التحقق من صيغة IP
# - تصنيف العنوان
# - تجهيز مكان لإضافة Threat Intelligence APIs
# =====================================================



import ipaddress
from datetime import datetime



# عنوان IP المراد تحليله

TARGET_IP = "8.8.8.8"




def validate_ip(ip):

    """
    التحقق من صحة عنوان IP
    """

    try:

        ipaddress.ip_address(ip)

        return True


    except ValueError:

        return False





def analyze_ip(ip):

    """
    تحليل معلومات أساسية عن IP
    """



    address = ipaddress.ip_address(ip)



    print("==============================")

    print("Muteb SOC IP Analysis")

    print("==============================")



    print("Analysis Time:")

    print(datetime.now())



    print("")



    print("IP Address:")

    print(address)



    print("")



    if address.is_private:

        print("Network Type: Private IP")


    else:

        print("Network Type: Public IP")



    print("")

    print("Future Integration:")

    print(
        "Threat Intelligence API can be connected here"
    )





def main():



    if validate_ip(TARGET_IP):


        analyze_ip(TARGET_IP)



    else:


        print("Invalid IP Address")





if __name__ == "__main__":


    main()
#!/usr/bin/env python3


# =====================================================
# Muteb SOC IP Reputation Analyzer
#
# الهدف:
# تحليل سمعة عنوان IP داخل بيئة SOC
#
# يقوم البرنامج بـ:
# - استقبال IP
# - مقارنة IP مع قائمة تهديدات محلية
# - تحديد مستوى الخطورة
# - إنشاء تقرير
# =====================================================



# استيراد المكتبات

from datetime import datetime





# قاعدة بيانات تهديدات محلية تجريبية

KNOWN_MALICIOUS_IPS = [

    "192.0.2.10",
    "198.51.100.25",
    "203.0.113.50"

]





# ملف التقرير

REPORT_FILE = "ip_reputation_report.txt"





# =====================================================
# استقبال عنوان IP
# =====================================================


target_ip = input(
    "Enter IP Address: "
)





# =====================================================
# تحليل السمعة
# =====================================================


if target_ip in KNOWN_MALICIOUS_IPS:


    reputation = "MALICIOUS"


    risk = "HIGH"



else:


    reputation = "UNKNOWN"


    risk = "LOW"





# =====================================================
# إنشاء التقرير
# =====================================================


with open(REPORT_FILE, "w") as report:


    report.write(
        "=================================\n"
    )


    report.write(
        "   Muteb SOC IP Reputation Report\n"
    )


    report.write(
        "=================================\n\n"
    )



    report.write(
        f"IP Address: {target_ip}\n"
    )


    report.write(
        f"Analysis Time: {datetime.now()}\n\n"
    )



    report.write(
        f"Reputation: {reputation}\n"
    )


    report.write(
        f"Risk Level: {risk}\n"
    )





# =====================================================
# عرض النتيجة
# =====================================================


print("=================================")

print("IP Reputation Analysis Completed")

print(f"Result: {reputation}")

print(f"Risk Level: {risk}")

print(f"Report: {REPORT_FILE}")

print("=================================")
