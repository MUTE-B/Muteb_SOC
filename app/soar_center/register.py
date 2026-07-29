

def register_soar_center(app):


    from app.soar_center.api.routes import soar_api


    app.register_blueprint(soar_api)


    print(

    "✓ SOAR ADVANCED CENTER ENABLED"

    )


