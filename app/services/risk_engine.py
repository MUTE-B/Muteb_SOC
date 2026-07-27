
class RiskEngine:


    def score(self,severity):


        levels={

        "LOW":25,

        "MEDIUM":50,

        "HIGH":75,

        "CRITICAL":100

        }


        return levels.get(
            severity.upper(),
            0
        )



risk_engine=RiskEngine()

