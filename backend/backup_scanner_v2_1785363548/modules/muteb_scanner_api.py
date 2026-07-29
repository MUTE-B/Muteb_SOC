
from flask import Blueprint,request,jsonify

from modules.web_security_scanner import scan_domain


scanner_api=Blueprint(
"scanner_api",
__name__
)



@scanner_api.route(
"/api/scanner/start",
methods=["POST"]
)

def start_scan():

    data=request.get_json() or {}

    target=data.get("target")


    if not target:

        return jsonify({

            "success":False,

            "error":"Target required"

        }),400



    result=scan_domain(target)



    return jsonify({

        "success":True,

        "target":target,

        "result":result

    })




@scanner_api.route(
"/api/scanner/status",
methods=["GET"]
)

def status():

    return jsonify({

        "service":"MUTEB Web Security Scanner",

        "status":"ONLINE"

    })

