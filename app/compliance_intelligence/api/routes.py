

from flask import Blueprint,jsonify


from app.compliance_intelligence.frameworks.manager import FrameworkManager

from app.compliance_intelligence.controls.manager import ControlManager

from app.compliance_intelligence.dashboard.view import ComplianceDashboard



compliance_api=Blueprint(

"compliance_intelligence",

__name__,

url_prefix="/api/compliance"

)



framework=FrameworkManager()

control=ControlManager()

dashboard=ComplianceDashboard()



@compliance_api.route("/frameworks")
def frameworks():

    return jsonify(

    framework.frameworks()

    )



@compliance_api.route("/controls")
def controls():

    return jsonify(

    control.controls()

    )



@compliance_api.route("/dashboard")
def dashboard_view():

    return jsonify(

    dashboard.summary()

    )



