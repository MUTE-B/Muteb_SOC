

def register_threat_simulation(app):


    from app.threat_simulation.api.routes import simulation_api


    app.register_blueprint(simulation_api)


    print(

    "✓ THREAT SIMULATION LAB ENABLED"

    )


