

class TenantIsolation:



    def validate(self,user_org,asset_org):


        return {


        "allowed":

        user_org == asset_org,


        "user_org":

        user_org,


        "asset_org":

        asset_org



        }



