
from flask import Blueprint,request,jsonify

from security.roles import load_users



auth_api=Blueprint(
"auth_api",
__name__
)



@auth_api.route(
"/api/auth/login",
methods=["POST"]
)

def login():


    data=request.json or {}


    username=data.get(
    "username"
    )


    password=data.get(
    "password"
    )


    users=load_users()


    user=users.get(
        username
    )


    if user and user["password"]==password:


        return jsonify(
        {
        "success":True,
        "username":username,
        "role":user["role"]
        }
        )



    return jsonify(
    {
    "success":False,
    "error":"Invalid login"
    }
    ),401



