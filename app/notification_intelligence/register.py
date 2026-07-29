

def register_notification_intelligence(app):


    from app.notification_intelligence.api.routes import notification_api


    app.register_blueprint(notification_api)


    print(

    "✓ NOTIFICATION INTELLIGENCE ENABLED"

    )


