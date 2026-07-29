#!/bin/bash

echo "======================================"
echo " MUTEB SOC FRONTEND AUTH FINAL FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Fix axios client"

cat > frontend/src/api/client.js <<'JS'
import axios from "axios";

const client = axios.create({

    baseURL: "http://172.20.10.4:8000",

    headers:{
        "Content-Type":"application/json"
    }

});

export default client;
JS



echo "[2] Fix auth service"

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


    return response.data;

}

JS



echo "[3] Patch App.jsx login function"


python3 - <<'PY'

from pathlib import Path

p=Path("frontend/src/App.jsx")

text=p.read_text()


start=text.find("async function login()")

end=text.find("\n\n    return", start)


new_function='''async function login(){

    try{

        const result = await login(username,password);


        if(result.success){

            setUser(result.user);

            setMessage("Login Successful");

        }

        else{

            setMessage("Invalid Credentials");

        }


    }

    catch(error){

        console.log(error);

        setMessage("Backend Connection Failed");

    }

}'''


if start != -1 and end != -1:

    text=text[:start]+new_function+text[end:]

    p.write_text(text)

    print("App.jsx login patched")

else:

    print("Login function not found")

PY



echo "[4] Restart Frontend"

pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " DONE"
echo "======================================"

tail -20 ../frontend.log

