

import os



SETTINGS={


    "APP_NAME":

    "MUTEB SOC Enterprise",


    "VERSION":

    "12.9.0",


    "ENVIRONMENT":

    os.getenv(

        "ENVIRONMENT",

        "production"

    ),


    "SECURITY":{


        "JWT":

        True,


        "RBAC":

        True,


        "AUDIT":

        True


    }


}



def get_settings():


    return SETTINGS


# Backward compatibility
settings = SETTINGS
