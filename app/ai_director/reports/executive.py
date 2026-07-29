

class ExecutiveAdvisor:



    def generate(self,result):


        return {


        "executive_summary":

        "Cyber security assessment completed",


        "decision":

        result.get(

        "priority"

        ),


        "recommended_action":

        result.get(

        "recommendation"

        )


        }



