#!/usr/bin/env python3

"""
MUTEB SOC SIEM Engine

Simulates SIEM event correlation,
rule matching and alert generation.
"""


import json
import os
from datetime import datetime



EVENT_FILE = "soc_lab/siem/events/security_events.log"

RULE_FILE = "soc_lab/siem/rules/detection_rules.json"

ALERT_FILE = "soc_lab/siem/alerts.json"





def load_rules():

    with open(RULE_FILE) as file:

        return json.load(file)





def generate_alert(event, rule):


    return {

        "alert_id":
        "SIEM-" + datetime.now().strftime("%H%M%S"),

        "rule":
        rule["rule_id"],

        "severity":
        rule["severity"],

        "description":
        rule["description"],

        "event":
        event.strip(),

        "time":
        str(datetime.now())

    }





def run_engine():


    rules = load_rules()

    alerts = []



    with open(EVENT_FILE) as events:


        for event in events:


            for rule in rules:


                if rule["event"] in event:


                    alerts.append(

                        generate_alert(
                            event,
                            rule
                        )

                    )



    with open(
        ALERT_FILE,
        "w"
    ) as file:


        json.dump(
            alerts,
            file,
            indent=4
        )


    print(
        f"[+] SIEM Generated {len(alerts)} Alerts"
    )





if __name__ == "__main__":

    print(
        "=== MUTEB SOC SIEM ENGINE ==="
    )

    run_engine()

