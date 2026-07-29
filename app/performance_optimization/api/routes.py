

from flask import Blueprint,jsonify


from app.performance_optimization.metrics.collector import PerformanceCollector

from app.performance_optimization.optimizer.engine import OptimizationEngine



performance_api=Blueprint(

"performance",

__name__,

url_prefix="/api/performance"

)



collector=PerformanceCollector()

optimizer=OptimizationEngine()



@performance_api.route("/metrics")
def metrics():

    return jsonify(

    collector.collect()

    )



@performance_api.route("/optimize")
def optimize():

    return jsonify(

    optimizer.optimize()

    )


