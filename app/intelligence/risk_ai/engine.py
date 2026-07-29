

class AIRiskEngine:


    def calculate(self,data):


        severity=data.get(
            "severity",
            "LOW"
        )


        mapping={

        "CRITICAL":95,

        "HIGH":75,

        "MEDIUM":45,

        "LOW":20

        }


        score=mapping.get(
            severity,
            20
        )


        return {


        "risk_score":

        score,


        "priority":

        "URGENT"
        if score >=90
        else
        "HIGH"
        if score >=70
        else
        "NORMAL",


        "analysis":

        "AI risk evaluation completed"


        }



