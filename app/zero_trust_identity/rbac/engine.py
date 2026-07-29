

class RBACEngine:



    roles={



    "ADMIN":[

    "ALL_ACCESS"

    ],


    "SOC_ANALYST":[

    "VIEW_ALERTS",

    "INVESTIGATE"

    ],


    "AUDITOR":[

    "VIEW_REPORTS"

    ]



    }



    def permissions(self,role):


        return {


        "role":

        role,


        "permissions":

        self.roles.get(

        role,

        []

        )



        }



