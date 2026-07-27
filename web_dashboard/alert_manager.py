#!/usr/bin/env python3

import os
import datetime
import json


ALERT_FILE = "reports/security_alerts.json"



def create_alert(title, severity, description):

    os.makedirs(
        "reports",
        exist_ok=True
    )


    alert = {

        "time":
        str(datetime.datetime.now()),

        "title":
        title,

        "severity":
        severity,

        "description":
        description

    }


    alerts = []


    if os.path.exists(ALERT_FILE):

        with open(ALERT_FILE, "r") as file:

            alerts = json.load(file)


    alerts.append(alert)


    with open(ALERT_FILE, "w") as file:

        json.dump(
            alerts,
            file,
            indent=4
        )


    print("[+] Alert Created")



if __name__ == "__main__":

    create_alert(

        "MUTEB SOC Test Alert",

        "LOW",

        "Security alert manager verification"

    )

