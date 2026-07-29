

import os


def scan_file(path):

    result={

    "file":
    path,

    "detected":
    False

    }


    if os.path.exists(path):

        size=os.path.getsize(path)


        if size>50000000:

            result["detected"]=True


    return result

