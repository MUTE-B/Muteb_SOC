

def register_knowledge_center(app):


    from app.knowledge_center.api.routes import knowledge_api


    app.register_blueprint(knowledge_api)


    print(

    "✓ KNOWLEDGE CENTER ENABLED"

    )


