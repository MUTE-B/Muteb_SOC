

from datetime import datetime



class AuthorizationControl:



    def verify(self,organization,asset,approval):


        return {


        "organization":
        organization,


        "asset":
        asset,


        "approval_id":
        approval,


        "authorized":
        True,


        "time":
        str(datetime.utcnow())


        }



