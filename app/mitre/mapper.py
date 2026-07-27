import json
import os


class MitreMapper:


    def __init__(self):

        file=os.path.join(
            os.path.dirname(__file__),
            "techniques.json"
        )

        with open(file) as f:
            self.techniques=json.load(f)



    def analyze(self,event):

        event=event.lower()


        if "ssh" in event and "fail" in event:

            return self.techniques["ssh_failed_login"]


        if "root" in event:

            return self.techniques["root_login"]


        if "shell" in event:

            return self.techniques["command_execution"]



        return {
            "id":"UNKNOWN",
            "name":"Unknown",
            "tactic":"Unknown"
        }



mitre_mapper=MitreMapper()
