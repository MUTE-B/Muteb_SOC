

def register_business_continuity(app):


    from app.business_continuity.api.routes import bc_api


    app.register_blueprint(

    bc_api

    )


    print(

    "✓ BUSINESS CONTINUITY CENTER ENABLED"

    )



