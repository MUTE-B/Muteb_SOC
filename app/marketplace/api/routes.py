

from flask import Blueprint,jsonify


from app.marketplace.registry.plugins import PluginRegistry

from app.marketplace.manager.engine import PluginManager

from app.marketplace.plugins.control import ExtensionControl



market_api=Blueprint(

"marketplace",

__name__,

url_prefix="/api/marketplace"

)



registry=PluginRegistry()

manager=PluginManager()

control=ExtensionControl()



@market_api.route("/plugins")
def plugins():

    return jsonify(

    registry.available()

    )



@market_api.route("/install")
def install():

    return jsonify(

    manager.install(

    "AI Security Extension"

    )

    )



@market_api.route("/status")
def status():

    return jsonify(

    control.status()

    )



