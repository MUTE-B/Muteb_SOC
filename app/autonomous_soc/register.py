

def register_autonomous_soc(app):


    from app.autonomous_soc.api.routes import auto_api


    app.register_blueprint(

    auto_api

    )


    print(

    "✓ AUTONOMOUS SOC ENABLED"

    )



