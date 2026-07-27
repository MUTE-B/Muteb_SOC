#!/usr/bin/env python3

import json
import socket
import platform
import datetime
import psutil
import os


REPORT_DIR="reports"

os.makedirs(REPORT_DIR, exist_ok=True)


report={

    "project":"Muteb SOC",

    "hostname":socket.gethostname(),

    "system":platform.system(),

    "kernel":platform.release(),

    "cpu_usage":psutil.cpu_percent(),

    "memory_usage":psutil.virtual_memory().percent,

    "disk_usage":psutil.disk_usage('/').percent,

    "network":

    {
        "ip":socket.gethostbyname(socket.gethostname())
    },

    "timestamp":

    str(datetime.datetime.now())

}


with open(

f"{REPORT_DIR}/security_report.json",

"w"

) as file:

    json.dump(report,file,indent=4)



print("[+] JSON Security Report Generated")

