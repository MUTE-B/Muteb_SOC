#!/usr/bin/env python3

"""
MUTEB SOC - Windows Event Analyzer

Analyzes Windows security events
for SOC monitoring.
"""


import os
import json
from datetime import datetime



LOG_FILE = "soc_lab/event_logs/windows_security_sample.log"


ALERT_DIR = "soc_lab/alerts/high"




def create_alert(title, evidence):


    os.makedirs(
        ALERT_DIR,
        exist_ok=True
    )


    alert = {

        "alert":

        title,


        "severity":

        "HIGH",


        "time":

        str(datetime.now()),


        "evidence":

        evidence

    }


    filename = (

        f"{ALERT_DIR}/"

        f"windows_alert_{datetime.now().strftime('%H%M%S')}.json"

    )


    with open(
        filename,
        "w"
    ) as file:


        json.dump(
            alert,
            file,
            indent=4
        )


    print(
        "[ALERT]",
        title
    )





def analyze():


    if not os.path.exists(LOG_FILE):

        print(
            "Windows log not found"
        )

        return



    with open(LOG_FILE) as log:


        for line in log:


            if "EventID:4625" in line:

                create_alert(
                    "Windows Failed Login Detection",
                    line.strip()
                )


            if "powershell.exe" in line:

                create_alert(
                    "Suspicious PowerShell Execution",
                    line.strip()
                )





if __name__ == "__main__":


    print(
        "=== MUTEB SOC WINDOWS ANALYZER ==="
    )


    analyze()

