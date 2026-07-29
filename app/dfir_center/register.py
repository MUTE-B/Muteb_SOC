

def register_dfir_center(app):


    from app.dfir_center.api.routes import dfir_api


    app.register_blueprint(dfir_api)


    print(

    "✓ DFIR CENTER ENABLED"

    )


