

def register_compliance_intelligence(app):


    from app.compliance_intelligence.api.routes import compliance_api


    app.register_blueprint(compliance_api)


    print(

    "✓ COMPLIANCE INTELLIGENCE ENABLED"

    )


