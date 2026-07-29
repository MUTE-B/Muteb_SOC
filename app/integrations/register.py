

def register_integrations(app):


    from app.integrations.api.routes import integration_api


    app.register_blueprint(

    integration_api

    )


    print(

    "✓ ENTERPRISE INTEGRATIONS ENABLED"

    )



