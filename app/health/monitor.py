

from datetime import datetime



def health_status():


    return {


        "platform":

        "MUTEB SOC Enterprise",


        "status":

        "HEALTHY",


        "services":{


            "API":

            "ONLINE",


            "Database":

            "ONLINE",


            "Detection":

            "ONLINE",


            "Threat Intel":

            "ONLINE",


            "SOAR":

            "ONLINE"

        },


        "checked":

        str(datetime.utcnow())

    }

