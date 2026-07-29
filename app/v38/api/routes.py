

from flask import Blueprint,jsonify


from app.v38.regions.manager import RegionManager

from app.v38.availability.engine import HighAvailability

from app.v38.recovery.engine import DisasterRecovery

from app.v38.scaling.engine import EnterpriseScaling



global_api=Blueprint(

"global_platform",

__name__,

url_prefix="/api/v38"

)



regions=RegionManager()

ha=HighAvailability()

dr=DisasterRecovery()

scale=EnterpriseScaling()



@global_api.route("/regions")
def region_view():

    return jsonify(regions.status())


@global_api.route("/availability")
def availability_view():

    return jsonify(ha.check())


@global_api.route("/recovery")
def recovery_view():

    return jsonify(dr.backup())


@global_api.route("/scaling")
def scaling_view():

    return jsonify(scale.scale())


