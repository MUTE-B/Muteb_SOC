

from datetime import datetime



EVIDENCE=[]



def add_evidence(data):


    item={


        "id":

        len(EVIDENCE)+1,


        "type":

        data.get("type"),


        "value":

        data.get("value"),


        "collected":

        str(datetime.utcnow())

    }


    EVIDENCE.append(item)


    return item




def get_evidence():


    return EVIDENCE

