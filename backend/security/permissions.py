

from security.roles import has_permission



def check_access(
user,
action
):


    return has_permission(
    user,
    action
    )


