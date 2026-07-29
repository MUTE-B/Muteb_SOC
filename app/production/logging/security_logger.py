

from datetime import datetime



class SecurityLogger:



    logs=[]



    def write(self,level,message):


        event={


        "level":level,


        "message":message,


        "time":

        str(datetime.utcnow())


        }



        self.logs.append(event)


        return event




    def read(self):


        return self.logs



