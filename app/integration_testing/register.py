

def register_integration_testing(app):


    from app.integration_testing.api.routes import test_api


    app.register_blueprint(test_api)


    print(

    "✓ INTEGRATION TESTING ENABLED"

    )

