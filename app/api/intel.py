

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.intel.reputation import check_reputation

from app.intel.feeds import (

add_feed,

get_feeds

)



intel=Blueprint(

    "intel",

    __name__

)



@intel.route(

"/reputation",

methods=["POST"]

)

@jwt_required()

def reputation():


    data=request.json or {}


    return jsonify(

        check_reputation(

            data.get("value")

        )

    )




@intel.route(

"/feed",

methods=["POST"]

)

@jwt_required()

def create_feed():


    return jsonify(

        add_feed(

            request.json or {}

        )

    )




@intel.route(

"/feed",

methods=["GET"]

)

@jwt_required()

def feeds():


    return jsonify(

        get_feeds()

    )

