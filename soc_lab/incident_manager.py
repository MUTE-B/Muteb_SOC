#!/usr/bin/env python3

"""
MUTEB SOC - Incident Case Manager

Creates investigation cases from security alerts.
"""


import os
import json
import shutil
from datetime import datetime



ALERT_PATH = "soc_lab/alerts/high"

CASE_PATH = "soc_lab/investigations/cases"

EVIDENCE_PATH = "soc_lab/investigations/evidence"

TIMELINE_PATH = "soc_lab/investigations/timeline"




def create_structure():

    folders = [

        CASE_PATH,

        EVIDENCE_PATH,

        TIMELINE_PATH

    ]


    for folder in folders:

        os.makedirs(
            folder,
            exist_ok=True
        )





def create_case(alert_file):


    with open(
        alert_file
    ) as file:

        alert = json.load(file)



    case_id = (
        "CASE-"
        +
        datetime.now().strftime(
            "%Y%m%d%H%M%S"
        )
    )



    case = {


        "case_id":

        case_id,


        "incident_title":

        alert["title"],


        "severity":

        alert["severity"],


        "created":

        str(datetime.now()),


        "status":

        "OPEN",


        "evidence":

        alert["evidence"],


        "analyst":

        "MUTEB"



    }




    case_file = (

        f"{CASE_PATH}/"

        f"{case_id}.json"

    )



    with open(

        case_file,

        "w"

    ) as output:


        json.dump(

            case,

            output,

            indent=4

        )



    print(

        f"[CASE CREATED] {case_id}"

    )





def process_alerts():


    if not os.path.exists(ALERT_PATH):

        print(
            "No alerts found"
        )

        return



    for alert in os.listdir(ALERT_PATH):


        if alert.endswith(".json"):


            create_case(

                f"{ALERT_PATH}/{alert}"

            )





if __name__ == "__main__":


    print(
        "=== MUTEB SOC CASE MANAGER ==="
    )


    create_structure()


    process_alerts()


    print(
        "[+] Incident Processing Completed"
    )

