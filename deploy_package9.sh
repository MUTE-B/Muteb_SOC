
#!/bin/bash


echo "====================================="
echo " MUTEB SOC PACKAGE 9"
echo " AUTOMATED DETECTION PIPELINE"
echo "====================================="



mkdir -p app/detection



# ==============================
# Risk Engine
# ==============================


cat > app/detection/risk_engine.py <<'PY'


class RiskEngine:


    def calculate(
        self,
        event
    ):


        score = 0



        text = event.lower()



        if "failed" in text:

            score += 40



        if "invalid" in text:

            score += 30



        if "root" in text:

            score += 20



        if "authentication failure" in text:

            score += 40



        if score >= 70:

            severity="CRITICAL"


        elif score >=40:

            severity="HIGH"


        elif score >=20:

            severity="MEDIUM"


        else:

            severity="LOW"



        return {

            "score":score,

            "severity":severity

        }




risk_engine=RiskEngine()

PY





# ==============================
# Detection Pipeline
# ==============================


cat > app/detection/pipeline.py <<'PY'


from app.detection.risk_engine import risk_engine

from app.models.alert import Alert

from app.models.incident import Incident

from app.database.database import db



class DetectionPipeline:



    def analyze(
        self,
        event
    ):



        result=risk_engine.calculate(

            event

        )



        if result["score"] >= 40:



            alert=Alert(

                title="Suspicious Security Event",

                source="Detection Engine",

                severity=result["severity"],

                status="NEW"

            )


            db.session.add(alert)



            incident=Incident(

                title="Security Incident Generated",

                severity=result["severity"],

                source="Detection Engine",

                description=event

            )


            db.session.add(incident)



            db.session.commit()



            return {


                "detected":True,

                "severity":result["severity"],

                "score":result["score"]


            }



        return {


            "detected":False,

            "score":result["score"]


        }




pipeline=DetectionPipeline()

PY






# ==============================
# Detection API
# ==============================


cat > app/api/detection_pipeline.py <<'PY'


from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.detection.pipeline import pipeline



detection_pipeline=Blueprint(

    "detection_pipeline",

    __name__

)




@detection_pipeline.route(

"/analyze",

methods=["POST"]

)


@permission_required("detection")

def analyze():


    data=request.json


    result=pipeline.analyze(

        data["event"]

    )


    return jsonify(result)



PY






# ==============================
# Register API
# ==============================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:

    data=f.read()



if "from app.api.detection_pipeline import detection_pipeline" not in data:


    data=data.replace(

        "from app.api.collector import collector",

        "from app.api.collector import collector\nfrom app.api.detection_pipeline import detection_pipeline"

    )



if 'url_prefix="/api/pipeline"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        collector,",

        "app.register_blueprint(\n        detection_pipeline,\n        url_prefix=\"/api/pipeline\"\n    )\n\n\n    app.register_blueprint(\n        collector,"

    )


with open(path,"w") as f:

    f.write(data)



PY




python3 -m compileall app


echo "====================================="
echo " PACKAGE 9 INSTALLED"
echo " DETECTION PIPELINE READY"
echo "====================================="


