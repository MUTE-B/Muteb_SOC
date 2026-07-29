

class RiskEngine:



    def calculate(self,findings):


        score=100



        for item in findings:



            if item=="critical":

                score-=40



            elif item=="high":

                score-=25



            elif item=="medium":

                score-=15



            elif item=="low":

                score-=5




        if score < 40:

            level="CRITICAL"


        elif score <70:

            level="HIGH"


        elif score <90:

            level="MEDIUM"


        else:

            level="LOW"



        return {


        "security_score":

        max(score,0),


        "risk_level":

        level



        }



