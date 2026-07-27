
from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.services.ioc_engine import ioc_scanner


from app.services.sigma_engine import sigma_engine


from app.services.alert_engine import alert_engine



events=Blueprint(
    "events",
    __name__
)



@events.route(
    "/",
    methods=["POST"]
)
@permission_required("detection")
def analyze_event():


    data=request.json


    log=data.get(
        "event",
        ""
    )



    iocs=ioc_scanner.scan(
        log
    )


    rules=sigma_engine.detect(
        log
    )



    if iocs or rules:


        alert_engine.create_alert(

            title="Security Detection Triggered",

            severity="HIGH",

            source="Detection Engine"

        )



    return jsonify({

        "status":"completed",

        "ioc_matches":iocs,

        "sigma_matches":rules

    })

