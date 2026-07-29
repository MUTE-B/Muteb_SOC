

class SecurityPlaybook:



    def execute(self,action):


        workflows={



        "ISOLATE":

        "Endpoint isolation workflow started",



        "INVESTIGATE":

        "Investigation workflow started",



        "MONITOR":

        "Continuous monitoring enabled"



        }



        return {


        "action":

        action,


        "result":

        workflows.get(

        action,

        "Unknown workflow"

        )



        }



