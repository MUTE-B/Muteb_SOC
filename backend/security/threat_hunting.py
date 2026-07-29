

def search(events,keyword):


    return [

    e for e in events

    if keyword.lower() in e.lower()

    ]



