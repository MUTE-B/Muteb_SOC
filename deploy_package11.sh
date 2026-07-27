
#!/bin/bash


echo "===================================="
echo " MUTEB SOC PACKAGE 11"
echo " MITRE ATT&CK INVESTIGATION"
echo "===================================="



mkdir -p app/mitre
mkdir -p app/investigation
mkdir -p app/api



# ================================
# MITRE Techniques Database
# ================================


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



# ================================
# MITRE Mapper
# ================================


cat > app/mitre/mapper.py <<'PY'


import json
import os



class MitreMapper:



    def __init__(self):

        path=os.path.join(

            os.path.dirname(__file__),

            "techniques.json"

        )


        with open(path) as f:

            self.techniques=json.load(f)





    def map_event(self,event):


        event=event.lower()



        if "failed ssh" in event or "ssh login failed" in event:

            return self.techniques["ssh_failed_login"]



        if "root" in event:

            return self.techniques["root_login"]



        if "command" in event or "shell" in event:

            return self.techniques["command_execution"]



        return {

            "id":"UNKNOWN",

            "name":"Unknown Technique",

            "tactic":"Unknown"

        }




mitre_mapper=MitreMapper()

PY





# ================================
# Investigation Case Manager
# ================================


cat > app/investigation/case_manager.py <<'PY'


from datetime import datetime



class CaseManager:



    def create_case(
        self,
        event,
        mitre
    ):


        case={

            "case_id":
            "CASE-"+datetime.now().strftime("%Y%m%d%H%M%S"),


            "event":
            event,


            "mitre":
            mitre,


            "status":
            "OPEN",


            "created":
            str(datetime.now())

        }


        return case




case_manager=CaseManager()

PY






# ================================
# Investigation API
# ================================


cat > app/api/investigation.py <<'PY'


from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


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


@permission_required("detection")

def open_case():


    data=request.json


    event=data["event"]


    mitre=mitre_mapper.map_event(

        event

    )


    case=case_manager.create_case(

        event,

        mitre

    )


    return jsonify(case)




PY





# ================================
# Register API
# ================================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:

    data=f.read()



if "from app.api.investigation import investigation" not in data:


    data=data.replace(

        "from app.api.threat import threat",

        "from app.api.threat import threat\nfrom app.api.investigation import investigation"

    )



if 'url_prefix="/api/investigation"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        threat,",

        "app.register_blueprint(\n        investigation,\n        url_prefix=\"/api/investigation\"\n    )\n\n\n    app.register_blueprint(\n        threat,"

    )



with open(path,"w") as f:

    f.write(data)



PY





python3 -m compileall app


echo "===================================="
echo " PACKAGE 11 INSTALLED"
echo " MITRE ENGINE ONLINE"
echo "===================================="


