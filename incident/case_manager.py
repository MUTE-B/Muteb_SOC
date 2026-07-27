#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# Incident Case Manager
# ==========================================================
#

import json
import datetime
import os
import uuid



CASE_DIR="cases"



def create_case():


    os.makedirs(
        CASE_DIR,
        exist_ok=True
    )


    case_id = "CASE-" + str(uuid.uuid4())[:8]


    case = {


        "case_id":

        case_id,


        "created":

        str(datetime.datetime.now()),


        "title":

        input("Incident Title: "),


        "type":

        input("Incident Type: "),


        "severity":

        input("Severity (LOW/MEDIUM/HIGH): "),


        "status":

        "OPEN",


        "analyst":

        input("Analyst Name: ")


    }



    filename = os.path.join(

        CASE_DIR,

        case_id + ".json"

    )



    with open(

        filename,

        "w"

    ) as file:


        json.dump(

            case,

            file,

            indent=4

        )



    print()

    print("[+] Incident Created")

    print(filename)




if __name__=="__main__":

    create_case()

