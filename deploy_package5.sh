
#!/bin/bash


echo "===================================="
echo " MUTEB SOC PACKAGE 5 DEPLOYMENT"
echo " Incident Response Engine"
echo "===================================="



mkdir -p app/services
mkdir -p app/models
mkdir -p app/api
mkdir -p cases
mkdir -p evidence
mkdir -p reports



# ==============================
# Case Model
# ==============================

cat > app/models/case.py <<'PY'

from app.database.database import db


class Case(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )


    incident_id=db.Column(
        db.Integer
    )


    analyst=db.Column(
        db.String(100)
    )


    status=db.Column(
        db.String(50),
        default="OPEN"
    )


    priority=db.Column(
        db.String(50),
        default="HIGH"
    )


    notes=db.Column(
        db.Text
    )


    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

PY



# ==============================
# Evidence Model
# ==============================

cat > app/models/evidence.py <<'PY'

from app.database.database import db


class Evidence(db.Model):


    id=db.Column(
        db.Integer,
        primary_key=True
    )


    case_id=db.Column(
        db.Integer
    )


    filename=db.Column(
        db.String(255)
    )


    hash_value=db.Column(
        db.String(255)
    )


    description=db.Column(
        db.Text
    )


    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

PY



# ==============================
# Timeline Engine
# ==============================


cat > app/services/timeline_engine.py <<'PY'


from datetime import datetime


class TimelineEngine:


    def create_event(
        self,
        action,
        details
    ):


        return {

            "time":
            str(datetime.utcnow()),

            "action":
            action,

            "details":
            details

        }




timeline_engine=TimelineEngine()

PY



# ==============================
# Investigation Engine
# ==============================


cat > app/services/investigation_engine.py <<'PY'


from app.database.database import db

from app.models.case import Case



class InvestigationEngine:



    def open_case(
        self,
        incident_id,
        analyst
    ):


        case=Case(

            incident_id=incident_id,

            analyst=analyst

        )


        db.session.add(case)

        db.session.commit()


        return case




investigation_engine=InvestigationEngine()

PY



# ==============================
# Report Generator
# ==============================


cat > app/services/report_engine.py <<'PY'


import json



class ReportEngine:


    def generate(
        self,
        case
    ):


        report={

            "case_id":
            case.id,

            "status":
            case.status,

            "priority":
            case.priority,

            "analyst":
            case.analyst

        }


        with open(
            f"reports/case_{case.id}.json",
            "w"
        ) as file:

            json.dump(
                report,
                file,
                indent=4
            )


        return report



report_engine=ReportEngine()

PY



# ==============================
# Investigation API
# ==============================


cat > app/api/investigation.py <<'PY'


from flask import Blueprint,jsonify,request


from app.auth.decorators import permission_required


from app.services.investigation_engine import investigation_engine


from app.services.report_engine import report_engine



investigation=Blueprint(

    "investigation",

    __name__

)



@investigation.route(
    "/open",
    methods=["POST"]
)

@permission_required("incidents")

def open_case():


    data=request.json


    case=investigation_engine.open_case(

        data["incident_id"],

        data.get(
            "analyst",
            "SOC_ANALYST"
        )

    )


    report_engine.generate(
        case
    )



    return jsonify({

        "status":
        "case_created",

        "case_id":
        case.id

    })

PY



# ==============================
# Register Models + API
# ==============================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:
    data=f.read()



if "app.models.case" not in data:


    data=data.replace(

        "import app.models.audit_log",

        "import app.models.audit_log\nimport app.models.case\nimport app.models.evidence"

    )



if "from app.api.investigation import investigation" not in data:


    data=data.replace(

        "from app.api.incidents import incident",

        "from app.api.incidents import incident\nfrom app.api.investigation import investigation"

    )



if 'url_prefix="/api/investigation"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        incident,",

        "app.register_blueprint(\n        investigation,\n        url_prefix=\"/api/investigation\"\n    )\n\n\n    app.register_blueprint(\n        incident,"

    )



with open(path,"w") as f:
    f.write(data)

PY



echo "Checking..."

python3 -m compileall app


echo "===================================="
echo " PACKAGE 5 INSTALLED SUCCESSFULLY"
echo "===================================="

