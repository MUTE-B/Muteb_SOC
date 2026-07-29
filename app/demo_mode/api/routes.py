

from flask import Blueprint,jsonify


from app.demo_mode.core.demo import DemoEnvironment



demo_api=Blueprint(

"demo",

__name__,

url_prefix="/api/demo"

)



demo=DemoEnvironment()



@demo_api.route("/overview")
def overview():


    return jsonify(

    demo.load()

    )



