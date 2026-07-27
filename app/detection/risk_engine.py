

class RiskEngine:


    def calculate(
        self,
        event
    ):


        score = 0



        text = event.lower()



        if "failed" in text:

            score += 40



        if "invalid" in text:

            score += 30



        if "root" in text:

            score += 20



        if "authentication failure" in text:

            score += 40



        if score >= 70:

            severity="CRITICAL"


        elif score >=40:

            severity="HIGH"


        elif score >=20:

            severity="MEDIUM"


        else:

            severity="LOW"



        return {

            "score":score,

            "severity":severity

        }




risk_engine=RiskEngine()

