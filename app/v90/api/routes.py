

from flask import Blueprint,jsonify


from app.v90.cyber_os.core import CyberDefenseOS

from app.v90.control_plane.core import SecurityControlPlane

from app.v90.federation.core import FederationV2

from app.v90.threat_mesh.core import ThreatMesh

from app.v90.command.core import SecurityCommand



os_api=Blueprint(

"cyber_os",

__name__,

url_prefix="/api/v90"

)



os=CyberDefenseOS()

control=SecurityControlPlane()

federation=FederationV2()

mesh=ThreatMesh()

command=SecurityCommand()



@os_api.route("/status")
def status():

    return jsonify(os.status())


@os_api.route("/control")
def control_view():

    return jsonify(control.control())


@os_api.route("/federation")
def federation_view():

    return jsonify(federation.connect())


@os_api.route("/mesh")
def mesh_view():

    return jsonify(mesh.intelligence())


@os_api.route("/command")
def command_view():

    return jsonify(command.overview())



