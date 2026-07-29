#!/bin/bash

echo "======================================"
echo " MUTEB SOC APP JSX FINAL REBUILD"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.broken.$(date +%s) 2>/dev/null



echo "[2] Writing clean App.jsx"


cat > frontend/src/App.jsx <<'JSX'

import { useState } from "react";
import axios from "axios";
import "./App.css";


const API = import.meta.env.VITE_API_URL || "http://172.20.10.4:8000";


function App(){

    const [username,setUsername]=useState("");
    const [password,setPassword]=useState("");
    const [message,setMessage]=useState("");
    const [user,setUser]=useState(null);



    async function login(){

        try{

            const response = await axios.post(
                `${API}/api/login`,
                {
                    username,
                    password
                }
            );


            if(response.data.success){

                setUser(response.data.user);

                setMessage(
                    "Login Successful"
                );

            }
            else{

                setMessage(
                    "Invalid Credentials"
                );

            }


        }
        catch(error){

            console.log(error);

            setMessage(
                "Backend Connection Failed"
            );

        }

    }



    return (

        <div className="login-container">


            <h1>
                MUTEB SOC
            </h1>


            {
                user ?

                <div>

                    <h2>
                        Welcome {user.username}
                    </h2>


                    <p>
                        Role: {user.role}
                    </p>


                </div>

                :


                <div>


                    <input
                    placeholder="Username"
                    value={username}
                    onChange={
                        e=>setUsername(e.target.value)
                    }
                    />


                    <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={
                        e=>setPassword(e.target.value)
                    }
                    />


                    <button
                    onClick={login}
                    >
                        Login
                    </button>


                </div>

            }


            <p>
                {message}
            </p>


        </div>

    );


}


export default App;

JSX



echo "[3] Restart Frontend"

pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " CHECK"
echo "======================================"


tail -30 ../frontend.log


echo ""
echo "OPEN:"
echo "http://172.20.10.4:5173"


