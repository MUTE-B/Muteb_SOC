

from datetime import datetime



class SecurityReport:



    def generate(self,asset,risk):


        return {


        "asset":

        asset,


        "assessment":

        "AUTHORIZED SECURITY ASSESSMENT",


        "score":

        risk["security_score"],


        "risk":

        risk["risk_level"],


        "generated":

        str(datetime.utcnow())


        }



