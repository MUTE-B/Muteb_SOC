

def register_grc_center(app):


    from app.grc_center.api.routes import grc_api


    app.register_blueprint(

    grc_api

    )


    print(

    "✓ GRC COMPLIANCE CENTER ENABLED"

    )



