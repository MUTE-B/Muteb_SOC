

def register_api_gateway(app):


    from app.api_gateway.api.routes import gateway_api


    app.register_blueprint(gateway_api)


    print(

    "✓ API GATEWAY ENABLED"

    )


