#!/bin/bash

BASE="http://127.0.0.1:8000"


echo "================================="
echo " MUTEB SOC v5.0 FINAL TEST"
echo "================================="


curl -s $BASE/



echo ""

curl -s $BASE/api/dashboard/enterprise/health



echo ""

curl -s $BASE/api/version/info \
-H "Authorization: Bearer $TOKEN"


echo ""

echo "================================="
echo " RELEASE COMPLETE"
echo "================================="

