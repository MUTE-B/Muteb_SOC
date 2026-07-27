from app.auth.roles import Roles


ROLE_PERMISSIONS = {

    Roles.ADMIN: [
        "ALL"
    ],

    Roles.SOC_MANAGER: [
        "dashboard",
        "alerts",
        "incidents",
        "detection",
        "reports"
    ],

    Roles.SOC_ANALYST: [
        "alerts",
        "incidents",
        "detection"
    ],

    Roles.AUDITOR: [
        "reports"
    ],

    Roles.VIEWER: [
        "dashboard_read"
    ]

}



def has_permission(role, permission):

    permissions = ROLE_PERMISSIONS.get(
        role,
        []
    )


    if "ALL" in permissions:
        return True


    return permission in permissions
