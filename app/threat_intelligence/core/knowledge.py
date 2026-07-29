

class SecurityKnowledgeBase:



    knowledge=[]



    def add(self,title,description):


        record={


        "title":

        title,


        "description":

        description



        }



        self.knowledge.append(record)


        return record




    def all(self):


        return self.knowledge



