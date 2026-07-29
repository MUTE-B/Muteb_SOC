

from flask import Blueprint,jsonify


from app.integration_testing.tests.engine import IntegrationTester

from app.integration_testing.results.report import TestReport



test_api=Blueprint(

"integration_testing",

__name__,

url_prefix="/api/testing"

)



tester=IntegrationTester()

report=TestReport()



@test_api.route("/run")
def run_test():

    return jsonify(

    tester.run()

    )



@test_api.route("/report")
def report_test():

    return jsonify(

    report.generate()

    )


