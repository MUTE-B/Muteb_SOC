

import json
import os



class ThreatHunter:



    def __init__(self):

        path=os.path.join(

            os.path.dirname(__file__),

            "hunting_rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def scan(self,data):


        findings=[]


        text=str(data).lower()



        for item in self.rules["process"]["suspicious"]:

            if item in text:

                findings.append({

                    "type":"PROCESS",

                    "indicator":item,

                    "severity":"HIGH"

                })



        for port in self.rules["network"]["suspicious_ports"]:

            if str(port) in text:

                findings.append({

                    "type":"NETWORK",

                    "indicator":port,

                    "severity":"MEDIUM"

                })



        for path in self.rules["files"]["suspicious"]:

            if path in text:

                findings.append({

                    "type":"FILE",

                    "indicator":path,

                    "severity":"HIGH"

                })



        return findings





hunter=ThreatHunter()

