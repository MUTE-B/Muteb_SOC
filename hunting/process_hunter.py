#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# Process Threat Hunter
# ==========================================================
#

import subprocess
import datetime
import json
import os


REPORT = "reports/process_hunting.json"



SUSPICIOUS_PATHS = [

    "/tmp",
    "/dev/shm",
    "/var/tmp"

]



def hunt_processes():


    findings = []


    output = subprocess.check_output(

        ["ps","aux"],

        text=True

    )



    for line in output.splitlines()[1:]:


        for path in SUSPICIOUS_PATHS:


            if path in line:


                findings.append({

                    "type":
                    "Suspicious Process Location",


                    "path":
                    path,


                    "process":
                    line.strip()

                })



    report = {


        "tool":
        "MUTEB SOC Process Hunter",


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


    with open(

        REPORT,

        "w"

    ) as file:


        json.dump(

            report,

            file,

            indent=4

        )


    print("[+] Process Hunting Completed")

    print("[+] Detections:", len(findings))

    print("[+] Report:", REPORT)




if __name__ == "__main__":

    hunt_processes()

