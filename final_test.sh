
#!/bin/bash


BASE="http://127.0.0.1:8000"


echo "================================================"
echo "      MUTEB SOC ENTERPRISE v3.0 FINAL TEST"
echo "================================================"


PASS=0
FAIL=0


check(){

if [ $1 -eq 0 ]; then
    echo "[OK] $2"
    PASS=$((PASS+1))
else
    echo "[FAILED] $2"
    FAIL=$((FAIL+1))
fi

}



echo ""
echo "[1] HOME API"

curl -s $BASE/ > /tmp/home.json

cat /tmp/home.json

check $? "Home API"



echo ""
echo "[2] HEALTH CHECK"


curl -s $BASE/api/dashboard/enterprise/health \
-o /tmp/health.json


cat /tmp/health.json


check $? "Enterprise Health"



echo ""
echo "[3] LOGIN JWT"


TOKEN=$(curl -s -X POST \
$BASE/api/auth/login \
-H "Content-Type: application/json" \
-d '
{
"username":"admin",
"password":"Password123"
}' | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))")



if [ -z "$TOKEN" ]; then

echo "[FAILED] JWT TOKEN"

FAIL=$((FAIL+1))

exit

else

echo "[OK] JWT TOKEN GENERATED"

PASS=$((PASS+1))

fi





echo ""
echo "[4] DASHBOARD SUMMARY"



curl -s \
$BASE/api/dashboard/enterprise/summary \
-H "Authorization: Bearer $TOKEN"


check $? "Dashboard"



echo ""
echo "[5] THREAT INTELLIGENCE"



curl -s -X POST \
$BASE/api/threat-intel/lookup \
-H "Authorization: Bearer $TOKEN" \
-H "Content-Type: application/json" \
-d '
{
"value":"185.220.101.1"
}'


check $? "Threat Intel"




echo ""
echo "[6] DETECTION ENGINE"



curl -s -X POST \
$BASE/api/detection/scan \
-H "Authorization: Bearer $TOKEN" \
-H "Content-Type: application/json" \
-d '
{
"log":"Failed SSH login from 185.220.101.1"
}'


check $? "Detection Engine"





echo ""
echo "[7] SECURITY EVENTS"



curl -s \
$BASE/api/security/events \
-H "Authorization: Bearer $TOKEN"


check $? "Security Events"





echo ""
echo "[8] INCIDENT CREATE"



curl -s -X POST \
$BASE/api/incidents/ \
-H "Authorization: Bearer $TOKEN" \
-H "Content-Type: application/json" \
-d '
{
"title":"Final Test Incident",
"severity":"HIGH",
"source":"185.220.101.1",
"description":"Enterprise final testing"
}'


check $? "Incident System"





echo ""
echo "[9] PYTHON MODULE CHECK"


python3 - <<'PY'

modules=[

"app.core.application",

"app.models.user",

"app.models.alert",

"app.models.incident",

"app.api.security",

"app.api.detection",

"app.threat_intel.ioc_engine"

]


for m in modules:

    try:

        __import__(m)

        print("[OK]",m)

    except Exception as e:

        print("[FAILED]",m,e)

PY



echo ""
echo "================================================"
echo "FINAL RESULT"
echo "================================================"


echo "PASSED : $PASS"

echo "FAILED : $FAIL"



if [ $FAIL -eq 0 ]; then

echo "STATUS : MUTEB SOC v3.0 READY"

else

echo "STATUS : NEED FIX"

fi


echo "================================================"


