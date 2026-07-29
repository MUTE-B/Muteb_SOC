

from flask import Blueprint,jsonify


from app.v60.partners.core import PartnerEcosystem

from app.v60.marketplace.core import SecurityMarketplace

from app.v60.network.core import GlobalThreatNetwork

from app.v60.federation.core import EnterpriseFederation



global_api=Blueprint(

"global_ecosystem",

__name__,

url_prefix="/api/v60"

)



partners=PartnerEcosystem()

market=SecurityMarketplace()

network=GlobalThreatNetwork()

federation=EnterpriseFederation()



@global_api.route("/partners")
def partners_view():

    return jsonify(partners.partners())


@global_api.route("/marketplace")
def marketplace_view():

    return jsonify(market.catalog())


@global_api.route("/threat-network")
def threat_view():

    return jsonify(network.intelligence())


@global_api.route("/federation")
def federation_view():

    return jsonify(federation.connect())


