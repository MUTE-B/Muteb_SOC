
#!/bin/bash


echo "===================================="
echo " MUTEB SOC PACKAGE 7 DEPLOYMENT"
echo " Enterprise Dashboard Engine"
echo "===================================="


mkdir -p app/dashboard
mkdir -p app/api



# ===============================
# Dashboard Metrics Service
# ===============================


cat > app/dashboard/metrics.py <<'PY'


from app.models.alert import Alert
from app.models.incident import Incident
from app.models.security_event import SecurityEvent



class DashboardMetrics:



    def summary(self):


        return {


            "alerts":

            Alert.query.count(),


            "incidents":

            Incident.query.count(),


            "security_events":

            SecurityEvent.query.count(),


            "critical_alerts":

            Alert.query.filter_by(
                severity="CRITICAL"
            ).count(),


            "high_alerts":

            Alert.query.filter_by(
                severity="HIGH"
            ).count()



        }




    def health(self):


        return {


            "platform":

            "MUTEB SOC Enterprise",


            "status":

            "ONLINE",


            "engine":

            "ACTIVE"


        }



metrics=DashboardMetrics()

PY



# ===============================
# Dashboard API
# ===============================


cat > app/api/dashboard_enterprise.py <<'PY'


from flask import Blueprint,jsonify


from app.auth.decorators import permission_required


from app.dashboard.metrics import metrics



dashboard_enterprise=Blueprint(

    "dashboard_enterprise",

    __name__

)



@dashboard_enterprise.route(
"/summary",
methods=["GET"]
)

@permission_required("dashboard")

def summary():


    return jsonify(

        metrics.summary()

    )




@dashboard_enterprise.route(
"/health",
methods=["GET"]
)

def health():


    return jsonify(

        metrics.health()

    )

PY




# ===============================
# Register API
# ===============================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:

    data=f.read()



if "from app.api.dashboard_enterprise import dashboard_enterprise" not in data:


    data=data.replace(

        "from app.api.dashboard_statistics import dashboard_statistics",

        "from app.api.dashboard_statistics import dashboard_statistics\nfrom app.api.dashboard_enterprise import dashboard_enterprise"

    )



if 'url_prefix="/api/dashboard/enterprise"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        dashboard_statistics,",

        "app.register_blueprint(\n        dashboard_enterprise,\n        url_prefix=\"/api/dashboard/enterprise\"\n    )\n\n\n    app.register_blueprint(\n        dashboard_statistics,"

    )



with open(path,"w") as f:

    f.write(data)


PY




echo "Running validation..."

python3 -m compileall app



echo "===================================="
echo " PACKAGE 7 INSTALLED"
echo " Dashboard Engine ONLINE"
echo "===================================="


