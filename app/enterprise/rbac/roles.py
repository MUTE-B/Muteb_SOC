

class RoleManager:



    roles={


    "SUPER_ADMIN":[

        "all"

    ],


    "SECURITY_MANAGER":[

        "view_reports",

        "manage_risk",

        "approve_assessment"

    ],



    "SOC_ANALYST":[

        "view_alerts",

        "investigate",

        "create_incident"

    ],



    "AUDITOR":[

        "view_audit",

        "view_reports"

    ],



    "VIEWER":[

        "view_dashboard"

    ]



    }



    def permissions(self,role):


        return self.roles.get(

        role,

        []

        )



