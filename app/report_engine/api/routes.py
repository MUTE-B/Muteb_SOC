

from flask import Blueprint,jsonify,request


from app.report_engine.core.generator import ReportGenerator

from app.report_engine.core.evidence_export import EvidenceExporter



report_api=Blueprint(

"reports",

__name__,

url_prefix="/api/reports"

)



generator=ReportGenerator()

exporter=EvidenceExporter()



@report_api.route("/security",methods=["POST"])
def security_report():


    return jsonify(

    generator.security_report(

    request.json or {}

    )

    )





@report_api.route("/executive",methods=["POST"])
def executive_report():


    return jsonify(

    generator.executive_report(

    request.json or {}

    )

    )





@report_api.route("/evidence",methods=["POST"])
def evidence():


    return jsonify(

    {

    "package":

    exporter.export(

    request.json or {}

    )

    }

    )



