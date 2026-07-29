
from flask import Blueprint,request,jsonify

from datetime import datetime
import json
import os



scanner_bp = Blueprint(
    "scanner",
    __name__
)



REPORT_DIR="reports"

EVENT_FILE="logs/scanner_events.json"


os.makedirs(REPORT_DIR,exist_ok=True)

os.makedirs("logs",exist_ok=True)



def save_event(data):

    events=[]

    if os.path.exists(EVENT_FILE):

        try:

            with open(EVENT_FILE) as f:

                events=json.load(f)

        except:

            events=[]



    events.append(data)


    with open(EVENT_FILE,"w") as f:

        json.dump(
            events,
            f,
            indent=4
        )



def run_real_scan(target):

    try:

        from modules.web_security_scanner import scan_domain

        result=scan_domain(target)


    except Exception as e:

        result={

            "error":str(e),

            "target":target

        }



    return result




@scanner_bp.route(
"/api/scanner/start",
methods=["POST"]
)
def scanner_start():


    data=request.get_json() or {}


    target=data.get("target")



    if not target:

        return jsonify({

            "success":False,

            "error":"Target required"

        }),400



    result=run_real_scan(target)



    event={

        "time":str(datetime.utcnow()),

        "target":target,

        "result":result,

        "severity":result.get(
            "risk",
            "UNKNOWN"
        )

    }



    save_event(event)



    # PDF

    try:

        from modules.report_generator import create_report

        create_report(
            target,
            result
        )

    except Exception:

        pass



    return jsonify({

        "success":True,

        "scanner":
        "MUTEB Web Security Scanner Engine",

        "target":target,

        "result":result

    })





@scanner_bp.route(
"/api/scanner/status",
methods=["GET"]
)
def scanner_status():

    return jsonify({

        "scanner":
        "MUTEB Web Security Scanner Engine",

        "status":"ONLINE"

    })





@scanner_bp.route(
"/api/scanner/history",
methods=["GET"]
)
def scanner_history():


    if not os.path.exists(EVENT_FILE):

        return jsonify([])



    with open(EVENT_FILE) as f:

        return jsonify(json.load(f))


