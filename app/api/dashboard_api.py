
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



