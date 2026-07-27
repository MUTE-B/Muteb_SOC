
#!/bin/bash

echo "Installing MUTEB SOC Package 11"



mkdir -p app/mitre
mkdir -p app/investigation
mkdir -p app/api



cat > app/mitre/techniques.json <<'JSON'
{
    "ssh_failed_login":
    {
        "id":"T1110",
        "name":"Brute Force",
        "tactic":"Credential Access"
    },

    "root_login":
    {
        "id":"T1078",
        "name":"Valid Accounts",
        "tactic":"Defense Evasion"
    },

    "command_execution":
    {
        "id":"T1059",
        "name":"Command and Scripting Interpreter",
        "tactic":"Execution"
    }
}
JSON



cat > app/mitre/mapper.py <<'PY'
import json
import os


class MitreMapper:


    def __init__(self):

        file=os.path.join(
            os.path.dirname(__file__),
            "techniques.json"
        )

        with open(file) as f:
            self.techniques=json.load(f)



    def analyze(self,event):

        event=event.lower()


        if "ssh" in event and "fail" in event:

            return self.techniques["ssh_failed_login"]


        if "root" in event:

            return self.techniques["root_login"]


        if "shell" in event:

            return self.techniques["command_execution"]



        return {
            "id":"UNKNOWN",
            "name":"Unknown",
            "tactic":"Unknown"
        }



mitre_mapper=MitreMapper()
PY



cat > app/investigation/case_manager.py <<'PY'

from datetime import datetime


class CaseManager:


    def create(self,event,technique):

        return {

            "case_id":
            "CASE-"+datetime.now().strftime("%Y%m%d%H%M%S"),


            "event":
            event,


            "technique":
            technique,


            "status":
            "OPEN"

        }



case_manager=CaseManager()

PY



cat > app/api/investigation.py <<'PY'

from flask import Blueprint,request,jsonify

from app.mitre.mapper import mitre_mapper

from app.investigation.case_manager import case_manager



investigation=Blueprint(
    "investigation",
    __name__
)



@investigation.route(
    "/open",
    methods=["POST"]
)

def open_case():

    data=request.json

    event=data.get(
        "event",
        ""
    )


    technique=mitre_mapper.analyze(
        event
    )


    case=case_manager.create(
        event,
        technique
    )


    return jsonify(case)

PY



python3 - <<'PY'

file="app/core/application.py"

with open(file) as f:
    data=f.read()


if "from app.api.investigation import investigation" not in data:

    data=data.replace(
        "from app.api.threat import threat",
        "from app.api.threat import threat\nfrom app.api.investigation import investigation"
    )


if "api/investigation" not in data:

    marker="def create_app():"

    data=data.replace(
        marker,
        """
app.register_blueprint(
    investigation,
    url_prefix="/api/investigation"
)

""" + marker
    )


with open(file,"w") as f:
    f.write(data)

PY



python3 -m compileall app


echo "PACKAGE 11 COMPLETE"

