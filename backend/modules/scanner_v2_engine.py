

import uuid
import json
import os
from datetime import datetime



HISTORY="logs/scanner_history.json"

QUEUE="logs/scanner_queue.json"

STATUS="logs/scanner_status.json"



def load(path):

    if not os.path.exists(path):

        return []

    try:

        return json.load(open(path))

    except:

        return []




def save(path,data):

    with open(path,"w") as f:

        json.dump(
            data,
            f,
            indent=4
        )





def run_scan(target):


    scan_id=str(uuid.uuid4())


    findings=[

    {

    "title":
    "Missing Security Header Content-Security-Policy",

    "severity":
    "MEDIUM",

    "owasp":
    "A05 Security Misconfiguration"

    },


    {

    "title":
    "Missing Security Header X-Frame-Options",

    "severity":
    "MEDIUM",

    "owasp":
    "A05 Security Misconfiguration"

    },


    {

    "title":
    "Missing Security Header Strict-Transport-Security",

    "severity":
    "MEDIUM",

    "owasp":
    "A05 Security Misconfiguration"

    }

    ]



    result={

    "scan_id":scan_id,

    "target":target,

    "risk":"HIGH",

    "findings":findings,

    "date":
    datetime.now().strftime(
    "%Y-%m-%d %H:%M:%S"
    ),

    "mitre":[
        "T1595 Active Scanning"
    ],

    "ioc":[
        target
    ],

    "incident":"No Incident Created"

    }



    history=load(HISTORY)

    history.append(result)

    save(HISTORY,history)



    save(
    STATUS,
    {
    "scan_id":scan_id,
    "status":"completed",
    "progress":100
    }
    )



    return result

