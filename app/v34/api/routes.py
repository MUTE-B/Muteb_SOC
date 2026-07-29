

from flask import Blueprint,jsonify


from app.v34.graph.engine import CyberKnowledgeGraph

from app.v34.assets.mapper import AssetMapper

from app.v34.attack_path.analyzer import AttackPathAnalyzer

from app.v34.visualization.view import ThreatVisualization



graph_api=Blueprint(

"intelligence_graph",

__name__,

url_prefix="/api/v34"

)



graph=CyberKnowledgeGraph()

assets=AssetMapper()

attack=AttackPathAnalyzer()

visual=ThreatVisualization()



@graph_api.route("/graph")
def graph_view():

    return jsonify(graph.build())



@graph_api.route("/assets")
def assets_view():

    return jsonify(assets.discover())



@graph_api.route("/attack-path")
def attack_view():

    return jsonify(attack.analyze())



@graph_api.route("/visual")
def visual_view():

    return jsonify(visual.render())



