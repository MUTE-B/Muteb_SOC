

def register_audit_governance(app):


    from app.audit_governance.api.routes import audit_api


    app.register_blueprint(audit_api)


    print(

    "✓ AUDIT GOVERNANCE ENABLED"

    )


