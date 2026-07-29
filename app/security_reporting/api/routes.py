

from flask import Blueprint,jsonify


from app.security_reporting.reports.engine import ReportEngine

from app.security_reporting.kpi.metrics import KPIEngine

from app.security_reporting.executive.dashboard import ExecutiveDashboard



reporting_api=Blueprint(

"security_reporting",

__name__,

url_prefix="/api/reporting"

)



report=ReportEngine()

kpi=KPIEngine()

executive=ExecutiveDashboard()



@reporting_api.route("/generate")
def generate():

    return jsonify(

    report.generate()

    )



@reporting_api.route("/kpi")
def kpi_report():

    return jsonify(

    kpi.metrics()

    )



@reporting_api.route("/executive")
def executive_report():

    return jsonify(

    executive.summary()

    )



