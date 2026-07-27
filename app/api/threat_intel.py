

from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.threat_intel.ioc_engine import ioc_engine




threat_intel=Blueprint(

    "threat_intel",

    __name__

)




@threat_intel.route(

"/lookup",

methods=["POST"]

)


@permission_required("detection")

def lookup():


    data=request.json


    result=ioc_engine.search(

        data["value"]

    )


    return jsonify(result)



