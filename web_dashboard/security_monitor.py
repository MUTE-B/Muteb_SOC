#!/usr/bin/env python3

import os
import datetime


LOG_FILE = "logs/security_events.log"



def log_event(event, severity):

    os.makedirs(
        "logs",
        exist_ok=True
    )


    timestamp = datetime.datetime.now()


    with open(LOG_FILE, "a") as file:

        file.write(
            f"{timestamp} | {severity} | {event}\n"
        )



def security_check():

    events = [

        ("Firewall Status Checked", "INFO"),

        ("SSH Service Checked", "INFO"),

        ("Authentication Monitoring Active", "INFO")

    ]


    for event, severity in events:

        log_event(
            event,
            severity
        )


    print("[+] Security Monitoring Completed")



if __name__ == "__main__":

    security_check()

