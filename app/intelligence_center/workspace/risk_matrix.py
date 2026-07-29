

class RiskMatrix:



    def calculate(self,impact,probability):


        score=impact*probability



        if score>=20:

            level="CRITICAL"


        elif score>=12:

            level="HIGH"


        elif score>=6:

            level="MEDIUM"


        else:

            level="LOW"



        return {


        "score":score,

        "level":level



        }



