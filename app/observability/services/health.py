

from datetime import datetime



class ServiceHealth:



    services={


    "SOC Core":

    "ONLINE",


    "SIEM":

    "ONLINE",


    "SOAR":

    "ONLINE",


    "AI Engine":

    "ONLINE",


    "Threat Intelligence":

    "ONLINE",


    "Command Center":

    "ONLINE"



    }



    def status(self):


        return {


        "services":

        self.services,


        "checked":

        str(datetime.utcnow()),


        "overall":

        "HEALTHY"



        }



