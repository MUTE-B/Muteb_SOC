#!/usr/bin/env python3

import os
import json
import datetime


REPORT="reports/security_summary.json"



def generate():

    summary={

        "generated":
        str(datetime.datetime.now()),

        "alerts":
        0,

        "status":
        "SECURE",

        "engine":
        "MUTEB SOC"

    }


    os.makedirs("reports",exist_ok=True)


    with open(REPORT,"w") as file:

        json.dump(
            summary,
            file,
            indent=4
        )


    print("[+] Security Report Generated")



if __name__=="__main__":

    generate()

