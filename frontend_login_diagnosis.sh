#!/bin/bash

set +e

PROJECT="$HOME/Muteb-SOC"
FRONTEND="$PROJECT/frontend"
REPORT="$PROJECT/frontend_login_diagnosis_$(date +%Y%m%d_%H%M%S).txt"

echo "========================================" | tee "$REPORT"
echo " MUTEB SOC FRONTEND LOGIN DIAGNOSIS" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"

echo "" | tee -a "$REPORT"
echo "[1] Frontend structure" | tee -a "$REPORT"

find "$FRONTEND/src" -maxdepth 3 -type f \
| grep -Ei "Login|App|Route|Router|Dashboard|auth|api|service" \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[2] Login flow inspection" | tee -a "$REPORT"

grep -RniE \
"localStorage|sessionStorage|token|jwt|navigate|dashboard|success|login|redirect|useNavigate" \
"$FRONTEND/src" \
2>/dev/null \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[3] API endpoint inspection" | tee -a "$REPORT"

grep -RniE \
"/api/login|axios|fetch|Authorization|Bearer" \
"$FRONTEND/src" \
2>/dev/null \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[4] Route inspection" | tee -a "$REPORT"

grep -RniE \
"react-router|Routes|Route|Navigate|Protected|Private|AuthGuard|Dashboard" \
"$FRONTEND/src" \
2>/dev/null \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[5] Dashboard files" | tee -a "$REPORT"

find "$FRONTEND/src" -type f \
| grep -Ei "dashboard|home|main" \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[6] Package information" | tee -a "$REPORT"

cat "$FRONTEND/package.json" 2>/dev/null \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "[7] Frontend build check" | tee -a "$REPORT"

cd "$FRONTEND"

if [ -d node_modules ]; then

npm run build 2>&1 \
| tee -a "$REPORT"

else

echo "node_modules not found - skipped build" \
| tee -a "$REPORT"

fi


echo "" | tee -a "$REPORT"
echo "[8] Git status (no changes made)" | tee -a "$REPORT"

cd "$PROJECT"

git status \
| tee -a "$REPORT"


echo "" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
echo " DIAGNOSIS COMPLETE" | tee -a "$REPORT"
echo "REPORT:"
echo "$REPORT" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
