

class WazuhConnector:



    def send(self,event):


        return {


            "platform":
            "Wazuh",


            "status":
            "sent",


            "event":
            event

        }



wazuh=WazuhConnector()

