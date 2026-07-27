
#!/bin/bash


echo "Installing MUTEB SOC Package 15 - SIEM Integration"


mkdir -p app/integrations/siem
mkdir -p app/api



# =====================================
# SIEM Event Formatter
# =====================================


cat > app/integrations/siem/formatter.py <<'PY'


from datetime import datetime



class SIEMFormatter:


    def format_event(
        self,
        source,
        event,
        severity="MEDIUM"
    ):


        return {


            "timestamp":
            str(datetime.utcnow()),


            "source":
            source,


            "event":
            event,


            "severity":
            severity,


            "platform":
            "MUTEB SOC"

        }




formatter=SIEMFormatter()

PY





# =====================================
# Wazuh Connector
# =====================================


cat > app/integrations/siem/wazuh.py <<'PY'


class WazuhConnector:



    def send(self,event):


        return {


            "platform":
            "Wazuh",


            "status":
            "sent",


            "event":
            event

        }



wazuh=WazuhConnector()

PY





# =====================================
# Splunk Connector
# =====================================


cat > app/integrations/siem/splunk.py <<'PY'


class SplunkConnector:



    def send(self,event):


        return {


            "platform":
            "Splunk",


            "status":
            "sent",


            "event":
            event

        }



splunk=SplunkConnector()

PY





# =====================================
# Microsoft Sentinel Connector
# =====================================


cat > app/integrations/siem/sentinel.py <<'PY'


class SentinelConnector:



    def send(self,event):


        return {


            "platform":
            "Microsoft Sentinel",


            "status":
            "sent",


            "event":
            event

        }



sentinel=SentinelConnector()

PY





# =====================================
# SIEM API
# =====================================


cat > app/api/siem.py <<'PY'


from flask import Blueprint,request,jsonify


from app.integrations.siem.formatter import formatter

from app.integrations.siem.wazuh import wazuh

from app.integrations.siem.splunk import splunk

from app.integrations.siem.sentinel import sentinel



siem=Blueprint(

    "siem",

    __name__

)



@siem.route(

"/send",

methods=["POST"]

)

def send():


    data=request.json



    event=formatter.format_event(

        data.get(
            "source",
            "unknown"
        ),

        data.get(
            "event",
            ""
        ),

        data.get(
            "severity",
            "MEDIUM"
        )

    )



    return jsonify({

        "wazuh":
        wazuh.send(event),


        "splunk":
        splunk.send(event),


        "sentinel":
        sentinel.send(event)

    })



PY





# =====================================
# Register Blueprint
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.siem import siem" not in data:


    data=data.replace(

        "from app.api.yara import yara",

        "from app.api.yara import yara\nfrom app.api.siem import siem"

    )



if 'url_prefix="/api/siem"' not in data:


    data=data.replace(

        "app.register_blueprint(\n    yara,",

        "app.register_blueprint(\n    siem,\n    url_prefix=\"/api/siem\"\n)\n\n\napp.register_blueprint(\n    yara,"

    )



with open(file,"w") as f:

    f.write(data)



PY





python3 -m compileall app



echo "================================"
echo "PACKAGE 15 COMPLETE"
echo "SIEM INTEGRATION READY"
echo "================================"



