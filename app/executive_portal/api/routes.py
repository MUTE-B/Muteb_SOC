

from flask import Blueprint,jsonify



from app.executive_portal.core.risk_report import ExecutiveRiskPortal



executive_api=Blueprint(

"executive_portal",

__name__,

url_prefix="/api/executive"

)



portal=ExecutiveRiskPortal()



@executive_api.route("/summary")
def summary():


    return jsonify(

    portal.summary()

    )




@executive_api.route("/maturity")
def maturity():


    return jsonify(

    portal.maturity()

    )



