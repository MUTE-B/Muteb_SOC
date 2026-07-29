

class RoleEngine:



    roles={



    "SOC_ANALYST":[


    "read_alerts",

    "investigate_events",

    "create_reports"



    ],



    "SOC_MANAGER":[


    "manage_cases",

    "approve_actions",

    "view_dashboard"



    ],



    "SECURITY_ADMIN":[


    "manage_users",

    "manage_permissions",

    "system_control"



    ]



    }



    def get(self,role):


        return {


        "role":

        role,


        "permissions":

        self.roles.get(role,[])



        }



