

def register_rbac(app):


    from app.rbac.api.routes import rbac_api


    app.register_blueprint(

    rbac_api

    )


    print(

    "✓ ADVANCED RBAC ENABLED"

    )



