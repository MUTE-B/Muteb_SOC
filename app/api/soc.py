from flask import Blueprint,jsonify
from flask_jwt_extended import jwt_required


soc = Blueprint(
    "soc",
    __name__
)



@soc.route("/api/dashboard",methods=["GET"])
@jwt_required()
def dashboard():

    return jsonify({

        "security_score":92,

        "critical_alerts":0,

        "blocked_threats":36,

        "events_today":1540,


        "alerts":[

            {
                "id":"AL-001",
                "name":"Firewall Scan",
                "level":"LOW"
            },

            {
                "id":"AL-002",
                "name":"Suspicious Login",
                "level":"MEDIUM"
            },

            {
                "id":"AL-003",
                "name":"Malware Detection",
                "level":"CRITICAL"
            }

        ],


        "system":{

            "backend":"ONLINE",

            "frontend":"ONLINE",

            "database":"READY",

            "engine":"RUNNING"

        }


    })
