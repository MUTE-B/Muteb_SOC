

def register_production(app):


    from app.production.routes import production_api


    app.register_blueprint(

    production_api

    )


    print(

    "✓ PRODUCTION OPERATIONS ENABLED"

    )



