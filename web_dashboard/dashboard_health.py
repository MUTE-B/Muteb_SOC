#!/usr/bin/env python3

import os
import datetime
import json


HEALTH_FILE = "reports/dashboard_health.json"



def health_check():

    status = {

        "service":
        "MUTEB SOC Dashboard",

        "status":
        "ONLINE",

        "time":
        str(datetime.datetime.now()),

        "checks":

        {

            "reports_directory":
            os.path.exists("reports"),

            "logs_directory":
            os.path.exists("logs"),

            "dashboard":
            True

        }

    }


    os.makedirs(
        "reports",
        exist_ok=True
    )


    with open(HEALTH_FILE, "w") as file:

        json.dump(
            status,
            file,
            indent=4
        )


    print("[+] Dashboard Health Check Completed")



if __name__ == "__main__":

    health_check()

