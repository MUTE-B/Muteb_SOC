

import json
import os
import uuid


QUEUE="logs/scanner_queue.json"



def add_job(target):


    jobs=[]


    if os.path.exists(QUEUE):

        jobs=json.load(open(QUEUE))


    job={


    "id":str(uuid.uuid4()),

    "target":target,

    "status":"queued",

    "progress":0


    }


    jobs.append(job)


    json.dump(
    jobs,
    open(QUEUE,"w"),
    indent=4
    )


    return job




def update_job(id,status,progress):


    if not os.path.exists(QUEUE):

        return


    jobs=json.load(open(QUEUE))


    for j in jobs:


        if j["id"]==id:

            j["status"]=status

            j["progress"]=progress



    json.dump(
    jobs,
    open(QUEUE,"w"),
    indent=4
    )


