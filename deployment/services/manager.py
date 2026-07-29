

class ServiceManager:



    services=[


    "SOC",

    "AI",

    "SIEM",

    "SOAR",

    "DFIR",

    "Threat Intelligence",

    "Dashboard"



    ]



    def status(self):


        return {


        "services":

        self.services,


        "status":

        "RUNNING"



        }



