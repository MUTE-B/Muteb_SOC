

class SecurityDataLake:



    events=[]



    def store(self,event):


        self.events.append(event)


        return {


        "stored":

        True,


        "event":

        event,


        "total_events":

        len(self.events)



        }




    def list(self):


        return self.events



