#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE DARK THEME"
echo "======================================"

cd ~/Muteb-SOC || exit 1


cat > frontend/src/App.css <<'CSS'

*{
    box-sizing:border-box;
}


body{

    margin:0;
    font-family:
    "Segoe UI",
    Arial,
    sans-serif;

    background:
    linear-gradient(
        135deg,
        #050816,
        #0b1225
    );

    color:#ffffff;

}



.login-container{


    min-height:100vh;

    display:flex;

    flex-direction:column;

    justify-content:center;

    align-items:center;


}



.login-container h1{


    font-size:42px;

    letter-spacing:4px;

    color:#00e5ff;

    text-shadow:
    0 0 15px #00e5ff;


}



.login-container input{


    width:320px;

    padding:15px;

    margin:10px;

    border-radius:8px;

    border:1px solid #1e90ff;

    background:#111827;

    color:white;

    font-size:16px;

}



.login-container button{


    width:320px;

    padding:15px;

    margin-top:20px;


    border:none;

    border-radius:8px;


    background:
    linear-gradient(
        90deg,
        #0066ff,
        #00e5ff
    );


    color:white;

    font-size:18px;

    font-weight:bold;

    cursor:pointer;


}



.login-container button:hover{


    box-shadow:
    0 0 20px #00e5ff;


}



.login-container h2{


    color:#00ff99;

    font-size:30px;


}



.login-container p{


    color:#cbd5e1;

    font-size:18px;


}


CSS



echo "[Restart frontend]"

pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo "======================================"
echo " DONE"
echo "======================================"

