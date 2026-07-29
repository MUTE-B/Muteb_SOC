

def register_ai_threat_hunting(app):


    from app.ai_threat_hunting.api.routes import hunting_api


    app.register_blueprint(hunting_api)


    print(

    "✓ AI THREAT HUNTING ENABLED"

    )


