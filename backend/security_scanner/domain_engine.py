
import socket


class DomainEngine:


    def analyze(self,domain):

        result={

            "domain":domain,
            "ip":None,
            "status":"unknown"

        }


        try:

            result["ip"] = socket.gethostbyname(domain)

            result["status"]="resolved"


        except Exception as e:

            result["error"]=str(e)


        return result

