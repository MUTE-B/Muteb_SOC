

from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.threat_intel.ioc_engine import ioc_engine


from app.services.mitre_engine import mitre_engine


from app.services.threat_score import threat_score



threat=Blueprint(

    "threat",

    __name__

)



@threat.route(
"/analyze",
methods=["POST"]
)

@permission_required("detection")

def analyze():


    data=request.json


    event=data.get(
        "event",
        ""
    )


    ip=data.get(
        "ip"
    )


    intel={}



    if ip:

        intel=ioc_engine.check_ip(
            ip
        )



    mitre=mitre_engine.map_event(
        event
    )



    score=threat_score.calculate(

        intel.get(
            "score",
            0
        ),

        len(mitre)

    )



    return jsonify({

        "threat_score":score,

        "ioc":intel,

        "mitre":mitre

    })

