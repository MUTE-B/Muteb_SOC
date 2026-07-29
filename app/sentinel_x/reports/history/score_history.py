

from datetime import datetime



class ScoreHistory:


    history=[]



    def add(self,score):


        self.history.append({

        "score":score,

        "date":
        str(datetime.utcnow())

        })


        return self.history




    def get(self):


        return self.history



