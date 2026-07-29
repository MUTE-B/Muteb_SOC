
from flask import Flask,request,jsonify
from flask_cors import CORS
import datetime


app = Flask(__name__)
CORS(app)


USERS = {

"admin":{
"password":"admin123",
"role":"Admin"
},

"analyst":{
"password":"analyst123",
"role":"Analyst"
}

}


alerts=[

{
"id":1,
"severity":"Critical",
"title":"Brute Force Detection",
"status":"Open"
}

]


incidents=[

{
"id":1,
"title":"Suspicious Login",
"priority":"High",
"status":"Investigating"
}

]


logs=[

{
"time":str(datetime.datetime.now()),
"event":"SOC Backend Started"
}

]



@app.route("/api/login",methods=["POST"])
def login():

    data=request.json

    user=data.get("username")
    password=data.get("password")


    if user in USERS and USERS[user]["password"]==password:

        return jsonify({

        "success":True,

        "user":{

        "username":user,
        "role":USERS[user]["role"]

        }

        })


    return jsonify({"success":False})





@app.route("/api/dashboard")
def dashboard():

    return jsonify({

    "critical_alerts":len(alerts),

    "open_incidents":len(incidents),

    "threat_score":85

    })





@app.route("/api/alerts")
def get_alerts():

    return jsonify(alerts)





@app.route("/api/incidents")
def get_incidents():

    return jsonify(incidents)





@app.route("/api/logs")
def get_logs():

    logs.append({

    "time":str(datetime.datetime.now()),

    "event":"API Request"

    })

    return jsonify(logs)





@app.route("/")
def home():

    return "MUTEB SOC BACKEND ONLINE"





if __name__=="__main__":

    app.run(
    host="0.0.0.0",
    port=8000
    )


