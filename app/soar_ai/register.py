

def register_soar_ai(app):


    from app.soar_ai.api.routes import soar_ai_api


    app.register_blueprint(

    soar_ai_api

    )


    print(

    "✓ SOAR AI INTELLIGENCE ENABLED"

    )



