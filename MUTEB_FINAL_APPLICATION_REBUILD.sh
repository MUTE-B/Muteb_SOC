#!/bin/bash

echo "======================================"
echo " MUTEB SOC APPLICATION FINAL REBUILD"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

cp app/core/application.py app/core/application.py.broken.$(date +%s)



echo "[2] Rebuild application.py"


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

        print("Database warning:", e)



    # Frontend APIs

    try:

        from app.api.frontend_api import frontend_api

        app.register_blueprint(frontend_api)


    except Exception as e:

        print("Frontend API warning:", e)



    # Existing SOC API

    try:

        from app.api.soc import soc

        app.register_blueprint(soc)


    except Exception as e:

        print("SOC API warning:", e)



    # Database create

    try:

        from app.database.database import db

        with app.app_context():

            db.create_all()


    except Exception as e:

        print("Database create warning:", e)



    return app

PY



echo "[3] Syntax Check"

python3 -m py_compile app/core/application.py


if [ $? -ne 0 ]; then

echo "APPLICATION FAILED"

exit 1

fi



echo "[4] Restart Backend"


pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &


sleep 5



echo "[5] Restart Frontend"


pkill -f vite 2>/dev/null || true

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


cd ..


echo ""
echo "======================================"
echo " STATUS"
echo "======================================"


sudo ss -tulpn | grep -E "8000|5173"



echo ""
echo "ROUTES"


python3 - <<'PY'

from run import app

for r in app.url_map.iter_rules():

    print(r.rule)

PY


echo "======================================"
echo " FINISHED"
echo "======================================"

