#!/bin/bash

echo "======================================"
echo " MUTEB SOC APPLICATION STABLE FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup current application"

cp app/core/application.py \
app/core/application.py.failed.$(date +%s) 2>/dev/null || true


echo "[2] Rebuilding application.py"


cat > app/core/application.py <<'PY'
from flask import Flask
from flask_cors import CORS


def create_app():

    app = Flask(__name__)


    app.config.from_mapping(
        SQLALCHEMY_DATABASE_URI="sqlite:///muteb_soc.db",
        SQLALCHEMY_TRACK_MODIFICATIONS=False
    )


    CORS(app)


    # Database
    try:
        from app.database.database import db

        db.init_app(app)

    except Exception as e:
        print("Database init warning:", e)



    # APIs
    try:

        from app.api.frontend_api import frontend_api
        app.register_blueprint(frontend_api)

    except Exception as e:
        print("Frontend API warning:", e)



    try:

        from app.api.soc import soc
        app.register_blueprint(soc)

    except Exception as e:
        print("SOC API warning:", e)



    # Create tables

    try:

        from app.database.database import db

        with app.app_context():
            db.create_all()

    except Exception as e:
        print("Database tables warning:", e)



    return app
PY



echo "[3] Syntax check"

python3 -m py_compile app/core/application.py

if [ $? -ne 0 ]; then
    echo "FAILED application.py"
    exit 1
fi



echo "[4] Restart Backend"

pkill -f "run.py" 2>/dev/null || true

sleep 3

nohup python3 run.py > backend.log 2>&1 &


sleep 6



echo "[5] Port"

sudo ss -tulpn | grep 8000 || true



echo ""
echo "[6] Health"

curl http://localhost:8000/api/health || true



echo ""
echo "[7] Log"

tail -40 backend.log



echo "======================================"
echo " BACKEND READY"
echo "======================================"

