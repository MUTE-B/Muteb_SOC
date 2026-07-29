

from flask import Blueprint,jsonify


from app.soc_fusion.dashboard.overview import SOCOverview

from app.soc_fusion.analyst.workspace import AnalystWorkspace

from app.soc_fusion.executive.report import ExecutiveSecurityView



soc_api=Blueprint(

"soc_fusion",

__name__,

url_prefix="/api/soc"

)



overview=SOCOverview()

analyst=AnalystWorkspace()

executive=ExecutiveSecurityView()



@soc_api.route("/overview")
def overview_view():

    return jsonify(

    overview.status()

    )



@soc_api.route("/analyst")
def analyst_view():

    return jsonify(

    analyst.tools()

    )



@soc_api.route("/executive")
def executive_view():

    return jsonify(

    executive.report()

    )



