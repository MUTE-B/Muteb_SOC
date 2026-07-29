

def register_identity_access(app):


    from app.identity_access.api.routes import identity_api


    app.register_blueprint(identity_api)


    print(

    "✓ IDENTITY ACCESS ENABLED"

    )


