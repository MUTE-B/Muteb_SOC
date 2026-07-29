#!/bin/bash

# ======================================================
# MUTEB SOC - Backend Connection Fix Code 1
# Frontend API Repair Automation
# ======================================================

echo "=============================================="
echo " MUTEB SOC Backend Connection Fix Starting..."
echo "=============================================="


PROJECT="$HOME/Muteb-SOC"
FRONTEND="$PROJECT/frontend"
SRC="$FRONTEND/src"


# -------------------------------
# Check Project
# -------------------------------

if [ ! -d "$FRONTEND" ]; then
    echo "[ERROR] Frontend not found"
    exit 1
fi


echo "[OK] Frontend detected"


# -------------------------------
# Backup
# -------------------------------

echo "[1] Creating backup..."

mkdir -p "$FRONTEND/MUTEB_BACKUP_API"

cp "$SRC/api/"*.js \
"$FRONTEND/MUTEB_BACKUP_API/" 2>/dev/null

cp "$SRC/services/"*.js \
"$FRONTEND/MUTEB_BACKUP_API/" 2>/dev/null


echo "[OK] Backup created"



# -------------------------------
# Environment
# -------------------------------

echo "[2] Creating .env"

cat > "$FRONTEND/.env" <<EOF

VITE_API_URL=http://localhost:8000

EOF



# -------------------------------
# Axios Client
# -------------------------------

echo "[3] Repairing API Client"


cat > "$SRC/api/client.js" <<'EOF'

import axios from "axios";


const client = axios.create({

baseURL:
import.meta.env.VITE_API_URL ||
"http://localhost:8000",

timeout:15000,

headers:{
"Content-Type":"application/json"
}

});



client.interceptors.request.use(

(config)=>{

const token =
localStorage.getItem("token");


if(token){

config.headers.Authorization =
`Bearer ${token}`;

}


return config;


},

(error)=>Promise.reject(error)

);



client.interceptors.response.use(

response=>response,


error=>{


if(!error.response){

console.error(
"Backend Connection Failed"
);

}


return Promise.reject(error);


}

);



export default client;

EOF



# -------------------------------
# Authentication API
# -------------------------------


echo "[4] Repairing Authentication"



cat > "$SRC/api/auth.js" <<'EOF'


import client from "./client";


export async function login(
username,
password
){

return await client.post(

"/auth/login",

{

username,
password

}

);


}



export function logout(){

localStorage.removeItem(
"token"
);

}



EOF



# -------------------------------
# SOC API
# -------------------------------


echo "[5] Repairing SOC API"



cat > "$SRC/api/soc.js" <<'EOF'


import client from "./client";


export async function getSOCStatus(){


const response =
await client.get(
"/soc/status"
);


return response.data;


}


EOF



# -------------------------------
# Services API
# -------------------------------


echo "[6] Repairing Services API"



cat > "$SRC/services/api.js" <<'EOF'


import client from "../api/client";


export default client;


EOF



# -------------------------------
# Install Check
# -------------------------------


echo "[7] Checking Dependencies"


cd "$FRONTEND"


if [ -f package.json ]; then

npm install

fi



# -------------------------------
# Backend Test
# -------------------------------


echo ""
echo "[8] Testing Backend"



if curl -s http://localhost:8000 > /dev/null
then

echo "[OK] Backend reachable on port 8000"

else

echo "[WARNING] Backend not responding on port 8000"

fi



echo ""
echo "=============================================="
echo " MUTEB SOC FIX FINISHED"
echo "=============================================="

echo ""
echo "Run:"
echo "cd ~/Muteb-SOC/frontend"
echo "npm run dev"

echo ""
echo "Backup:"
echo "$FRONTEND/MUTEB_BACKUP_API"
