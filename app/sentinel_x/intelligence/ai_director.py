

class AISecurityDirector:



    def advise(self,risk):


        level=risk.get(
            "risk_level"
        )


        actions={


        "CRITICAL":
        "Immediate remediation required",


        "HIGH":
        "Fix within 72 hours",


        "MEDIUM":
        "Schedule security improvement",


        "LOW":
        "Maintain security controls"



        }


        return {


        "priority":level,


        "recommendation":
        actions.get(
            level,
            "Monitor"
        )



        }



