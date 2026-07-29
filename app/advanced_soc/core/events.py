

from datetime import datetime



class SecurityEventEngine:



    events=[]



    def add_event(self,event_type,severity,source):


        event={


        "id":

        len(self.events)+1,


        "type":

        event_type,


        "severity":

        severity,


        "source":

        source,


        "status":

        "OPEN",


        "time":

        str(datetime.utcnow())


        }



        self.events.append(event)


        return event




    def timeline(self):


        return self.events



