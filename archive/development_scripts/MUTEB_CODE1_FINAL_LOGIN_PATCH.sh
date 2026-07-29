#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL LOGIN PATCH"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.before_login_fix.$(date +%s)



echo "[2] Replace Login Function"


python3 - <<'PY'

from pathlib import Path

p=Path("frontend/src/App.jsx")

if not p.exists():
    print("App.jsx not found")
    exit()


text=p.read_text()


old='''async function login(){

'''


start=text.find("async function login()")

if start != -1:

    end=text.find("}", start)

    if end != -1:

        new_function=r'''
async function login(){

    try {

        const response = await fetch(
            "http://172.20.10.4:8000/api/login",
            {
                method:"POST",
                headers:{
                    "Content-Type":"application/json"
                },
                body:JSON.stringify({
                    username,
                    password
                })
            }
        );


        const data = await response.json();


        console.log("LOGIN RESPONSE:",data);



        if(data.success === true){

            localStorage.setItem(
                "token",
                data.token
            );


            localStorage.setItem(
                "user",
                JSON.stringify(data.user)
            );


            setMessage(
                "Login Successful"
            );


            window.location.href="/dashboard";


        }
        else{

            setMessage(
                "Invalid Credentials"
            );

        }


    }
    catch(error){

        console.error(error);

        setMessage(
            "Backend Connection Failed"
        );

    }

}
'''

        text=text[:start]+new_function+text[end+1:]

        p.write_text(text)

        print("Login patched")

else:

    print("Login function not found")


PY



echo "[3] Restart Frontend"

pkill -f vite 2>/dev/null || true

sleep 3

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " LOGIN READY"
echo "======================================"

echo ""
echo "USER:"
echo "admin"

echo ""
echo "PASSWORD:"
echo "Muteb@123"

