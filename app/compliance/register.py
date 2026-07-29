

def register_compliance(app):


    from app.compliance.api.routes import compliance_api


    app.register_blueprint(

    compliance_api

    )


    print(

    "✓ COMPLIANCE GOVERNANCE ENABLED"

    )



