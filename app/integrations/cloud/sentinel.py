

class SentinelConnector:


    def send_event(self,event):


        return {

            "platform":"MICROSOFT SENTINEL",

            "status":"SENT",

            "event":event

        }



sentinel=SentinelConnector()

