
from datetime import datetime


def process_hunt():

    return {

        "module":"Process Hunting",

        "status":"ACTIVE",

        "findings":[

            {
            "process":"unknown.exe",
            "risk":"HIGH"
            }

        ],

        "time":str(datetime.utcnow())

    }



def network_hunt():

    return {

        "module":"Network Hunting",

        "status":"ACTIVE",

        "connections":[

            {
            "destination":"external_ip",
            "risk":"MEDIUM"
            }

        ]

    }



def file_hunt():

    return {

        "module":"File Hunting",

        "status":"ACTIVE",

        "files":[

            {
            "file":"suspicious_file",
            "action":"MONITOR"
            }

        ]

    }


