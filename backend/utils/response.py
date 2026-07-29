def success(data=None):

    return {
        "success":True,
        "data":data
    }


def error(msg):

    return {
        "success":False,
        "error":msg
    }
