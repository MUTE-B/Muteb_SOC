

from flask import Blueprint,jsonify

from app.sentinel_x.core.health import sentinel_health



health_api = Blueprint(
    "sentinel_health",
    __name__,
    url_prefix="/api/sentinel"
)



@health_api.route("/health")
def health():

    return jsonify(
        sentinel_health()
    )



