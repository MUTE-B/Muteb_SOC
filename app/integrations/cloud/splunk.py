

class SplunkConnector:


    def send_event(self,event):


        return {

            "platform":"SPLUNK",

            "status":"SENT",

            "event":event

        }



splunk=SplunkConnector()

