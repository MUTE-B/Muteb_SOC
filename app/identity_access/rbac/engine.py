

class RBACEngine:



    roles={


    "SOC_ADMIN":[


    "ALL_ACCESS"


    ],


    "SOC_ANALYST":[


    "READ_ALERTS",

    "INVESTIGATE_EVENTS",

    "CREATE_REPORTS"


    ],


    "AUDITOR":[


    "VIEW_LOGS"


    ]


    }



    def get_roles(self):


        return {


        "roles":

        self.roles,


        "control":

        "ENABLED"


        }



