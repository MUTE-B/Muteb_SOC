

class EventNormalizer:



    def normalize(self,event):


        return {


        "source":

        event.get("source","unknown"),


        "category":

        event.get("category","security"),


        "severity":

        event.get("severity","low"),


        "message":

        event.get("message","")



        }



