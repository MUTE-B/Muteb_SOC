#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL BACKEND REPAIR"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup current files"

mkdir -p backup/before_final_fix_$(date +%s)

cp app/core/application.py backup/before_final_fix_$(date +%s)/ 2>/dev/null
cp run.py backup/before_final_fix_$(date +%s)/ 2>/dev/null



echo "[2] Rebuilding application.py"

cat > app/core/application.py <<'PY'

from flask import Flask
from flask_cors import CORS


def create_app():

    app = Flask(__name__)

    CORS(app)


    try:
        from app.database.database import db

        db.init_app(app)


    except Exception as e:
        print("Database init warning:", e)



    try:

        from app.api import *

    except Exception as e:

        print("API loading warning:", e)



    try:

        from app.models import *

        with app.app_context():
            db.create_all()

    except Exception as e:

        print("Database create warning:", e)



    return app

PY



echo "[3] Syntax Check"

python3 -m py_compile app/core/application.py


if [ $? -ne 0 ]; then

echo "FAILED APPLICATION.PY"

exit 1

fi



echo "[4] Restart Backend"

pkill -f "run.py" 2>/dev/null || true

sleep 2


nohup python3 run.py > backend.log 2>&1 &


sleep 6



echo "[5] Port Check"

sudo ss -tulpn | grep 5000 || true



echo "[6] Backend Log"

tail -100 backend.log



echo "======================================"
echo " DONE"
echo "======================================"

