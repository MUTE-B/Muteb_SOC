#!/usr/bin/env python3

"""
MUTEB SOC - SOC Dashboard

Displays security operations overview.
"""


import os
import json
from datetime import datetime



ALERT_DIR = "soc_lab/alerts/high"

CASE_DIR = "soc_lab/investigations/cases"





def count_files(directory):

    if not os.path.exists(directory):

        return 0


    return len(
        os.listdir(directory)
    )





def load_latest_cases():


    cases = []


    if not os.path.exists(CASE_DIR):

        return cases



    for file in os.listdir(CASE_DIR):


        if file.endswith(".json"):


            with open(
                f"{CASE_DIR}/{file}"
            ) as data:


                cases.append(
                    json.load(data)
                )


    return cases[-5:]





def show_dashboard():


    print(
        "\n================================="
    )

    print(
        "       MUTEB SOC DASHBOARD"
    )

    print(
        "=================================\n"
    )


    print(
        f"Alerts : {count_files(ALERT_DIR)}"
    )


    print(
        f"Cases  : {count_files(CASE_DIR)}"
    )


    print(
        "\nLatest Cases:"
    )


    for case in load_latest_cases():


        print(
            "---------------------------"
        )


        print(
            "ID:",
            case.get("case_id")
        )


        print(
            "Title:",
            case.get("incident_title")
        )


        print(
            "Severity:",
            case.get("severity")
        )


        print(
            "Status:",
            case.get("status")
        )





if __name__ == "__main__":


    show_dashboard()

