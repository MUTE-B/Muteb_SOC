

from flask import Blueprint,jsonify


from app.security_data_lake.storage.engine import DataLakeStorage

from app.security_data_lake.ingestion.pipeline import DataPipeline

from app.security_data_lake.analytics.engine import DataAnalytics



data_api=Blueprint(

"security_data_lake",

__name__,

url_prefix="/api/data-lake"

)



storage=DataLakeStorage()

pipeline=DataPipeline()

analytics=DataAnalytics()



@data_api.route("/store")
def store():

    return jsonify(

    storage.store(

    "Security Dataset"

    )

    )



@data_api.route("/ingestion")
def ingestion():

    return jsonify(

    pipeline.ingest()

    )



@data_api.route("/analytics")
def analytics_view():

    return jsonify(

    analytics.analyze()

    )



