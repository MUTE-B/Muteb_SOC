#!/bin/bash


echo "======================================"
echo " MUTEB SOC SENTINEL X INTEGRATION"
echo "======================================"


mkdir -p app/sentinel_x/core


###################################
# SENTINEL LOADER
###################################


cat > app/sentinel_x/core/loader.py <<'PY'


def load_sentinel(app):

    try:

        from app.sentinel_x.api.routes import sentinel_api


        app.register_blueprint(
            sentinel_api
        )


        print(
            "✓ MUTEB SENTINEL X ENABLED"
        )


    except Exception as error:


        print(
            "Sentinel Load Error:",
            error
        )



PY



###################################
# HEALTH SERVICE
###################################


cat > app/sentinel_x/core/health.py <<'PY'


from datetime import datetime



def sentinel_health():


    return {


    "name":
    "MUTEB SOC Sentinel X",


    "edition":
    "Enterprise",


    "status":
    "Running",


    "time":
    str(datetime.utcnow())


    }



PY



###################################
# API ENHANCEMENT
###################################


cat > app/sentinel_x/api/health_route.py <<'PY'


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



PY



###################################
# REGISTRATION PATCH
###################################


cat > app/sentinel_x/enable.py <<'PY'


def enable_sentinel(app):


    from app.sentinel_x.register import register_sentinel


    register_sentinel(app)


    try:


        from app.sentinel_x.api.health_route import health_api


        app.register_blueprint(
            health_api
        )


    except Exception as e:

        print(e)



PY



echo ""
echo "======================================"
echo " SENTINEL X INTEGRATION READY"
echo "======================================"

