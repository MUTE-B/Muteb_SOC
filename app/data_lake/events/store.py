

from datetime import datetime



class EventStore:



    events=[]



    def add(self,event):


        record={


        "event":

        event,


        "time":

        str(datetime.utcnow()),


        "status":

        "stored"



        }


        self.events.append(record)


        return record





    def all(self):


        return self.events



