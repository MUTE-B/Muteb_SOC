

def register_asset_intelligence(app):


    from app.asset_intelligence.api.routes import asset_api


    app.register_blueprint(asset_api)


    print(

    "✓ ASSET INTELLIGENCE ENABLED"

    )


