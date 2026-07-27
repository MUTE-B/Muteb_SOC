
from datetime import datetime


def hunt_event(event):

    findings = []


    message = event.get(
        "message",
        ""
    ).lower()


    suspicious_patterns = [

        "failed password",

        "unauthorized",

        "malware",

        "powershell",

        "reverse shell",

        "root login"

    ]


    for pattern in suspicious_patterns:


        if pattern in message:


            findings.append({

                "pattern":
                pattern,

                "severity":
                "HIGH",

                "timestamp":
                str(datetime.now()),

                "message":
                event.get("message")

            })


    return findings
