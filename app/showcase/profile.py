

from datetime import datetime



PROFILE={


    "product":

    "MUTEB SOC Enterprise",


    "edition":

    "SHOWCASE ENTERPRISE EDITION",


    "version":

    "11.0.0",


    "category":

    "Security Operations Center Platform",


    "architecture":

    {


        "backend":

        "Python Flask",


        "security":

        [

            "JWT",

            "RBAC",

            "Audit Logging",

            "Security Headers"

        ],


        "operations":

        [

            "Detection",

            "Threat Intelligence",

            "Incident Response",

            "SOAR"

        ]

    },


    "status":

    "ENTERPRISE READY",


    "released":

    str(datetime.utcnow())

}



def get_profile():


    return PROFILE

