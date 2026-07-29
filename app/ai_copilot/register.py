

def register_ai_copilot(app):


    from app.ai_copilot.api.routes import ai_api


    app.register_blueprint(ai_api)


    print(

    "✓ AI SECURITY COPILOT ENABLED"

    )


