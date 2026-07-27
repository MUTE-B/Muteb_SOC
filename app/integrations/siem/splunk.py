

class SplunkConnector:



    def send(self,event):


        return {


            "platform":
            "Splunk",


            "status":
            "sent",


            "event":
            event

        }



splunk=SplunkConnector()

