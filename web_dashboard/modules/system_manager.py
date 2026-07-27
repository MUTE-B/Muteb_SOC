#!/usr/bin/env python3

import os
import json
import datetime
import platform
import psutil


OUTPUT="reports/system_status.json"


def collect_system_status():

    data={

        "project":"MUTEB SOC",

        "time":str(datetime.datetime.now()),

        "hostname":platform.node(),

        "os":platform.platform(),

        "cpu_percent":psutil.cpu_percent(),

        "memory_percent":psutil.virtual_memory().percent,

        "disk_percent":psutil.disk_usage('/').percent,

        "services":

        {

            "ssh":os.system("systemctl is-active ssh >/dev/null")==0,

            "apache2":os.system("systemctl is-active apache2 >/dev/null")==0,

            "ufw":os.system("systemctl is-active ufw >/dev/null")==0

        }

    }


    os.makedirs("reports",exist_ok=True)


    with open(OUTPUT,"w") as file:

        json.dump(data,file,indent=4)


    return data



if __name__=="__main__":

    print(json.dumps(
        collect_system_status(),
        indent=4
    ))

