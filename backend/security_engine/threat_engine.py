
from datetime import datetime


def analyze_event(event):

    score = 0
    level = "LOW"


    text=str(event).lower()


    indicators=[
        "failed login",
        "bruteforce",
        "malware",
        "root",
        "privilege"
    ]


    for item in indicators:

        if item in text:
            score +=20



    if score >=80:
        level="CRITICAL"

    elif score >=40:
        level="HIGH"


    return {

        "threat_score":score,
        "severity":level,
        "timestamp":str(datetime.utcnow())

    }


