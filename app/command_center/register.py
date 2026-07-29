

def register_command_center(app):


    from app.command_center.api.routes import command_api


    app.register_blueprint(

    command_api

    )


    print(
    "✓ SOC COMMAND CENTER ENABLED"
    )



