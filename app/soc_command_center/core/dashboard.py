

from datetime import datetime



class SOCCommandCenter:



    def overview(self):


        return {



        "platform":

        "MUTEB SOC Command Center",



        "status":

        "OPERATIONAL",



        "security_score":

        92,



        "assets":{


            "total":

            25,


            "protected":

            25,


            "risk_assets":

            0



        },



        "threats":{


            "critical":

            0,


            "high":

            1,


            "medium":

            3,


            "low":

            5



        },



        "vulnerabilities":{


            "open":

            2,


            "closed":

            15



        },



        "last_update":

        str(datetime.utcnow())



        }



