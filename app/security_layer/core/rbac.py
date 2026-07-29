

class RoleManager:



    roles={


    "ADMIN":[

        "ALL"

    ],


    "SOC_ANALYST":[

        "VIEW_ALERTS",

        "MANAGE_CASES",

        "VIEW_ASSETS"

    ],


    "EXECUTIVE":[

        "VIEW_REPORTS",

        "VIEW_RISK"

    ]


    }



    def permissions(self,role):


        return self.roles.get(

        role,

        []

        )



