

from flask import Blueprint,jsonify


from app.attack_surface.assets.manager import AssetManager

from app.attack_surface.exposure.engine import ExposureEngine

from app.attack_surface.security_twin.twin import SecurityTwin



surface_api=Blueprint(

"attack_surface",

__name__,

url_prefix="/api/surface"

)



assets=AssetManager()

exposure=ExposureEngine()

twin=SecurityTwin()



@surface_api.route("/assets")
def asset_inventory():


    return jsonify(

    assets.inventory()

    )





@surface_api.route("/exposure")
def exposure_view():


    return jsonify(

    exposure.analyze()

    )





@surface_api.route("/twin")
def security_twin():


    return jsonify(

    twin.profile()

    )



