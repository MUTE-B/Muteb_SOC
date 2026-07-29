

class MITREMapper:



    techniques={


    "phishing":

    "T1566",


    "credential_access":

    "T1003",


    "execution":

    "T1059",


    "exfiltration":

    "T1041"



    }



    def get(self,name):


        return {


        "technique":

        self.techniques.get(name),


        "framework":

        "MITRE ATT&CK"



        }



