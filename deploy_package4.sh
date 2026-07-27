
#!/bin/bash

echo "================================="
echo " MUTEB SOC PACKAGE 4 DEPLOYMENT "
echo " Detection Pipeline Engine"
echo "================================="


mkdir -p app/services
mkdir -p app/api


cat > app/services/ioc_engine.py <<'PY'
class IOCScanner:


    def scan(self,text):

        indicators=[]


        suspicious=[

            "malware",
            "powershell",
            "cmd.exe",
            "reverse_shell",
            "ransomware",
            "bruteforce"

        ]


        for item in suspicious:

            if item.lower() in text.lower():

                indicators.append(item)


        return indicators



ioc_scanner = IOCScanner()
PY



cat > app/services/sigma_engine.py <<'PY'

class SigmaEngine:


    def detect(self,event):

        rules=[]


        if "failed login" in event.lower():

            rules.append(
                "SSH_BRUTE_FORCE"
            )


        if "powershell" in event.lower():

            rules.append(
                "SUSPICIOUS_POWERSHELL"
            )


        return rules



sigma_engine = SigmaEngine()

PY



cat > app/services/alert_engine.py <<'PY'

from app.database.database import db

from app.models.alert import Alert



class AlertEngine:


    def create_alert(
        self,
        title,
        severity,
        source
    ):


        alert=Alert(

            title=title,

            severity=severity,

            source=source

        )


        db.session.add(alert)

        db.session.commit()


        return alert



alert_engine=AlertEngine()

PY



cat > app/services/risk_engine.py <<'PY'

class RiskEngine:


    def score(self,severity):


        levels={

        "LOW":25,

        "MEDIUM":50,

        "HIGH":75,

        "CRITICAL":100

        }


        return levels.get(
            severity.upper(),
            0
        )



risk_engine=RiskEngine()

PY



cat > app/api/events.py <<'PY'

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

PY



python3 - <<'PY'

path="app/core/application.py"


with open(path,"r") as f:
    data=f.read()


if "from app.api.events import events" not in data:

    data=data.replace(

        "from app.api.incidents import incident",

        "from app.api.incidents import incident\nfrom app.api.events import events"

    )


if 'url_prefix="/api/events"' not in data:

    data=data.replace(

        "app.register_blueprint(\n        incident,",

        "app.register_blueprint(\n        events,\n        url_prefix=\"/api/events\"\n    )\n\n\n    app.register_blueprint(\n        incident,"

    )


with open(path,"w") as f:
    f.write(data)

PY



echo "Checking Python Syntax..."

python3 -m compileall app



echo "================================="
echo " PACKAGE 4 INSTALLED SUCCESSFULLY"
echo "================================="

