

class RiskEngine:


    def calculate(self,finding):

        levels={

        "critical":100,

        "high":80,

        "medium":50,

        "low":20

        }


        return levels.get(
            finding.lower(),
            0
        )



