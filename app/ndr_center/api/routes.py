

from flask import Blueprint,jsonify


from app.ndr_center.traffic.monitor import NetworkTrafficMonitor

from app.ndr_center.analytics.behavior import NetworkBehaviorAnalytics

from app.ndr_center.detection.engine import NetworkThreatDetection



ndr_api=Blueprint(

"ndr_center",

__name__,

url_prefix="/api/ndr"

)



traffic=NetworkTrafficMonitor()

analytics=NetworkBehaviorAnalytics()

detection=NetworkThreatDetection()



@ndr_api.route("/traffic")
def traffic_view():

    return jsonify(

    traffic.analyze()

    )



@ndr_api.route("/behavior")
def behavior_view():

    return jsonify(

    analytics.detect()

    )



@ndr_api.route("/detection")
def detection_view():

    return jsonify(

    detection.scan()

    )



