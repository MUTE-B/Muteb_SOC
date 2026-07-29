#!/bin/bash


echo "======================================"
echo " MUTEB THREAT INTELLIGENCE CENTER"
echo "======================================"


mkdir -p app/threat_intelligence/api
mkdir -p app/threat_intelligence/core
mkdir -p app/threat_intelligence/models



####################################
# IOC DATABASE
####################################


cat > app/threat_intelligence/models/ioc.py <<'PY'


from datetime import datetime



class IOCManager:



    indicators=[]



    def add(

        self,

        indicator,

        indicator_type,

        severity

    ):


        item={


        "id":

        len(self.indicators)+1,


        "indicator":

        indicator,


        "type":

        indicator_type,


        "severity":

        severity,


        "status":

        "MONITORING",


        "created":

        str(datetime.utcnow())


        }



        self.indicators.append(item)


        return item




    def list(self):


        return self.indicators



PY





####################################
# THREAT ANALYSIS ENGINE
####################################


cat > app/threat_intelligence/core/analyzer.py <<'PY'


class ThreatAnalyzer:



    def analyze(self,indicator):


        severity=indicator.get(

        "severity",

        "LOW"

        )



        if severity=="CRITICAL":


            action="Immediate Investigation"



        elif severity=="HIGH":


            action="Priority Review"



        else:


            action="Continuous Monitoring"




        return {


        "indicator":

        indicator.get("indicator"),


        "risk":

        severity,


        "recommended_action":

        action



        }



PY





####################################
# KNOWLEDGE BASE
####################################


cat > app/threat_intelligence/core/knowledge.py <<'PY'


class SecurityKnowledgeBase:



    knowledge=[]



    def add(self,title,description):


        record={


        "title":

        title,


        "description":

        description



        }



        self.knowledge.append(record)


        return record




    def all(self):


        return self.knowledge



PY





####################################
# THREAT API
####################################


cat > app/threat_intelligence/api/routes.py <<'PY'


from flask import Blueprint,jsonify,request


from app.threat_intelligence.models.ioc import IOCManager

from app.threat_intelligence.core.analyzer import ThreatAnalyzer

from app.threat_intelligence.core.knowledge import SecurityKnowledgeBase



threat_api=Blueprint(

"threat_intelligence",

__name__,

url_prefix="/api/threat"

)



ioc=IOCManager()

analyzer=ThreatAnalyzer()

knowledge=SecurityKnowledgeBase()




@threat_api.route("/ioc",methods=["POST"])
def add_ioc():


    data=request.json or {}


    return jsonify(

    ioc.add(

    data.get("indicator"),

    data.get("type"),

    data.get("severity")

    )

    )




@threat_api.route("/ioc")
def list_ioc():


    return jsonify(

    ioc.list()

    )




@threat_api.route("/analyze",methods=["POST"])
def analyze():


    return jsonify(

    analyzer.analyze(

    request.json or {}

    )

    )




@threat_api.route("/knowledge",methods=["POST"])
def add_knowledge():


    data=request.json or {}


    return jsonify(

    knowledge.add(

    data.get("title"),

    data.get("description")

    )

    )




@threat_api.route("/knowledge")
def get_knowledge():


    return jsonify(

    knowledge.all()

    )



PY





####################################
# REGISTER
####################################


cat > app/threat_intelligence/register.py <<'PY'


def register_threat_intelligence(app):


    from app.threat_intelligence.api.routes import threat_api


    app.register_blueprint(

    threat_api

    )


    print(

    "✓ THREAT INTELLIGENCE CENTER ENABLED"

    )



PY





echo ""

echo "======================================"

echo " CODE 120-C COMPLETE"

echo "======================================"


