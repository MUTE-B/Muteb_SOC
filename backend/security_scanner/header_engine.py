

import requests



class HeaderEngine:


    def analyze(self,url):


        result={}


        try:

            r=requests.get(
                url,
                timeout=5
            )


            headers=r.headers


            security=[

            "Content-Security-Policy",
            "X-Frame-Options",
            "X-Content-Type-Options",
            "Strict-Transport-Security"

            ]


            missing=[]


            for h in security:

                if h not in headers:

                    missing.append(h)



            result={

            "server":
            headers.get("Server"),

            "missing_headers":
            missing,

            "status":
            r.status_code

            }


        except Exception as e:

            result["error"]=str(e)


        return result

