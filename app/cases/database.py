

from datetime import datetime



CASES=[]



def create_case(data):


    case={


        "id":

        len(CASES)+1,


        "title":

        data.get("title","Security Case"),


        "severity":

        data.get("severity","MEDIUM"),


        "status":

        "OPEN",


        "created":

        str(datetime.utcnow()),


        "events":[]


    }


    CASES.append(case)


    return case




def get_cases():


    return CASES




def add_event(case_id,event):


    for case in CASES:


        if case["id"]==case_id:


            case["events"].append(

                {

                    "event":event,

                    "time":str(datetime.utcnow())

                }

            )


            return case



    return None

