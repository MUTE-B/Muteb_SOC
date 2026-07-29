

from flask import Blueprint,jsonify


from app.v36.plugins.engine import PluginManager

from app.v36.connectors.hub import ConnectorHub

from app.v36.marketplace.store import Marketplace

from app.v36.extensions.core import ExtensionFramework



hub_api=Blueprint(

"integration_hub",

__name__,

url_prefix="/api/v36"

)



plugins=PluginManager()

connectors=ConnectorHub()

market=Marketplace()

extensions=ExtensionFramework()



@hub_api.route("/plugins")
def plugin_view():

    return jsonify(plugins.list())


@hub_api.route("/connectors")
def connector_view():

    return jsonify(connectors.integrations())


@hub_api.route("/marketplace")
def market_view():

    return jsonify(market.catalog())


@hub_api.route("/extensions")
def extension_view():

    return jsonify(extensions.status())


