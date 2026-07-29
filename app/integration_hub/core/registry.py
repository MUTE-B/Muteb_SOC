

from datetime import datetime



class ModuleRegistry:



    modules = {



        "Sentinel X":
        "ONLINE",


        "AI Security Director":
        "ONLINE",


        "Threat Intelligence":
        "ONLINE",


        "SOAR":
        "ONLINE",


        "DFIR":
        "ONLINE",


        "Threat Hunting":
        "ONLINE",


        "Zero Trust":
        "ONLINE",


        "Security Analytics":
        "ONLINE",


        "Cyber Command Center":
        "ONLINE"



    }



    def status(self):


        return {


        "platform":

        "MUTEB SOC Enterprise",


        "timestamp":

        str(datetime.utcnow()),


        "modules":

        self.modules,


        "overall":

        "OPERATIONAL"



        }




