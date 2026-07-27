#!/usr/bin/env python3

"""
MUTEB SOC - Alert Detection Engine

Analyzes collected logs and generates
security alerts for SOC investigation.
"""


import os
import json
from datetime import datetime



LOG_FILE = "soc_lab/logs/auth"


ALERT_DIR = "soc_lab/alerts/high"



RULES = {

    "SSH_BRUTE_FORCE":
    [
        "Failed password",
        "authentication failure"
    ],


    "SUSPICIOUS_COMMAND":
    [
        "curl",
        "wget",
        "/bin/bash",
        "/bin/sh"
    ]

}




def create_alert(title, severity, evidence):

    os.makedirs(
        ALERT_DIR,
        exist_ok=True
    )


    alert = {

        "alert_id":
        f"MUTEB-{datetime.now().strftime('%H%M%S')}",

        "title":
        title,

        "severity":
        severity,

        "timestamp":
        str(datetime.now()),

        "evidence":
        evidence,

        "status":
        "NEW"

    }


    filename = (
        f"{ALERT_DIR}/"
        f"{alert['alert_id']}.json"
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
        f"[ALERT CREATED] {title}"
    )




def analyze_logs():


    if not os.path.exists(LOG_FILE):

        print(
            "[!] No authentication logs found"
        )

        return



    for file in os.listdir(LOG_FILE):

        path = (
            f"{LOG_FILE}/{file}"
        )


        with open(
            path,
            errors="ignore"
        ) as log:


            for line in log:


                for rule, patterns in RULES.items():


                    for pattern in patterns:


                        if pattern in line:


                            create_alert(

                                rule,

                                "HIGH",

                                line.strip()

                            )

                            break




if __name__ == "__main__":

    print(
        "=== MUTEB SOC DETECTION ENGINE ==="
    )


    analyze_logs()


    print(
        "[+] Detection Completed"
    )

