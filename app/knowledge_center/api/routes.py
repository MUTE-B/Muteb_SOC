

from flask import Blueprint,jsonify


from app.knowledge_center.articles.library import KnowledgeLibrary

from app.knowledge_center.sop.process import SOPManager

from app.knowledge_center.training.platform import TrainingCenter



knowledge_api=Blueprint(

"knowledge_center",

__name__,

url_prefix="/api/knowledge"

)



library=KnowledgeLibrary()

sop=SOPManager()

training=TrainingCenter()



@knowledge_api.route("/library")
def library_view():

    return jsonify(

    library.list()

    )



@knowledge_api.route("/sop")
def sop_view():

    return jsonify(

    sop.procedures()

    )



@knowledge_api.route("/training")
def training_view():

    return jsonify(

    training.courses()

    )


