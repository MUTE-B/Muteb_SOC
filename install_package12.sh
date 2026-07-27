
#!/bin/bash

echo "Installing MUTEB SOC Package 12 - Threat Hunting Engine"



mkdir -p app/threat_hunting
mkdir -p app/api



# =====================================
# Threat Hunting Rules
# =====================================


cat > app/threat_hunting/hunting_rules.json <<'JSON'

{

"process":

{

"suspicious":

[

"nc",

"netcat",

"mimikatz",

"powershell -enc",

"curl http"

]

},


"network":

{

"suspicious_ports":

[

4444,

5555,

6666

]

},


"files":

{

"suspicious":

[

"/tmp",

"/dev/shm"

]

}

}

JSON



# =====================================
# Hunting Engine
# =====================================


cat > app/threat_hunting/hunter.py <<'PY'


import json
import os



class ThreatHunter:



    def __init__(self):

        path=os.path.join(

            os.path.dirname(__file__),

            "hunting_rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def scan(self,data):


        findings=[]


        text=str(data).lower()



        for item in self.rules["process"]["suspicious"]:

            if item in text:

                findings.append({

                    "type":"PROCESS",

                    "indicator":item,

                    "severity":"HIGH"

                })



        for port in self.rules["network"]["suspicious_ports"]:

            if str(port) in text:

                findings.append({

                    "type":"NETWORK",

                    "indicator":port,

                    "severity":"MEDIUM"

                })



        for path in self.rules["files"]["suspicious"]:

            if path in text:

                findings.append({

                    "type":"FILE",

                    "indicator":path,

                    "severity":"HIGH"

                })



        return findings





hunter=ThreatHunter()

PY




# =====================================
# Threat Hunting API
# =====================================


cat > app/api/hunting.py <<'PY'


from flask import Blueprint,request,jsonify


from app.threat_hunting.hunter import hunter



hunting=Blueprint(

    "hunting",

    __name__

)



@hunting.route(

"/scan",

methods=["POST"]

)

def scan():



    data=request.json



    result=hunter.scan(

        data.get(

            "data",

            ""

        )

    )



    return jsonify({

        "status":"completed",

        "findings":result,

        "count":len(result)

    })



PY




# =====================================
# Register Blueprint
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.hunting import hunting" not in data:


    data=data.replace(

        "from app.api.investigation import investigation",

        "from app.api.investigation import investigation\nfrom app.api.hunting import hunting"

    )



if "/api/hunting" not in data:


    data=data.replace(

        "app.register_blueprint(\n    investigation,",

        "app.register_blueprint(\n    hunting,\n    url_prefix=\"/api/hunting\"\n)\n\n\napp.register_blueprint(\n    investigation,"

    )



with open(file,"w") as f:

    f.write(data)



PY




python3 -m compileall app



echo "================================"
echo "PACKAGE 12 COMPLETE"
echo "THREAT HUNTING ENGINE READY"
echo "================================"


