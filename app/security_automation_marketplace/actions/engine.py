

class AutomationActions:



    actions={


    "isolate_host":

    "Endpoint Isolation",


    "block_ip":

    "Firewall Blocking",


    "disable_account":

    "Identity Protection",


    "collect_logs":

    "Evidence Collection"



    }



    def execute(self,name):


        return {


        "action":

        name,


        "result":

        "EXECUTED",


        "automation":

        "ACTIVE"



        }



