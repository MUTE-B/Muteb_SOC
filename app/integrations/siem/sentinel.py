

class SentinelConnector:



    def send(self,event):


        return {


            "platform":
            "Microsoft Sentinel",


            "status":
            "sent",


            "event":
            event

        }



sentinel=SentinelConnector()

