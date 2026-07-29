

from flask import Blueprint,jsonify


from app.asset_intelligence.discovery.scanner import AssetDiscovery

from app.asset_intelligence.cmdb.database import CMDB

from app.asset_intelligence.risk.engine import AssetRisk



asset_api=Blueprint(

"asset_intelligence",

__name__,

url_prefix="/api/assets"

)



discovery=AssetDiscovery()

cmdb=CMDB()

risk=AssetRisk()



@asset_api.route("/discover")
def discover():

    return jsonify(

    discovery.discover()

    )



@asset_api.route("/cmdb")
def cmdb_view():

    return jsonify(

    cmdb.inventory()

    )



@asset_api.route("/risk")
def asset_risk():

    return jsonify(

    risk.calculate()

    )



