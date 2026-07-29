

from flask import Blueprint,jsonify


from app.mobile_security.devices.manager import MobileDeviceManager

from app.mobile_security.apps.analyzer import MobileAppSecurity

from app.mobile_security.risk.analyzer import MobileRiskAnalyzer



mobile_api=Blueprint(

"mobile_security",

__name__,

url_prefix="/api/mobile-security"

)



devices=MobileDeviceManager()

apps=MobileAppSecurity()

risk=MobileRiskAnalyzer()



@mobile_api.route("/devices")
def devices_view():

    return jsonify(

    devices.inventory()

    )



@mobile_api.route("/apps")
def apps_view():

    return jsonify(

    apps.analyze()

    )



@mobile_api.route("/risk")
def risk_view():

    return jsonify(

    risk.calculate()

    )



