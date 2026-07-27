

ROLES = {


    "ADMIN":[

        "manage_users",

        "view_alerts",

        "manage_incidents",

        "system_config"

    ],



    "ANALYST":[

        "view_alerts",

        "analyze_events",

        "create_incident"

    ],



    "VIEWER":[

        "view_dashboard"

    ]

}



def check_permission(role,permission):


    allowed = ROLES.get(

        role,

        []

    )


    return permission in allowed



