

from flask import Blueprint,jsonify


from app.data_protection.classification.engine import DataClassification

from app.data_protection.dlp.engine import DLPProtection

from app.data_protection.governance.manager import DataGovernance



data_protection_api=Blueprint(

"data_protection",

__name__,

url_prefix="/api/data-protection"

)



classification=DataClassification()

dlp=DLPProtection()

governance=DataGovernance()



@data_protection_api.route("/classification")
def classification_view():

    return jsonify(

    classification.classify()

    )



@data_protection_api.route("/dlp")
def dlp_view():

    return jsonify(

    dlp.scan()

    )



@data_protection_api.route("/governance")
def governance_view():

    return jsonify(

    governance.status()

    )



