#!/bin/bash

echo "======================================"
echo " MUTEB SOC FRONTEND LOGIN CONNECT FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Fix API client"


cat > frontend/src/api/client.js <<'JS'
import axios from "axios";


const client = axios.create({

    baseURL:
    import.meta.env.VITE_API_URL ||
    "http://localhost:8000",

    headers:{
        "Content-Type":"application/json"
    }

});


export default client;
JS



echo "[2] Fix Auth API"


mkdir -p frontend/src/api


cat > frontend/src/api/auth.js <<'JS'

import client from "./client";


export async function login(username,password){

    const response = await client.post(
        "/api/login",
        {
            username,
            password
        }
    );


    if(response.data.token){

        localStorage.setItem(
            "token",
            response.data.token
        );

        localStorage.setItem(
            "user",
            JSON.stringify(response.data.user)
        );

    }


    return response.data;

}

JS



echo "[3] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 6


echo ""
echo "======================================"
echo " DONE"
echo "======================================"

echo "Open:"
echo "http://172.20.10.4:5173"

