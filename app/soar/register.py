

def register_soar(app):


    from app.soar.api.routes import soar_api


    app.register_blueprint(

    soar_api

    )


    print(

    "✓ SOAR AUTOMATION ENABLED"

    )



