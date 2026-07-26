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
