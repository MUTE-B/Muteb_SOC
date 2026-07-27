#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# IOC Scanner v2
# ==========================================================
#

import json
import os
import re
import datetime


LOG_FILE="/var/log/auth.log"

IOC_DB="threat_intel/ioc_database.json"

REPORT="reports/ioc_scan_report.json"



def load_iocs():

    if not os.path.exists(IOC_DB):

        database={

            "malicious_ips":[
                "192.168.1.100"
            ],

            "malicious_domains":[
                "evil.com"
            ]

        }


        with open(IOC_DB,"w") as f:

            json.dump(
                database,
                f,
                indent=4
            )


    with open(IOC_DB) as f:

        return json.load(f)




def scan():


    iocs=load_iocs()

    findings=[]


    if not os.path.exists(LOG_FILE):

        print("Log file missing")

        return



    with open(LOG_FILE,errors="ignore") as log:


        for line in log:


            for ip in iocs["malicious_ips"]:


                if ip in line:


                    findings.append({

                        "type":"Malicious IP",

                        "ioc":ip,

                        "log":line.strip()

                    })



            for domain in iocs["malicious_domains"]:


                if domain in line:


                    findings.append({

                        "type":"Malicious Domain",

                        "ioc":domain,

                        "log":line.strip()

                    })




    report={


        "tool":

        "MUTEB SOC IOC Scanner",


        "timestamp":

        str(datetime.datetime.now()),


        "detections":

        len(findings),


        "findings":

        findings


    }



    os.makedirs(

        "reports",

        exist_ok=True

    )


    with open(REPORT,"w") as f:


        json.dump(

            report,

            f,

            indent=4

        )



    print("[+] IOC Scan Completed")

    print("[+] Detections:",len(findings))

    print("[+] Report:",REPORT)




if __name__=="__main__":

    scan()

