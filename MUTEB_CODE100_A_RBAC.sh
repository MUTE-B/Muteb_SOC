#!/bin/bash


echo "======================================"
echo " MUTEB GOVERNMENT GRADE RBAC"
echo "======================================"


mkdir -p app/enterprise/rbac
mkdir -p app/enterprise/api



####################################
# ROLE MODEL
####################################


cat > app/enterprise/rbac/roles.py <<'PY'


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



PY





####################################
# ACCESS CONTROL
####################################


cat > app/enterprise/rbac/access.py <<'PY'


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



PY





####################################
# RBAC API
####################################


cat > app/enterprise/api/routes.py <<'PY'


from flask import Blueprint,jsonify,request


from app.enterprise.rbac.access import AccessControl



rbac_api=Blueprint(

"enterprise_rbac",

__name__,

url_prefix="/api/enterprise"

)




@rbac_api.route("/permission",methods=["POST"])
def permission():


    data=request.json or {}


    return jsonify(

    AccessControl().check(

    data.get("role"),

    data.get("permission")

    )

    )



@rbac_api.route("/roles")
def roles():


    from app.enterprise.rbac.roles import RoleManager


    return jsonify(

    RoleManager.roles

    )



PY





####################################
# REGISTER
####################################


cat > app/enterprise/register.py <<'PY'


def register_enterprise(app):


    from app.enterprise.api.routes import rbac_api


    app.register_blueprint(

    rbac_api

    )


    print(

    "✓ ENTERPRISE RBAC ENABLED"

    )


PY




echo ""

echo "======================================"

echo " CODE 100-A COMPLETE"

echo "======================================"


