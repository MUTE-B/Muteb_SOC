

def register_ai_intelligence(app):


    from app.intelligence.api.routes import ai_api


    app.register_blueprint(

    ai_api

    )


    print(

    "✓ AI SECURITY INTELLIGENCE ENABLED"

    )


