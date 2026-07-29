

import socket



class PortEngine:


    def scan(self,host):


        ports=[

        21,
        22,
        25,
        53,
        80,
        443,
        8080

        ]


        result=[]


        for port in ports:


            try:

                sock=socket.socket()

                sock.settimeout(1)


                status=sock.connect_ex(
                    (host,port)
                )


                if status==0:

                    result.append({

                    "port":port,
                    "status":"OPEN"

                    })


                sock.close()


            except:

                pass



        return result

