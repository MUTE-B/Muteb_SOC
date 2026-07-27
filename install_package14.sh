
#!/bin/bash

echo "Installing MUTEB SOC Package 14 - YARA Engine"


mkdir -p app/yara
mkdir -p app/api
mkdir -p yara_rules



# =====================================
# YARA Rules Database
# =====================================


cat > yara_rules/malware_rules.json <<'JSON'

[
{
"id":"YARA-001",
"name":"Suspicious Script",
"pattern":"powershell"
},

{
"id":"YARA-002",
"name":"Reverse Shell",
"pattern":"nc -e"
},

{
"id":"YARA-003",
"name":"Credential Dumping",
"pattern":"mimikatz"
}
]

JSON



# =====================================
# YARA Engine
# =====================================


cat > app/yara/engine.py <<'PY'


import json
import os
import hashlib



class YaraEngine:



    def __init__(self):

        path=os.path.join(

            os.getcwd(),

            "yara_rules/malware_rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def hash_file(self,file):


        sha256=hashlib.sha256()



        with open(file,"rb") as f:

            for chunk in iter(
                lambda:f.read(4096),
                b""
            ):

                sha256.update(chunk)



        return sha256.hexdigest()





    def scan(self,file):


        result=[]


        if not os.path.exists(file):

            return {

                "error":
                "File not found"

            }



        with open(
            file,
            "r",
            errors="ignore"
        ) as f:


            content=f.read().lower()



        for rule in self.rules:


            if rule["pattern"] in content:


                result.append({

                    "rule":
                    rule["id"],


                    "name":
                    rule["name"],


                    "severity":
                    "HIGH"

                })



        return {

            "file":
            file,


            "sha256":
            self.hash_file(file),


            "detections":
            result,


            "count":
            len(result)

        }




yara_engine=YaraEngine()

PY




# =====================================
# YARA API
# =====================================


cat > app/api/yara.py <<'PY'


from flask import Blueprint,request,jsonify


from app.yara.engine import yara_engine



yara=Blueprint(

    "yara",

    __name__

)



@yara.route(

"/scan",

methods=["POST"]

)

def scan():


    data=request.json


    result=yara_engine.scan(

        data.get(
            "file",
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



if "from app.api.yara import yara" not in data:


    data=data.replace(

        "from app.api.sigma import sigma",

        "from app.api.sigma import sigma\nfrom app.api.yara import yara"

    )



if 'url_prefix="/api/yara"' not in data:


    data=data.replace(

        "app.register_blueprint(\n    sigma,",

        "app.register_blueprint(\n    yara,\n    url_prefix=\"/api/yara\"\n)\n\n\napp.register_blueprint(\n    sigma,"

    )



with open(file,"w") as f:

    f.write(data)



PY




python3 -m compileall app



echo "================================"
echo "PACKAGE 14 COMPLETE"
echo "YARA ENGINE READY"
echo "================================"


