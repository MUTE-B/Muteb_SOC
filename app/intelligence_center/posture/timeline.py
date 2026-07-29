

from datetime import datetime



class SecurityPostureTimeline:



    history=[]



    def add_event(self,event):


        self.history.append({


        "event":

        event,


        "time":

        str(datetime.utcnow())


        })


        return self.history




    def view(self):


        return self.history



