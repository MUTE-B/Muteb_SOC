

def register_security_audit(app):


    from app.security_audit.api.routes import audit_api


    app.register_blueprint(

    audit_api

    )


    print(

    "✓ SECURITY AUDIT LAYER ENABLED"

    )



