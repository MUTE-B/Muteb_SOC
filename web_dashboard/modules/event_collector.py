#!/usr/bin/env python3

import os
import datetime


EVENT_FILE="logs/security_events.log"


def collect_event(message,severity="INFO"):

    os.makedirs("logs",exist_ok=True)


    with open(EVENT_FILE,"a") as file:

        file.write(

            f"{datetime.datetime.now()} | {severity} | {message}\n"

        )


    print("[+] Event Stored")



if __name__=="__main__":

    collect_event(
        "MUTEB SOC Event Collector Started"
    )

