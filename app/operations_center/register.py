

def register_operations_center(app):


    from app.operations_center.api.routes import ops_api


    app.register_blueprint(ops_api)


    print(

    "✓ OPERATIONS CENTER ENABLED"

    )


