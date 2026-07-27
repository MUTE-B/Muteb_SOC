#!/usr/bin/env python3

"""
MUTEB SOC - Active Directory Monitor

Simulates identity monitoring
for SOC investigations.
"""


import os
import json
from datetime import datetime



LOG_FILE = "soc_lab/active_directory/login_events.log"

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

        f"AD_{datetime.now().strftime('%H%M%S')}.json"

    )


    with open(filename,"w") as file:

        json.dump(
            alert,
            file,
            indent=4
        )


    print(
        "[ALERT CREATED]",
        title
    )





def analyze_identity_events():


    if not os.path.exists(LOG_FILE):

        print("No AD logs")

        return



    failed_attempts = 0



    with open(LOG_FILE) as log:


        for line in log:


            if "EventID:4625" in line:

                failed_attempts += 1



                if failed_attempts >= 2:

                    create_alert(
                        "Possible Account Brute Force",
                        line.strip()
                    )


            if "EventID:4672" in line:

                create_alert(
                    "Privileged Account Usage Detected",
                    line.strip()
                )





if __name__ == "__main__":


    print(
        "=== MUTEB SOC AD MONITOR ==="
    )


    analyze_identity_events()

