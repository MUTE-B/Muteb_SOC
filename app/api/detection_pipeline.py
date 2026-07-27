

from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.detection.pipeline import pipeline



detection_pipeline=Blueprint(

    "detection_pipeline",

    __name__

)




@detection_pipeline.route(

"/analyze",

methods=["POST"]

)


@permission_required("detection")

def analyze():


    data=request.json


    result=pipeline.analyze(

        data["event"]

    )


    return jsonify(result)



