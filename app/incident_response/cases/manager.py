

from datetime import datetime



class CaseManager:


    cases=[]



    def create(self,title,severity):


        case={


        "id":

        len(self.cases)+1,


        "title":

        title,


        "severity":

        severity,


        "status":

        "OPEN",


        "created":

        str(datetime.utcnow())


        }


        self.cases.append(case)


        return case



    def list(self):


        return self.cases



