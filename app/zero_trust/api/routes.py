

from flask import Blueprint,jsonify


from app.zero_trust.identity.trust import IdentityTrust

from app.zero_trust.device.security import DeviceTrust

from app.zero_trust.access.control import ZeroTrustAccess



zero_api=Blueprint(

"zero_trust",

__name__,

url_prefix="/api/zero-trust"

)



identity=IdentityTrust()

device=DeviceTrust()

access=ZeroTrustAccess()



@zero_api.route("/identity/<user>")
def identity_check(user):

    return jsonify(

    identity.verify(user)

    )



@zero_api.route("/device/<device_id>")
def device_check(device_id):

    return jsonify(

    device.evaluate(device_id)

    )



@zero_api.route("/access/<resource>")
def access_check(resource):

    return jsonify(

    access.authorize(resource)

    )



