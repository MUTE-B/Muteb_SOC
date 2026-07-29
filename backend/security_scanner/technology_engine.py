

import requests



class TechnologyEngine:



    def detect(self,url):


        try:

            r=requests.get(

            url,

            timeout=5

            )


            server=r.headers.get(
                "Server",
                "Unknown"
            )


            return {


            "server":server,


            "technologies":[

            "HTTP",

            "Web Server"

            ]


            }


        except:


            return {


            "server":"Unknown",

            "technologies":[]

            }

