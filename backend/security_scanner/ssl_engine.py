

import ssl

import socket



class SSLEngine:



    def check(self,domain):


        result={}


        try:


            ctx=ssl.create_default_context()


            with socket.create_connection(

                (domain,443),

                timeout=5

            ) as sock:


                with ctx.wrap_socket(

                    sock,
                    server_hostname=domain

                ) as s:


                    result={

                    "tls":
                    s.version(),

                    "cipher":
                    s.cipher()[0],

                    "status":
                    "secure"

                    }



        except Exception as e:

            result={

            "status":"failed",

            "error":str(e)

            }


        return result

