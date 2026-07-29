

from datetime import datetime



class AISecurityDirector:



    def evaluate(self,data):


        risk=data.get(

        "risk",

        "LOW"

        )


        impact=data.get(

        "impact",

        "LOW"

        )



        if risk=="CRITICAL" or impact=="HIGH":


            priority="URGENT"


            action=(

            "Immediate security response required"

            )



        elif risk=="HIGH":


            priority="HIGH"


            action=(

            "Remediation should begin within 72 hours"

            )



        else:


            priority="NORMAL"


            action=(

            "Continue monitoring and improve controls"

            )




        return {


        "security_director":

        "MUTEB AI Security Director",


        "priority":

        priority,


        "risk":

        risk,


        "business_impact":

        impact,


        "recommendation":

        action,


        "generated":

        str(datetime.utcnow())



        }



