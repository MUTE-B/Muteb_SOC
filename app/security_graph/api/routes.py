

from flask import Blueprint,jsonify


from app.security_graph.entities.manager import SecurityEntities

from app.security_graph.relations.engine import RelationEngine

from app.security_graph.correlation.ai_engine import AICorrelationEngine



graph_api=Blueprint(

"security_graph",

__name__,

url_prefix="/api/security-graph"

)



entities=SecurityEntities()

relations=RelationEngine()

ai=AICorrelationEngine()



@graph_api.route("/entities")
def entity_view():

    return jsonify(

    entities.list()

    )



@graph_api.route("/relations")
def relation_view():

    return jsonify(

    relations.analyze()

    )



@graph_api.route("/correlation")
def correlation_view():

    return jsonify(

    ai.correlate()

    )



