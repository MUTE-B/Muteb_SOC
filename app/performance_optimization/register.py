

def register_performance(app):


    from app.performance_optimization.api.routes import performance_api


    app.register_blueprint(performance_api)


    print(

    "✓ PERFORMANCE OPTIMIZATION ENABLED"

    )


