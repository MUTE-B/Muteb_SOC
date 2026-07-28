#!/bin/bash

VERSION="v1.0.0"

echo "===================================="
echo " MUTEB SOC GITHUB RELEASE "
echo " VERSION: $VERSION "
echo "===================================="


echo ""
echo "[1] Checking Git..."

if ! git rev-parse --git-dir > /dev/null 2>&1
then
echo "ERROR: Not a Git repository"
exit 1
fi


echo "OK - Git Repository"



echo ""
echo "[2] Current Branch"

git branch --show-current



echo ""
echo "[3] Adding Files"

git add .



echo ""
echo "[4] Creating Commit"


git commit -m "MUTEB SOC Enterprise $VERSION Release"



echo ""
echo "[5] Creating Version Tag"


if git rev-parse "$VERSION" >/dev/null 2>&1
then

echo "Tag already exists"

else

git tag -a "$VERSION" -m "MUTEB SOC Enterprise Release $VERSION"

fi



echo ""
echo "===================================="
echo " RELEASE CREATED "
echo "===================================="


echo ""
echo "Push commands:"
echo ""
echo "git push origin main"
echo "git push origin $VERSION"


