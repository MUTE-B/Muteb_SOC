

import json
import os



class SigmaEngine:


    def __init__(self):

        path=os.path.join(

            os.path.dirname(__file__),

            "rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def detect(self,event):


        matches=[]


        text=str(event).lower()



        for rule in self.rules:


            if rule["event"] in text:


                matches.append({

                    "rule_id":
                    rule["id"],


                    "name":
                    rule["name"],


                    "severity":
                    rule["severity"],


                    "mitre":
                    rule["mitre"]

                })



        return matches





sigma_engine=SigmaEngine()

