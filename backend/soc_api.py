
from flask import Blueprint,request,jsonify

soc=Blueprint("soc",__name__)


USERS=[
{
"username":"admin",
"password":"admin123",
"role":"admin"
},
{
"username":"analyst",
"password":"analyst123",
"role":"analyst"
}
]


ALERTS=[
{
"id":1,
"title":"Suspicious Login",
"severity":"HIGH",
"status":"OPEN"
},
{
"id":2,
"title":"Port Scan Detected",
"severity":"MEDIUM",
"status":"OPEN"
}
]


INCIDENTS=[
{
"id":1,
"name":"Unauthorized Access",
"priority":"HIGH",
"status":"Investigating"
}
]


LOGS=[
{
"time":"17:00",
"source":"Firewall",
"event":"Blocked Connection"
},
{
"time":"17:05",
"source":"Linux",
"event":"SSH Login"
}
]


@soc.route("/api/login",methods=["POST"])
def login():

    data=request.json

    for u in USERS:
        if u["username"]==data.get("username") and u["password"]==data.get("password"):
            return jsonify({
                "success":True,
                "user":u
            })

    return jsonify({
        "success":False
    }),401



@soc.route("/api/alerts")
def alerts():
    return jsonify(ALERTS)



@soc.route("/api/incidents")
def incidents():
    return jsonify(INCIDENTS)



@soc.route("/api/logs")
def logs():
    return jsonify(LOGS)



@soc.route("/api/dashboard")
def dashboard():

    return jsonify({

    "critical_alerts":
    len([x for x in ALERTS if x["severity"]=="HIGH"]),

    "open_incidents":
    len(INCIDENTS),

    "threat_score":85

    })

