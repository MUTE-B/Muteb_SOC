

from datetime import datetime



class EventCollector:



    events=[]



    def ingest(self,event_type,data):


        event={


        "type":

        event_type,


        "data":

        data,


        "time":

        str(datetime.utcnow())



        }


        self.events.append(event)


        return event



    def list(self):


        return self.events



