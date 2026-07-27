

class WazuhConnector:


    def analyze(self,event):


        return {

            "source":"WAZUH",

            "event":event,

            "status":"PROCESSED"

        }



wazuh=WazuhConnector()

