#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# Persistence Threat Hunter
# ==========================================================
#

import os
import json
import datetime
import subprocess


REPORT = "reports/persistence_hunting.json"



def check_cron():

    findings = []

    paths = [

        "/etc/crontab",
        "/etc/cron.d",
        "/var/spool/cron"

    ]


    for path in paths:

        if os.path.exists(path):

            findings.append({

                "type":"Cron Persistence",

                "location":path

            })


    return findings




def check_ssh_keys():

    findings=[]


    users="/home"


    if os.path.exists(users):


        for user in os.listdir(users):


            key=os.path.join(

                users,

                user,

                ".ssh/authorized_keys"

            )


            if os.path.exists(key):


                findings.append({

                    "type":

                    "SSH Authorized Key",

                    "user":

                    user,

                    "file":

                    key

                })


    return findings




def check_services():

    findings=[]


    try:

        output=subprocess.check_output(

            ["systemctl","list-unit-files","--type=service"],

            text=True

        )


        for line in output.splitlines():

            if "enabled" in line:

                findings.append({

                    "type":

                    "Enabled Service",

                    "service":

                    line.strip()

                })


    except:

        pass



    return findings




def hunt():


    results=[]


    results.extend(check_cron())

    results.extend(check_ssh_keys())

    results.extend(check_services())



    report={


        "tool":

        "MUTEB SOC Persistence Hunter",


        "timestamp":

        str(datetime.datetime.now()),


        "detections":

        len(results),


        "findings":

        results


    }



    os.makedirs(

        "reports",

        exist_ok=True

    )


    with open(

        REPORT,

        "w"

    ) as file:


        json.dump(

            report,

            file,

            indent=4

        )



    print("[+] Persistence Hunting Completed")

    print("[+] Findings:",len(results))

    print("[+] Report:",REPORT)




if __name__=="__main__":

    hunt()

