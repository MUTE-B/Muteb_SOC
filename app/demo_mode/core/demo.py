

from datetime import datetime



class DemoEnvironment:



    def load(self):


        return {


        "organization":

        "Demo Enterprise Organization",



        "security_profile":{


            "security_score":

            94,


            "security_level":

            "STRONG",


            "assets":

            120,


            "protected_assets":

            118


        },



        "risk_summary":{


            "critical":

            0,


            "high":

            3,


            "medium":

            7,


            "low":

            12


        },



        "modules":[


            "Sentinel X",

            "Threat Intelligence",

            "AI Security Director",

            "Compliance Center",

            "SOC Command Center"


        ],



        "generated":

        str(datetime.utcnow())


        }



