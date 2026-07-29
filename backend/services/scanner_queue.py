

import threading

import time



SCAN_STATUS={}





def run_scan(scan_id,callback):


    SCAN_STATUS[scan_id]={

    "status":"running",

    "progress":10

    }



    for p in [20,40,60,80,100]:


        time.sleep(1)


        SCAN_STATUS[scan_id]["progress"]=p



    result=callback()



    SCAN_STATUS[scan_id]["status"]="completed"


    SCAN_STATUS[scan_id]["progress"]=100


    SCAN_STATUS[scan_id]["result"]=result



    return result







def get_status(scan_id):


    return SCAN_STATUS.get(

    scan_id,

    {

    "status":"unknown",

    "progress":0

    }

    )



