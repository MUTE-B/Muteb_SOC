

def register_compliance_center(app):


    from app.compliance_center.api.routes import compliance_api


    app.register_blueprint(compliance_api)


    print(

    "✓ COMPLIANCE AUDIT CENTER ENABLED"

    )


