#!/usr/bin/env python3

import os
import datetime


LOG_FILE = "logs/dashboard_audit.log"


def write_log(event):

    os.makedirs(
        "logs",
        exist_ok=True
    )

    timestamp = datetime.datetime.now()

    with open(LOG_FILE, "a") as file:

        file.write(
            f"{timestamp} - {event}\n"
        )


if __name__ == "__main__":

    write_log(
        "MUTEB SOC Dashboard Access"
    )

    print("[+] Audit Log Created")

