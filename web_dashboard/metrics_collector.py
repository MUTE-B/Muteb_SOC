#!/usr/bin/env python3

import os
import json
import datetime
import shutil


REPORT_FILE = "reports/system_metrics.json"



def collect_metrics():

    os.makedirs(
        "reports",
        exist_ok=True
    )


    total, used, free = shutil.disk_usage("/")


    metrics = {

        "time":
        str(datetime.datetime.now()),

        "hostname":
        os.uname().nodename,

        "disk_total_gb":
        round(total / (1024**3), 2),

        "disk_used_gb":
        round(used / (1024**3), 2),

        "disk_free_gb":
        round(free / (1024**3), 2)

    }


    with open(REPORT_FILE, "w") as file:

        json.dump(
            metrics,
            file,
            indent=4
        )


    print("[+] System Metrics Collected")



if __name__ == "__main__":

    collect_metrics()

