

from flask import Blueprint,request,jsonify


from app.sigma.engine import sigma_engine



sigma=Blueprint(

    "sigma",

    __name__

)



@sigma.route(

"/detect",

methods=["POST"]

)

def detect():



    data=request.json



    result=sigma_engine.detect(

        data.get(

            "event",

            ""

        )

    )



    return jsonify({

        "engine":

        "SIGMA",


        "matches":

        result,


        "count":

        len(result)

    })



