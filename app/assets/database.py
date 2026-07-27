

from datetime import datetime



ASSETS=[]



def add_asset(data):


    asset={


        "id":

        len(ASSETS)+1,


        "hostname":

        data.get("hostname"),


        "ip":

        data.get("ip"),


        "type":

        data.get("type","SERVER"),


        "owner":

        data.get("owner","IT"),


        "status":

        "ACTIVE",


        "created":

        str(datetime.utcnow())

    }


    ASSETS.append(asset)


    return asset




def get_assets():


    return ASSETS



