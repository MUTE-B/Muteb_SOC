

def register_identity_governance(app):


    from app.identity_governance.api.routes import identity_api


    app.register_blueprint(identity_api)


    print(

    "✓ IDENTITY GOVERNANCE ENABLED"

    )


