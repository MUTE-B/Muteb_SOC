

def register_marketplace(app):


    from app.marketplace.api.routes import market_api


    app.register_blueprint(market_api)


    print(

    "✓ CYBER DEFENSE MARKETPLACE ENABLED"

    )


