

def register_observability(app):


    from app.observability.api.routes import observe_api


    app.register_blueprint(

    observe_api

    )


    print(

    "✓ OBSERVABILITY CENTER ENABLED"

    )



