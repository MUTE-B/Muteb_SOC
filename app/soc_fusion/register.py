

def register_soc_fusion(app):


    from app.soc_fusion.api.routes import soc_api


    app.register_blueprint(soc_api)


    print(

    "✓ SOC FUSION COMMAND CENTER ENABLED"

    )


