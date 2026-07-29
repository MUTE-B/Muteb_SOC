#!/bin/bash


echo "======================================"
echo " MUTEB SECURITY INTELLIGENCE ENGINE"
echo "======================================"


mkdir -p app/intelligence_engine/assets
mkdir -p app/intelligence_engine/risk
mkdir -p app/intelligence_engine/reports
mkdir -p app/intelligence_engine/api



####################################
# ASSET INTELLIGENCE
####################################


cat > app/intelligence_engine/assets/asset_manager.py <<'PY'


from datetime import datetime



class AssetManager:



    assets=[]



    def register(self,target,organization):


        asset={


        "id":

        len(self.assets)+1,


        "target":

        target,


        "organization":

        organization,


        "status":

        "AUTHORIZED",


        "created":

        str(datetime.utcnow())


        }


        self.assets.append(asset)


        return asset




    def list(self):


        return self.assets



PY





####################################
# RISK ENGINE
####################################


cat > app/intelligence_engine/risk/risk_engine.py <<'PY'


class RiskEngine:



    def calculate(self,findings):


        score=100



        for item in findings:



            if item=="critical":

                score-=40



            elif item=="high":

                score-=25



            elif item=="medium":

                score-=15



            elif item=="low":

                score-=5




        if score < 40:

            level="CRITICAL"


        elif score <70:

            level="HIGH"


        elif score <90:

            level="MEDIUM"


        else:

            level="LOW"



        return {


        "security_score":

        max(score,0),


        "risk_level":

        level



        }



PY





####################################
# SECURITY REPORT ENGINE
####################################


cat > app/intelligence_engine/reports/report_engine.py <<'PY'


from datetime import datetime



class SecurityReport:



    def generate(self,asset,risk):


        return {


        "asset":

        asset,


        "assessment":

        "AUTHORIZED SECURITY ASSESSMENT",


        "score":

        risk["security_score"],


        "risk":

        risk["risk_level"],


        "generated":

        str(datetime.utcnow())


        }



PY





####################################
# INTELLIGENCE API
####################################


cat > app/intelligence_engine/api/routes.py <<'PY'


from flask import Blueprint,jsonify,request


from app.intelligence_engine.assets.asset_manager import AssetManager

from app.intelligence_engine.risk.risk_engine import RiskEngine

from app.intelligence_engine.reports.report_engine import SecurityReport



intel_api=Blueprint(

"intelligence",

__name__,

url_prefix="/api/intelligence"

)



assets=AssetManager()

risk_engine=RiskEngine()

report=SecurityReport()



@intel_api.route("/asset",methods=["POST"])
def asset():


    data=request.json or {}


    return jsonify(

    assets.register(

    data.get("target"),

    data.get("organization")

    )

    )




@intel_api.route("/assets")
def asset_list():


    return jsonify(

    assets.list()

    )




@intel_api.route("/assessment",methods=["POST"])
def assessment():


    data=request.json or {}


    findings=data.get(

    "findings",

    []

    )



    risk=risk_engine.calculate(findings)



    return jsonify(

    report.generate(

    data.get("target"),

    risk

    )

    )



PY





####################################
# REGISTER
####################################


cat > app/intelligence_engine/register.py <<'PY'


def register_intelligence(app):


    from app.intelligence_engine.api.routes import intel_api


    app.register_blueprint(

    intel_api

    )


    print(

    "✓ SECURITY INTELLIGENCE ENGINE ENABLED"

    )



PY




echo ""

echo "======================================"

echo " CODE 120-A COMPLETE"

echo "======================================"


