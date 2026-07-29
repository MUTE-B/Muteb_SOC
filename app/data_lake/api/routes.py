

from flask import Blueprint,jsonify,request


from app.data_lake.events.collector import EventCollector

from app.data_lake.storage.engine import DataStorage

from app.data_lake.search.engine import SecuritySearch

from app.data_lake.analytics.engine import DataAnalytics



lake_api=Blueprint(

"data_lake",

__name__,

url_prefix="/api/data-lake"

)



collector=EventCollector()

storage=DataStorage()

search=SecuritySearch()

analytics=DataAnalytics()



@lake_api.route("/event",methods=["POST"])
def event():


    data=request.json or {}


    result=collector.ingest(

    data.get("type"),

    data.get("data")

    )


    storage.save(result)


    return jsonify(result)





@lake_api.route("/events")
def events():


    return jsonify(

    collector.list()

    )





@lake_api.route("/search/<keyword>")
def search_event(keyword):


    return jsonify(

    search.query(keyword)

    )





@lake_api.route("/analytics")
def analytics_report():


    return jsonify(

    analytics.analyze()

    )



