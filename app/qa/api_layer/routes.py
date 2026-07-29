

from flask import Blueprint,jsonify


from app.qa.unit.engine import UnitTestEngine

from app.qa.api.tester import APITestEngine

from app.qa.security.validator import SecurityValidator

from app.qa.health.check import ProductionHealth



qa_api=Blueprint(

"qa",

__name__,

url_prefix="/api/qa"

)



unit=UnitTestEngine()

api=APITestEngine()

security=SecurityValidator()

health=ProductionHealth()



@qa_api.route("/unit")
def unit_test():


    return jsonify(

    unit.run()

    )





@qa_api.route("/api")
def api_test():


    return jsonify(

    api.execute()

    )





@qa_api.route("/security")
def security_test():


    return jsonify(

    security.scan()

    )





@qa_api.route("/health")
def health_test():


    return jsonify(

    health.check()

    )



