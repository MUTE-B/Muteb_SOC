

from flask import Blueprint,request,jsonify


from app.yara.engine import yara_engine



yara=Blueprint(

    "yara",

    __name__

)



@yara.route(

"/scan",

methods=["POST"]

)

def scan():


    data=request.json


    result=yara_engine.scan(

        data.get(
            "file",
            ""
        )

    )


    return jsonify(result)



