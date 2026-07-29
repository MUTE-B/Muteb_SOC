

def register_tenant(app):


    from app.enterprise.api.tenant_routes import tenant_api


    app.register_blueprint(

    tenant_api

    )


    print(

    "✓ MULTI TENANT ARCHITECTURE ENABLED"

    )



