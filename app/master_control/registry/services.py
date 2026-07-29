

class ServiceRegistry:



    services=[


        "SOC Core",

        "SIEM",

        "SOAR",

        "AI Copilot",

        "Threat Intelligence",

        "Threat Hunting",

        "DFIR",

        "GRC",

        "Vulnerability Management",

        "Data Lake",

        "Purple Team",

        "Dashboard"


    ]



    def list(self):


        return {


        "services":

        self.services,


        "total":

        len(self.services),


        "status":

        "REGISTERED"



        }



