

class DataStorage:



    records=[]



    def save(self,data):


        self.records.append(data)


        return {


        "stored":

        True,


        "records":

        len(self.records)



        }




    def all(self):


        return self.records



