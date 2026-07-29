

def register_advanced_soc(app):


    from app.advanced_soc.api.routes import advanced_api


    app.register_blueprint(

    advanced_api

    )


    print(

    "✓ ADVANCED SOC OPERATIONS ENABLED"

    )



