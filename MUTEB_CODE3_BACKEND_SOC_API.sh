#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 3 BACKEND SOC API"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

cp app/api/frontend_api.py app/api/frontend_api.py.backup 2>/dev/null || true



echo "[2] Create SOC Dashboard API"


cat > app/api/dashboard_api.py <<'PY'

from flask import Blueprint, jsonify


dashboard_api = Blueprint(
    "dashboard_api",
    __name__
)



@dashboard_api.route(
    "/api/soc/dashboard",
    methods=["GET"]
)
def dashboard():


    return jsonify({

        "status":"success",

        "stats":{

            "critical_alerts":12,

            "open_incidents":5,

            "assets":248,

            "system":"ONLINE"

        },


        "alerts":[


            {

            "severity":"Critical",

            "source":"Firewall",

            "status":"Investigating"

            },


            {

            "severity":"High",

            "source":"Endpoint",

            "status":"Monitoring"

            },


            {

            "severity":"Medium",

            "source":"Email Gateway",

            "status":"Resolved"

            }


        ],



        "incidents":[


            {

            "id":"INC-001",

            "title":"Suspicious Login",

            "priority":"High"

            },


            {

            "id":"INC-002",

            "title":"Malware Detection",

            "priority":"Critical"

            }


        ],



        "assets":[


            {

            "name":"SOC Server",

            "status":"Online"

            },


            {

            "name":"Firewall",

            "status":"Protected"

            }


        ]



    })



PY




echo "[3] Register API"


python3 - <<'PY'

from pathlib import Path


p=Path("app/core/application.py")

text=p.read_text()



if "dashboard_api" not in text:


    text=text.replace(

        "CORS(app)",

        """
CORS(app)


    try:

        from app.api.dashboard_api import dashboard_api

        app.register_blueprint(dashboard_api)

    except Exception as e:

        print("Dashboard API warning:",e)

"""

    )


p.write_text(text)

print("API registered")


PY




echo "[4] Syntax Check"


python3 -m py_compile app/core/application.py




echo "[5] Restart Backend"



pkill -f "run.py" 2>/dev/null || true

sleep 3


nohup python3 run.py > backend.log 2>&1 &



sleep 5



echo ""
echo "======================================"
echo " TEST API"
echo "======================================"



curl http://localhost:8000/api/soc/dashboard



echo ""

echo "======================================"
echo " CODE 3 COMPLETED"
echo "======================================"

tail -20 backend.log


