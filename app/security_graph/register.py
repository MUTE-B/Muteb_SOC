

def register_security_graph(app):


    from app.security_graph.api.routes import graph_api


    app.register_blueprint(graph_api)


    print(

    "✓ SECURITY KNOWLEDGE GRAPH ENABLED"

    )


