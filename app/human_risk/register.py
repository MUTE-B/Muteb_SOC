

def register_human_risk(app):


    from app.human_risk.api.routes import human_api


    app.register_blueprint(human_api)


    print(

    "✓ HUMAN RISK CENTER ENABLED"

    )


