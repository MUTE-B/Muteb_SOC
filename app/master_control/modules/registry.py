

from datetime import datetime



class MasterRegistry:



    modules={


    "SIEM":

    "ONLINE",


    "SOAR":

    "ONLINE",


    "AI SOC":

    "ONLINE",


    "Threat Intelligence":

    "ONLINE",


    "DFIR":

    "ONLINE",


    "Vulnerability Management":

    "ONLINE",


    "GRC":

    "ONLINE",


    "Zero Trust":

    "ONLINE",


    "Cyber Command Center":

    "ONLINE"



    }



    def status(self):


        return {


        "platform":

        "MUTEB SOC Enterprise",


        "edition":

        "Cyber Command Center",


        "modules":

        self.modules,


        "overall":

        "OPERATIONAL",


        "timestamp":

        str(datetime.utcnow())



        }



