

def register_ai_model_management(app):


    from app.ai_model_management.api.routes import ai_model_api


    app.register_blueprint(ai_model_api)


    print(

    "✓ AI MODEL MANAGEMENT ENABLED"

    )


