#!/bin/bash

echo "======================================"
echo " MUTEB SOC MOVE LOGIN ROUTE "
echo "======================================"


cp web_dashboard/app.py web_dashboard/app.py.before_move



python3 - <<'PY'

from pathlib import Path


p = Path("web_dashboard/app.py")

c = p.read_text()


start = c.find('@app.route("/api/login"')

if start == -1:
    print("Login route not found")
    exit()


login_block = c[start:]


c = c[:start]


marker = 'if __name__ == "__main__":'


c = c.replace(
    marker,
    login_block + "\n\n" + marker
)


p.write_text(c)

print("Login route moved successfully")

PY



echo ""
echo "[Restart Backend]"


pkill -f "python3 app.py" || true


sleep 3


source venv/bin/activate


cd web_dashboard


nohup python3 app.py > ../backend.log 2>&1 &


sleep 5



echo ""
echo "[Test Login]"


curl -i -X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'


echo ""
echo "======================================"
echo " FINISHED "
echo "======================================"

