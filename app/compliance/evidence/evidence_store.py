

from datetime import datetime



class EvidenceStore:



    evidence=[]



    def add(self,title,category):


        item={


        "id":

        len(self.evidence)+1,


        "title":

        title,


        "category":

        category,


        "status":

        "AVAILABLE",


        "created":

        str(datetime.utcnow())


        }



        self.evidence.append(item)


        return item




    def list(self):


        return self.evidence



