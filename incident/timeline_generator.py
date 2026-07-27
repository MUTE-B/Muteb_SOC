#!/usr/bin/env python3

import os
import json
import datetime


REPORT="cases/timeline_CASE.json"


LOGS=[
"/var/log/auth.log",
"/var/log/syslog"
]


def generate_timeline():

    events=[]

    for log in LOGS:

        if not os.path.exists(log):
            continue

        with open(log, errors="ignore") as file:

            for line in file:

                if any(x in line.lower() for x in [
                    "failed",
                    "accepted",
                    "sudo",
                    "cron",
                    "login"
                ]):

                    events.append({
                        "source": log,
                        "event": line.strip()
                    })


    os.makedirs("cases", exist_ok=True)


    report={

        "tool":
        "MUTEB SOC Timeline Generator",

        "generated":
        str(datetime.datetime.now()),

        "events_count":
        len(events),

        "timeline":
        events

    }


    with open(REPORT,"w") as file:

        json.dump(
            report,
            file,
            indent=4
        )


    print("[+] Timeline Generated")
    print("[+] Events:",len(events))
    print("[+] Report:",REPORT)



if __name__=="__main__":

    generate_timeline()

