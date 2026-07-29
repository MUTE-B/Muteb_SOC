

class AttackSimulation:



    scenarios=[


    "Phishing Attack",

    "Malware Execution",

    "Credential Theft",

    "Network Intrusion",

    "Privilege Escalation"



    ]



    def list(self):


        return {


        "scenarios":

        self.scenarios,


        "count":

        len(self.scenarios),


        "status":

        "AVAILABLE"



        }



