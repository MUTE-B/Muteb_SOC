

def register_command_center(app):


    from app.cyber_command_launcher.api.routes import command_api


    app.register_blueprint(

    command_api

    )


    print(

    "✓ CYBER COMMAND CENTER ENABLED"

    )



