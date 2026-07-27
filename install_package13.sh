
#!/bin/bash

echo "Installing MUTEB SOC Package 13 - Sigma Engine"


mkdir -p app/sigma
mkdir -p app/api



# =====================================
# Sigma Rules Database
# =====================================


cat > app/sigma/rules.json <<'JSON'

[
{
"id":"SIGMA-001",
"name":"SSH Brute Force Detection",
"event":"failed ssh login",
"severity":"HIGH",
"mitre":"T1110"
},

{
"id":"SIGMA-002",
"name":"Suspicious PowerShell Execution",
"event":"powershell -enc",
"severity":"HIGH",
"mitre":"T1059"
},

{
"id":"SIGMA-003",
"name":"Reverse Shell Detection",
"event":"nc -e",
"severity":"CRITICAL",
"mitre":"T1059"
}
]

JSON



# =====================================
# Sigma Detection Engine
# =====================================


cat > app/sigma/engine.py <<'PY'


import json
import os



class SigmaEngine:


    def __init__(self):

        path=os.path.join(

            os.path.dirname(__file__),

            "rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def detect(self,event):


        matches=[]


        text=str(event).lower()



        for rule in self.rules:


            if rule["event"] in text:


                matches.append({

                    "rule_id":
                    rule["id"],


                    "name":
                    rule["name"],


                    "severity":
                    rule["severity"],


                    "mitre":
                    rule["mitre"]

                })



        return matches





sigma_engine=SigmaEngine()

PY




# =====================================
# Sigma API
# =====================================


cat > app/api/sigma.py <<'PY'


from flask import Blueprint,request,jsonify


from app.sigma.engine import sigma_engine



sigma=Blueprint(

    "sigma",

    __name__

)



@sigma.route(

"/detect",

methods=["POST"]

)

def detect():



    data=request.json



    result=sigma_engine.detect(

        data.get(

            "event",

            ""

        )

    )



    return jsonify({

        "engine":

        "SIGMA",


        "matches":

        result,


        "count":

        len(result)

    })



PY




# =====================================
# Register API
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.sigma import sigma" not in data:


    data=data.replace(

        "from app.api.hunting import hunting",

        "from app.api.hunting import hunting\nfrom app.api.sigma import sigma"

    )



if 'url_prefix="/api/sigma"' not in data:


    data=data.replace(

        "app.register_blueprint(\n    hunting,",

        "app.register_blueprint(\n    sigma,\n    url_prefix=\"/api/sigma\"\n)\n\n\napp.register_blueprint(\n    hunting,"

    )



with open(file,"w") as f:

    f.write(data)



PY




python3 -m compileall app



echo "================================"
echo "PACKAGE 13 COMPLETE"
echo "SIGMA ENGINE READY"
echo "================================"



