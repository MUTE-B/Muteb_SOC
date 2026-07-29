

import datetime



class JWTManager:



    def create_payload(self,user):


        return {


        "user":

        user,


        "issued":

        str(datetime.datetime.utcnow())


        }



