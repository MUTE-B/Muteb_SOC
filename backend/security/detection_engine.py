

def analyze(events):


    alerts=[]


    rules={


    "Failed password":"SSH Brute Force",

    "Invalid user":"Account Discovery",

    "sudo":"Privilege Escalation",

    "malware":"Malware Activity"


    }



    for event in events:


        for key,value in rules.items():


            if key.lower() in event.lower():


                alerts.append({

                "title":value,

                "severity":"HIGH",

                "event":event,

                "mitre":"TA0001"

                })


    return alerts



