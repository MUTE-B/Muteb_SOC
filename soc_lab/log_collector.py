#!/usr/bin/env python3

"""
MUTEB SOC - Log Collector Module

Collects important Linux security logs
for SOC monitoring and investigation.
"""


import os
import shutil
from datetime import datetime


LOG_SOURCES = {

    "auth":
    "/var/log/auth.log",

    "system":
    "/var/log/syslog",

    "web":
    "/var/log/apache2/access.log"

}



BASE_DIR = "soc_lab/logs"



def create_directories():

    for folder in LOG_SOURCES:

        os.makedirs(
            f"{BASE_DIR}/{folder}",
            exist_ok=True
        )



def collect_logs():

    timestamp = datetime.now().strftime(
        "%Y%m%d_%H%M%S"
    )


    for name, source in LOG_SOURCES.items():

        if os.path.exists(source):

            destination = (
                f"{BASE_DIR}/{name}/"
                f"{name}_{timestamp}.log"
            )


            shutil.copy(
                source,
                destination
            )


            print(
                f"[+] Collected {name} logs"
            )


        else:

            print(
                f"[!] Log unavailable: {source}"
            )



if __name__ == "__main__":

    print(
        "=== MUTEB SOC LOG COLLECTOR ==="
    )

    create_directories()

    collect_logs()

    print(
        "[+] Collection Completed"
    )

