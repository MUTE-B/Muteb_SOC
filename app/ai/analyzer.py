

from datetime import datetime



def summarize_alert(alert):


    severity = alert.get(

        "severity",

        "UNKNOWN"

    )


    title = alert.get(

        "title",

        "Security Event"

    )



    return {


        "summary":

        f"Detected {severity} security event: {title}",


        "risk":

        severity,


        "generated":

        str(datetime.utcnow())

    }




def recommend_actions(alert):


    severity=alert.get(

        "severity",

        "LOW"

    )



    actions=[]



    if severity=="CRITICAL":


        actions=[

            "Isolate affected asset",

            "Create incident",

            "Collect evidence"

        ]



    elif severity=="HIGH":


        actions=[

            "Investigate source",

            "Review logs",

            "Check threat intelligence"

        ]



    else:


        actions=[

            "Monitor event"

        ]



    return actions

