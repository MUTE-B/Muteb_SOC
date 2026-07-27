#!/usr/bin/env python3

from datetime import datetime
import os


ACCESS_LOG = "logs/dashboard_access.log"



def log_access(ip, endpoint):

    os.makedirs(
        "logs",
        exist_ok=True
    )


    with open(ACCESS_LOG, "a") as file:

        file.write(
            f"{datetime.now()} | {ip} | {endpoint}\n"
        )


