

import json
import os



class IOCEngine:



    def __init__(self):


        path=os.path.join(

            os.path.dirname(__file__),

            "ioc_database.json"

        )


        with open(path) as f:

            self.database=json.load(f)





    def search(self,text):


        result={

            "matched":False,

            "type":None,

            "indicator":None,

            "score":0

        }



        for ip in self.database["malicious_ips"]:


            if ip in text:


                result.update({

                    "matched":True,

                    "type":"IP",

                    "indicator":ip,

                    "score":80

                })

                return result





        for domain in self.database["malicious_domains"]:


            if domain in text:


                result.update({

                    "matched":True,

                    "type":"DOMAIN",

                    "indicator":domain,

                    "score":70

                })

                return result






        for h in self.database["malware_hashes"]:


            if h in text:


                result.update({

                    "matched":True,

                    "type":"HASH",

                    "indicator":h,

                    "score":90

                })

                return result



        return result




ioc_engine=IOCEngine()

