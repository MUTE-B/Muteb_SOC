

def register_incident_response(app):


    from app.incident_response.api.routes import incident_api


    app.register_blueprint(

    incident_api

    )


    print(

    "✓ INCIDENT RESPONSE ENABLED"

    )



