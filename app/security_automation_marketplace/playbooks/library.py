

class PlaybookLibrary:



    playbooks=[


    "Malware Response",

    "Phishing Investigation",

    "Account Compromise",

    "Threat Containment",

    "Incident Escalation"



    ]



    def list(self):


        return {


        "playbooks":

        self.playbooks,


        "count":

        len(self.playbooks),


        "status":

        "AVAILABLE"



        }



