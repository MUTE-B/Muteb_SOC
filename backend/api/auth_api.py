
from flask import Blueprint,request,jsonify
import jwt
import datetime


auth_api = Blueprint(
    "auth_api",
    __name__
)


USERS={

"admin":{
"username":"admin",
"password":"Muteb@Admin2026",
"role":"Admin"
},

"soc":{
"username":"soc",
"password":"soc123",
"role":"SOC Analyst"
},

"viewer":{
"username":"viewer",
"password":"viewer123",
"role":"Viewer"
}

}


SECRET="MUTEB_SOC_SECRET"


@auth_api.route(
"/api/login",
methods=["POST"]
)

def login():

    data=request.get_json() or {}

    username=data.get("username")
    password=data.get("password")


    user=USERS.get(username)


    if not user:
        return jsonify({
            "success":False,
            "error":"Invalid credentials"
        }),401


    if user["password"] != password:
        return jsonify({
            "success":False,
            "error":"Invalid credentials"
        }),401



    token=jwt.encode(

        {
        "username":username,
        "role":user["role"],
        "exp":
        datetime.datetime.utcnow()
        +
        datetime.timedelta(hours=8)

        },

        SECRET,

        algorithm="HS256"

    )


    return jsonify({

        "success":True,
        "username":username,
        "role":user["role"],
        "token":token

    })


