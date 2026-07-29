

def register_ai_soc(app):


    from app.ai_soc_assistant.api.routes import ai_soc_api


    app.register_blueprint(ai_soc_api)


    print(

    "✓ AI SOC ASSISTANT ENABLED"

    )


