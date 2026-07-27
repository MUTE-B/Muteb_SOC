

import json
import os
import hashlib



class YaraEngine:



    def __init__(self):

        path=os.path.join(

            os.getcwd(),

            "yara_rules/malware_rules.json"

        )


        with open(path) as f:

            self.rules=json.load(f)




    def hash_file(self,file):


        sha256=hashlib.sha256()



        with open(file,"rb") as f:

            for chunk in iter(
                lambda:f.read(4096),
                b""
            ):

                sha256.update(chunk)



        return sha256.hexdigest()





    def scan(self,file):


        result=[]


        if not os.path.exists(file):

            return {

                "error":
                "File not found"

            }



        with open(
            file,
            "r",
            errors="ignore"
        ) as f:


            content=f.read().lower()



        for rule in self.rules:


            if rule["pattern"] in content:


                result.append({

                    "rule":
                    rule["id"],


                    "name":
                    rule["name"],


                    "severity":
                    "HIGH"

                })



        return {

            "file":
            file,


            "sha256":
            self.hash_file(file),


            "detections":
            result,


            "count":
            len(result)

        }




yara_engine=YaraEngine()

