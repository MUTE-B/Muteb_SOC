

from flask import Blueprint,jsonify,request



from app.intelligence_center.attack_surface.surface_engine import AttackSurfaceEngine



surface_api=Blueprint(

"attack_surface",

__name__,

url_prefix="/api/intelligence"

)




@surface_api.route("/surface/status")
def surface_status():


    return jsonify(

    AttackSurfaceEngine().inventory()

    )




@surface_api.route("/surface/analyze",methods=["POST"])
def analyze_surface():


    data=request.json or {}


    return jsonify(

    AttackSurfaceEngine().analyze(

    data.get("asset")

    )

    )



