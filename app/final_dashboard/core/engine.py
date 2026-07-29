

from datetime import datetime



class CommandCenter:



    def overview(self):


        return {


        "platform":

        "MUTEB SOC Enterprise",


        "edition":

        "Cyber Command Center",


        "status":

        "ONLINE",


        "time":

        str(datetime.utcnow()),


        "systems":{


        "SOC":

        "ACTIVE",


        "SIEM":

        "ACTIVE",


        "SOAR":

        "ACTIVE",


        "AI":

        "ACTIVE",


        "Threat Intelligence":

        "ACTIVE",


        "DFIR":

        "ACTIVE"



        }



        }



