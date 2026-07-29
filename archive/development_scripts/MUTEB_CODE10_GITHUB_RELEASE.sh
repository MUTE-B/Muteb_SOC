#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB RELEASE PUBLISH"
echo " CODE 10"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Check Git"

git status


echo ""
echo "[2] Current Branch"

git branch



echo ""
echo "[3] Push Develop Branch"


git push origin develop



echo ""
echo "[4] Push Release Tag"


git push origin v1.0.0



echo ""
echo "======================================"
echo " GITHUB RELEASE READY"
echo "======================================"


echo ""
echo "Create Release from GitHub:"
echo ""
echo "Repository"
echo "→ Releases"
echo "→ Draft a new release"
echo ""
echo "Tag:"
echo "v1.0.0"
echo ""
echo "Title:"
echo "MUTEB SOC Enterprise v1.0.0"
echo ""


