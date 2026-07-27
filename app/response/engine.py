

import json
import os



class ResponseEngine:



    def __init__(self):


        path=os.path.join(

            os.path.dirname(
                os.path.dirname(__file__)
            ),

            "playbooks/playbooks.json"

        )


        with open(path) as f:

            self.playbooks=json.load(f)




    def execute(self,incident):


        text=str(
            incident
        ).lower()



        selected=""



        if "ssh" in text or "brute" in text:

            selected="bruteforce"


        elif "malware" in text:

            selected="malware"


        elif "phishing" in text:

            selected="phishing"


        elif "ransom" in text:

            selected="ransomware"



        if selected:


            return {

                "status":
                "executed",

                "playbook":
                self.playbooks[selected]

            }



        return {


            "status":
            "no playbook",


            "playbook":
            None

        }





response_engine=ResponseEngine()

