
from flask import Blueprint, request, jsonify

from app.database.database import db
from app.models.user import User


auth = Blueprint(
    "auth",
    __name__
)


@auth.route(
    "/register",
    methods=["POST"]
)
def register():

    data = request.json

    user = User(
        username=data["username"],
        email=data["email"],
        role=data.get(
            "role",
            "Viewer"
        )
    )


    user.set_password(
        data["password"]
    )


    db.session.add(
        user
    )

    db.session.commit()


    return jsonify({

        "message":
        "User created successfully"

    })



@auth.route(
    "/login",
    methods=["POST"]
)
def login():

    data = request.json


    user = User.query.filter_by(
        username=data["username"]
    ).first()


    if user and user.check_password(
        data["password"]
    ):

        return jsonify({

            "status":
            "success",

            "role":
            user.role

        })


    return jsonify({

        "status":
        "failed"

    }),401
