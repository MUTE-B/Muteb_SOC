

from datetime import datetime



def generate_report(events):


    return {


        "report":

        "MUTEB SOC Executive Report",


        "generated":

        str(datetime.utcnow()),


        "total_events":

        len(events),


        "critical":

        len([

        e for e in events

        if e["severity"]=="CRITICAL"

        ]),


        "high":

        len([

        e for e in events

        if e["severity"]=="HIGH"

        ])


    }

