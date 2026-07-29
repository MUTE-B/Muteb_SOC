

def register_integration_hub(app):


    from app.integration_hub.api.routes import integration_api


    app.register_blueprint(

    integration_api

    )


    print(

    "✓ FINAL INTEGRATION HUB ENABLED"

    )



