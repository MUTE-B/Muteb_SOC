

def register_enterprise(app):


    from app.enterprise.api.routes import rbac_api


    app.register_blueprint(

    rbac_api

    )


    print(

    "✓ ENTERPRISE RBAC ENABLED"

    )


