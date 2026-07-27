

from datetime import datetime



IOC_DATABASE=[]



def add_ioc(data):


    data["created_at"]=str(datetime.utcnow())


    IOC_DATABASE.append(data)


    return data




def search_ioc(value):


    results=[]


    for ioc in IOC_DATABASE:


        if ioc.get("value")==value:


            results.append(ioc)



    return results




def all_ioc():


    return IOC_DATABASE

