

from datetime import datetime



def generate_security_report(data):


    return {


        "report":

        "MUTEB SOC Security Assessment",


        "generated":

        str(datetime.utcnow()),


        "summary":{


            "alerts":

            data.get("alerts",0),


            "incidents":

            data.get("incidents",0),


            "risk_level":

            data.get("risk","UNKNOWN")

        },


        "recommendations":[


            "Review critical alerts",

            "Validate security controls",

            "Update threat intelligence"

        ]

    }





def generate_executive_report(data):


    return {


        "title":

        "MUTEB SOC Executive Report",


        "status":

        "CONFIDENTIAL",


        "metrics":

        data,


        "generated":

        str(datetime.utcnow())

    }

