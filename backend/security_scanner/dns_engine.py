

import socket


class DNSEngine:


    def scan(self,domain):

        records=[]


        try:

            ip=socket.gethostbyname(domain)

            records.append({

            "type":"A",
            "value":ip

            })


        except:

            pass


        return records

