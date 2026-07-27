#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# Network Threat Hunter
# ==========================================================
#

import subprocess
import json
import datetime
import os


REPORT = "reports/network_hunting.json"



def hunt_network():


    findings = []


    try:


        output = subprocess.check_output(

            ["ss","-tunap"],

            text=True

        )


    except Exception as e:


        print(e)

        return



    lines = output.splitlines()



    for line in lines[1:]:


        if line.strip():


            findings.append({

                "connection":

                line.strip()

            })



    report = {


        "tool":

        "MUTEB SOC Network Hunter",


        "timestamp":

        str(datetime.datetime.now()),


        "active_connections":

        len(findings),


        "connections":

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



    print("[+] Network Hunting Completed")

    print("[+] Connections:", len(findings))

    print("[+] Report:", REPORT)




if __name__ == "__main__":

    hunt_network()

