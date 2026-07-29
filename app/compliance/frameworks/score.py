

class ComplianceScore:



    def calculate(self,total,completed):


        if total==0:

            return 0



        return round(

        (completed/total)*100

        )



