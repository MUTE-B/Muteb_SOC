

def register_governance(app):


    from app.governance.api.routes import gov_api


    app.register_blueprint(gov_api)


    print(

    "✓ GOVERNANCE LAYER ENABLED"

    )


