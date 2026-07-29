

def register_qa(app):


    from app.qa.api_layer.routes import qa_api


    app.register_blueprint(

    qa_api

    )


    print(

    "✓ QUALITY ASSURANCE CENTER ENABLED"

    )



