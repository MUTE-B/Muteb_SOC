
#!/bin/bash


echo "Installing MUTEB SOC Package 16 - Incident Response Engine"



mkdir -p app/response
mkdir -p app/playbooks
mkdir -p app/api



# =====================================
# Playbooks Database
# =====================================


cat > app/playbooks/playbooks.json <<'JSON'

{

"bruteforce":

{

"name":"SSH Brute Force Response",

"actions":

[

"Block Source IP",

"Reset Credentials",

"Collect Authentication Logs"

]

},


"malware":

{

"name":"Malware Containment Response",

"actions":

[

"Isolate Host",

"Collect Malware Hash",

"Start Investigation"

]

},


"phishing":

{

"name":"Phishing Response",

"actions":

[

"Disable User",

"Collect Email Evidence",

"Search IOC"

]

},


"ransomware":

{

"name":"Ransomware Response",

"actions":

[

"Network Isolation",

"Stop Encryption Process",

"Backup Recovery"

]

}

}

JSON




# =====================================
# Response Engine
# =====================================


cat > app/response/engine.py <<'PY'


import json
import os



class ResponseEngine:



    def __init__(self):


        path=os.path.join(

            os.path.dirname(
                os.path.dirname(__file__)
            ),

            "playbooks/playbooks.json"

        )


        with open(path) as f:

            self.playbooks=json.load(f)




    def execute(self,incident):


        text=str(
            incident
        ).lower()



        selected=""



        if "ssh" in text or "brute" in text:

            selected="bruteforce"


        elif "malware" in text:

            selected="malware"


        elif "phishing" in text:

            selected="phishing"


        elif "ransom" in text:

            selected="ransomware"



        if selected:


            return {

                "status":
                "executed",

                "playbook":
                self.playbooks[selected]

            }



        return {


            "status":
            "no playbook",


            "playbook":
            None

        }





response_engine=ResponseEngine()

PY





# =====================================
# Response API
# =====================================


cat > app/api/response.py <<'PY'


from flask import Blueprint,request,jsonify


from app.response.engine import response_engine



response=Blueprint(

    "response",

    __name__

)



@response.route(

"/execute",

methods=["POST"]

)

def execute():


    data=request.json



    result=response_engine.execute(

        data.get(

            "incident",

            ""

        )

    )


    return jsonify(result)



PY





# =====================================
# Register Blueprint
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.response import response" not in data:


    data=data.replace(

        "from app.api.siem import siem",

        "from app.api.siem import siem\nfrom app.api.response import response"

    )



if 'url_prefix="/api/response"' not in data:


    data=data.replace(

        "app.register_blueprint(\n    siem,",

        "app.register_blueprint(\n    response,\n    url_prefix=\"/api/response\"\n)\n\n\napp.register_blueprint(\n    siem,"

    )



with open(file,"w") as f:

    f.write(data)



PY





python3 -m compileall app



echo "================================"
echo "PACKAGE 16 COMPLETE"
echo "INCIDENT RESPONSE ENGINE READY"
echo "================================"



