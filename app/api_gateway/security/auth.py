

from datetime import datetime



class GatewaySecurity:



    def validate(self,token):


        if token:


            return {


            "authenticated":

            True,


            "time":

            str(datetime.utcnow()),


            "status":

            "AUTHORIZED"



            }


        return {


        "authenticated":

        False,


        "status":

        "DENIED"



        }



