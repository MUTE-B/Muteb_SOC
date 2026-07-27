

RULES = [

    {

        "name":
        "SSH BRUTE FORCE",

        "pattern":
        "Failed password",

        "severity":
        "HIGH",

        "mitre":
        "T1110"

    },


    {

        "name":
        "PRIVILEGE ESCALATION",

        "pattern":
        "sudo",

        "severity":
        "CRITICAL",

        "mitre":
        "T1548"

    },


    {

        "name":
        "PORT SCAN",

        "pattern":
        "scan",

        "severity":
        "MEDIUM",

        "mitre":
        "T1046"

    }

]


def analyze_event(event):


    detections=[]


    for rule in RULES:


        if rule["pattern"].lower() in event.lower():

            detections.append(rule)



    return detections

