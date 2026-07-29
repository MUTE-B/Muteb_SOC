

class RiskEngine:



    def calculate(self,findings):


        score=100


        for item in findings:


            level=item.get(
                "severity"
            )


            if level=="CRITICAL":

                score-=40


            elif level=="HIGH":

                score-=20


            elif level=="MEDIUM":

                score-=10


            elif level=="LOW":

                score-=5



        if score<0:

            score=0



        return {


        "security_score":score,


        "risk_level":
        self.level(score)


        }



    def level(self,score):


        if score>=90:

            return "LOW"


        if score>=70:

            return "MEDIUM"


        if score>=40:

            return "HIGH"


        return "CRITICAL"



