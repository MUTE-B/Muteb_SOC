

from flask import Blueprint,jsonify


from app.security.siem.engine import SIEMEngine

from app.security.soar.engine import SOAREngine

from app.security.edr.engine import EDREngine

from app.security.ndr.engine import NDREngine

from app.security.threat_intel.engine import ThreatIntel



security_api=Blueprint(

"security",

__name__,

url_prefix="/api/security"

)



siem=SIEMEngine()

soar=SOAREngine()

edr=EDREngine()

ndr=NDREngine()

intel=ThreatIntel()



@security_api.route("/siem")
def siem_view():

    return jsonify(

    siem.collect()

    )



@security_api.route("/soar")
def soar_view():

    return jsonify(

    soar.automate()

    )



@security_api.route("/edr")
def edr_view():

    return jsonify(

    edr.monitor()

    )



@security_api.route("/ndr")
def ndr_view():

    return jsonify(

    ndr.monitor()

    )



@security_api.route("/threat-intel")
def intel_view():

    return jsonify(

    intel.intelligence()

    )



