

from datetime import datetime



def execute(action,data):


    return {


        "action":

        action,


        "target":

        data,


        "status":

        "EXECUTED",


        "time":

        str(datetime.utcnow())

    }




def execute_actions(actions,data):


    results=[]


    for action in actions:


        results.append(

            execute(

                action,

                data

            )

        )


    return results

