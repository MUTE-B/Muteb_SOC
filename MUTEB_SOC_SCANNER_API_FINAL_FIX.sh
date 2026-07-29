#!/bin/bash

set -e


cd backend


mkdir -p api



cat > api/scanner_api.py <<'PY'

from flask import Blueprint,request,jsonify

from modules.web_security_scanner import scan_domain

from modules.report_generator import create_report


scanner_bp = Blueprint(
"scanner_bp",
__name__
)



@scanner_bp.route(
"/api/scanner/start",
methods=["POST"]
)

def start_scan():


    data=request.get_json()


    target=data.get(
    "target"
    )


    if not target:

        return jsonify({

        "success":False,

        "error":"Target required"

        }),400



    result=scan_domain(target)



    report=create_report(

    target,

    result

    )



    return jsonify({

    "success":True,

    "target":target,

    "result":result,

    "report":report

    })



PY




echo "% REGISTER BLUEPRINT"



python3 - <<'PY'

from pathlib import Path

p=Path("web_dashboard/app.py")


if p.exists():

    x=p.read_text()


    if "scanner_bp" not in x:

        x += """

from api.scanner_api import scanner_bp

app.register_blueprint(scanner_bp)

"""


        p.write_text(x)

else:

    print("app.py not found")

PY




echo "% RESTART BACKEND"


sudo systemctl restart muteb-backend.service



sleep 3



echo "% TEST API"


curl -X POST http://127.0.0.1:8000/api/scanner/start \
-H "Content-Type: application/json" \
-d '{"target":"example.com"}'



echo

echo "SCANNER API FIX COMPLETE"


