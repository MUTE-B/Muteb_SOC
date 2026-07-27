#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC
# Detection Rule Engine
# ==========================================================
#

import os
import json
import datetime


RULES_FILE = "detections/mitre_mapping.yml"
REPORT = "reports/detection_results.json"



def load_rules():

    rules = []

    if os.path.exists(RULES_FILE):

        with open(RULES_FILE, "r") as file:

            for line in file:

                if "name:" in line:

                    rules.append(
                        line.split("name:")[1].strip()
                    )

    return rules



def run_detection():

    rules = load_rules()


    results = {

        "engine":
        "MUTEB SOC Detection Engine",

        "time":
        str(datetime.datetime.now()),

        "rules_loaded":
        len(rules),

        "detections":
        rules

    }


    os.makedirs(
        "reports",
        exist_ok=True
    )


    with open(REPORT,"w") as file:

        json.dump(
            results,
            file,
            indent=4
        )


    print("[+] Detection Engine Completed")
    print("[+] Rules Loaded:", len(rules))
    print("[+] Report:", REPORT)



if __name__ == "__main__":

    run_detection()

