
#!/bin/bash


echo "Installing MUTEB SOC Package 18 - Enterprise Dashboard"



mkdir -p app/dashboard



# =====================================
# Enterprise Dashboard Service
# =====================================


cat > app/dashboard/enterprise.py <<'PY'


from datetime import datetime



class EnterpriseDashboard:



    def summary(self):


        return {


            "platform":
            "MUTEB SOC Enterprise",


            "status":
            "ONLINE",


            "time":
            str(datetime.utcnow()),



            "metrics":

            {


            "alerts":
            0,


            "incidents":
            0,


            "detections":
            0,


            "threats":
            0


            }



        }





    def health(self):


        return {


            "engine":
            "ACTIVE",


            "database":
            "CONNECTED",


            "api":
            "ONLINE",


            "status":
            "HEALTHY"


        }





enterprise_dashboard=EnterpriseDashboard()

PY





# =====================================
# Enterprise Dashboard API
# =====================================


cat > app/api/enterprise_dashboard.py <<'PY'


from flask import Blueprint,jsonify


from app.dashboard.enterprise import enterprise_dashboard



enterprise_dashboard_api=Blueprint(

    "enterprise_dashboard",

    __name__

)



@enterprise_dashboard_api.route(

"/enterprise/summary",

methods=["GET"]

)

def summary():


    return jsonify(

        enterprise_dashboard.summary()

    )




@enterprise_dashboard_api.route(

"/enterprise/health",

methods=["GET"]

)

def health():


    return jsonify(

        enterprise_dashboard.health()

    )



PY





# =====================================
# Register API
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.enterprise_dashboard import enterprise_dashboard_api" not in data:


    data=data.replace(

        "from app.api.reports import reports",

        "from app.api.reports import reports\nfrom app.api.enterprise_dashboard import enterprise_dashboard_api"

    )



if "enterprise_dashboard_api" not in data:


    data=data.replace(

        "app.register_blueprint(\n    reports,",

        "app.register_blueprint(\n    enterprise_dashboard_api,\n    url_prefix=\"/api/dashboard\"\n)\n\n\napp.register_blueprint(\n    reports,"

    )



with open(file,"w") as f:

    f.write(data)



PY





python3 -m compileall app



echo "================================"
echo "PACKAGE 18 COMPLETE"
echo "ENTERPRISE DASHBOARD READY"
echo "================================"


