

from datetime import datetime



def hunting_report(data):


    return {


        "report":

        "MUTEB SOC Threat Hunting Report",


        "analyst":

        data.get("analyst","SOC Analyst"),


        "findings":

        data.get("findings",[]),


        "generated":

        str(datetime.utcnow())

    }

