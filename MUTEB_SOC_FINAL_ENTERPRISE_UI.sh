#!/bin/bash

set -e


PROJECT=$(pwd)

FRONTEND="$PROJECT/frontend"


echo "% 10 FRONTEND SECURITY UI"



cd $FRONTEND



mkdir -p src/scanner



cat > src/scanner/WebScanner.jsx <<'JS'


import React,{useState} from "react";

import axios from "axios";



export default function WebScanner(){


const [domain,setDomain]=useState("");

const [result,setResult]=useState(null);



async function scan(){


try{


const r=await axios.post(

"/api/scanner/start",

{

domain:domain

}

);


setResult(r.data);


}

catch(e){

alert(
"Scanner Error"
)

}


}




return (

<div className="soc-page">


<h1>

MUTEB WEB SECURITY SCANNER

</h1>


<div className="soc-card">


<input

className="soc-input"

placeholder="example.com"

value={domain}

onChange={
e=>setDomain(e.target.value)
}


/>



<button

className="soc-button"

onClick={scan}

>

START SCAN

</button>



</div>



{

result &&


<div className="soc-card">


<h2>

TARGET:

{result.target}

</h2>


<h3>

RISK:

{result.report.risk.risk_level}

</h3>



<h3>

FINDINGS

</h3>



{

result.report.risk.findings.map(

(item,index)=>(

<p key={index}>

{item.issue}

-

{item.severity}

</p>

)

)

}



</div>


}



</div>


)


}

JS




echo "% 30 DASHBOARD LINK"



if [ -f src/App.jsx ]; then


cp src/App.jsx src/App.jsx.enterprise_backup


fi



cat > src/enterprise.css <<'CSS'


body{


background:#050b14;

color:#e8f1ff;

font-family:

Arial, sans-serif;


}



.soc-page{


padding:30px;


}



.soc-card{


background:#081a33;

border:1px solid #00a8ff;

border-radius:12px;

padding:25px;

margin:20px;


}



.soc-input{


background:#020817;

color:white;

padding:12px;

border:1px solid #00a8ff;

border-radius:8px;


}



.soc-button{


background:#00a8ff;

color:white;

padding:12px 25px;

margin-left:10px;

border:0;

border-radius:8px;

cursor:pointer;


}


CSS




echo "% 60 BACKEND HARDENING"



cd ../backend



cat >> app.py <<'PY'


# =================================
# FINAL SECURITY MIDDLEWARE
# =================================


@app.after_request
def enterprise_security(response):


    response.headers["X-Frame-Options"]="DENY"

    response.headers["X-Content-Type-Options"]="nosniff"

    response.headers["Referrer-Policy"]="strict-origin"


    return response



PY




echo "% 80 BUILD"



cd ../frontend


npm run build



echo "% 90 SERVICES"



sudo systemctl restart muteb-backend.service

sudo systemctl restart muteb-frontend.service

sudo systemctl restart nginx



echo "% 100 FINAL READY"



echo "

MUTEB SOC ENTERPRISE FINAL

READY

SOC PLATFORM
+
WEB SECURITY ASSESSMENT
+
REPORTING ENGINE
+
SECURITY HARDENING

"


