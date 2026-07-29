

class RunbookEngine:



    runbooks={


    "incident":

    "Incident Response Procedure",


    "malware":

    "Malware Containment Procedure",


    "phishing":

    "Phishing Investigation Procedure",


    "breach":

    "Security Breach Response"



    }



    def get(self,name):


        return {


        "runbook":

        self.runbooks.get(name),


        "status":

        "READY"



        }



