

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.integrations.cloud.splunk import splunk

from app.integrations.cloud.sentinel import sentinel



siem=Blueprint(

    "siem",

    __name__

)



@siem.route(
"/send",
methods=["POST"]
)

@jwt_required()

def send():


    data=request.json or {}


    target=data.get(
        "target",
        ""
    )


    event=data.get(
        "event",
        {}
    )


    if target=="splunk":

        result=splunk.send_event(event)


    elif target=="sentinel":

        result=sentinel.send_event(event)


    else:

        result={

            "status":"UNKNOWN TARGET"

        }



    return jsonify(result)

