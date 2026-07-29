

def register_dfir_intelligence(app):


    from app.dfir_intelligence.api.routes import dfir_api


    app.register_blueprint(dfir_api)


    print(

    "✓ DFIR INTELLIGENCE ENABLED"

    )


