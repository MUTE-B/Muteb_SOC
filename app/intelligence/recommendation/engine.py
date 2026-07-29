

class RecommendationEngine:



    def generate(self,risk):


        if risk >=90:


            action="Immediate remediation required"



        elif risk >=70:


            action="Schedule remediation within 72 hours"



        else:


            action="Continue monitoring"



        return {


        "recommendation":

        action,


        "owner":

        "Security Team"



        }



