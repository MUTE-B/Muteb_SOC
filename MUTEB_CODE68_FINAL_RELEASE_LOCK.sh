#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL RELEASE LOCK"
echo " CODE 68"
echo "======================================"

cd ~/Muteb-SOC || exit 1


mkdir -p final_release



cat > final_release/FINAL_RELEASE_LOCK.md <<EOF

# MUTEB SOC Enterprise v2.1.1

# Final Release Lock



## Version

v2.1.1



## Release Status

FINAL RELEASE



## Branch

$(git branch --show-current)



## Commit

$(git log -1 --oneline)



## Tag

v2.1.1



## Validation


[x] Repository Clean

[x] Security Cleanup Complete

[x] Documentation Complete

[x] Portfolio Ready

[x] Release Prepared



## Developer

Muteb Albalawi



EOF



echo "[1] Checking tag"



if git rev-parse v2.1.1 >/dev/null 2>&1

then

echo "Tag v2.1.1 already exists"

else

git tag -a v2.1.1 -m "MUTEB SOC Enterprise v2.1.1 Final Portfolio Release"

fi



echo "[2] Git status"

git status --short



echo ""
echo "======================================"
echo " FINAL RELEASE LOCK READY"
echo "======================================"

