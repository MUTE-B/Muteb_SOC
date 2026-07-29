

from flask import Blueprint,jsonify


from app.cloud_security.posture.cspm import CloudPosture

from app.cloud_security.workload.protection import CloudWorkloadProtection

from app.cloud_security.risk.analyzer import CloudRiskAnalyzer



cloud_api=Blueprint(

"cloud_security",

__name__,

url_prefix="/api/cloud-security"

)



posture=CloudPosture()

workload=CloudWorkloadProtection()

risk=CloudRiskAnalyzer()



@cloud_api.route("/posture")
def posture_view():

    return jsonify(

    posture.analyze()

    )



@cloud_api.route("/workload")
def workload_view():

    return jsonify(

    workload.monitor()

    )



@cloud_api.route("/risk")
def risk_view():

    return jsonify(

    risk.calculate()

    )



