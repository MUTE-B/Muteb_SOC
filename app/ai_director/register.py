

def register_ai_director(app):


    from app.ai_director.api.routes import ai_api


    app.register_blueprint(

    ai_api

    )


    print(

    "✓ AI SECURITY DIRECTOR ENABLED"

    )



