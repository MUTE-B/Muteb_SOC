

class ManagementReport:



    def generate(self,data):


        risk=data.get(
            "risk",
            {}
        )


        return {


        "report_type":
        "Management Security Report",


        "security_score":
        risk.get(
            "security_score"
        ),


        "risk_level":
        risk.get(
            "risk_level"
        ),


        "business_priority":
        "Security Improvement"



        }


