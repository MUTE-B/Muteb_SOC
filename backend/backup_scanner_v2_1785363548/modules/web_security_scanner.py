
import socket
import ssl
import requests


def scan_domain(target):

    result={

    "target":target,
    "findings":[],
    "risk":"LOW"

    }


    try:

        ip=socket.gethostbyname(target)

        result["ip"]=ip


    except:

        result["findings"].append(

        {

        "title":"DNS Resolution Failed",

        "severity":"HIGH"

        }

        )


        return result



    try:

        r=requests.get(

        "https://"+target,

        timeout=5

        )


        headers=r.headers



        required=[

        "Content-Security-Policy",

        "X-Frame-Options",

        "Strict-Transport-Security"

        ]


        for h in required:


            if h not in headers:


                result["findings"].append({

                "title":"Missing Security Header "+h,

                "severity":"MEDIUM",

                "owasp":"A05 Security Misconfiguration"

                })



    except Exception as e:


        result["findings"].append({

        "title":"HTTPS Check Failed",

        "severity":"HIGH"

        })



    try:

        ctx=ssl.create_default_context()

        with ctx.wrap_socket(

        socket.socket(),

        server_hostname=target

        ) as s:

            s.settimeout(5)

            s.connect((target,443))


            result["tls"]="Enabled"


    except:


        result["findings"].append({

        "title":"TLS Configuration Issue",

        "severity":"HIGH"

        })



    if len(result["findings"])>2:

        result["risk"]="HIGH"


    elif len(result["findings"])>0:

        result["risk"]="MEDIUM"



    return result



