

from flask import Blueprint,jsonify


from app.platform.dashboard.main import UnifiedDashboard

from app.platform.auth.security import Authentication

from app.platform.reports.engine import ReportingEngine

from app.platform.executive.view import ExecutiveView

from app.platform.analyst.workspace import AnalystWorkspace

from app.platform.gateway.api import APIGateway



platform_api=Blueprint(

"platform",

__name__,

url_prefix="/api/platform"

)



dashboard=UnifiedDashboard()

auth=Authentication()

reports=ReportingEngine()

executive=ExecutiveView()

analyst=AnalystWorkspace()

gateway=APIGateway()



@platform_api.route("/dashboard")
def dashboard_view():

    return jsonify(dashboard.overview())


@platform_api.route("/reports")
def reports_view():

    return jsonify(reports.generate())


@platform_api.route("/executive")
def executive_view():

    return jsonify(executive.summary())


@platform_api.route("/analyst")
def analyst_view():

    return jsonify(analyst.tools())


@platform_api.route("/gateway")
def gateway_view():

    return jsonify(gateway.status())


