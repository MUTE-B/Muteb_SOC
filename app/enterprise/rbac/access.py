

class AccessControl:



    def check(self,role,permission):


        from app.enterprise.rbac.roles import RoleManager



        allowed=RoleManager().permissions(role)



        return {


        "role":

        role,


        "permission":

        permission,


        "authorized":

        permission in allowed

        or

        "all" in allowed



        }



