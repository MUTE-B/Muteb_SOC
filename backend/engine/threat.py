

def threat_score(event):

    score=0


    if event.get(
    "severity"
    )=="HIGH":

        score+=60


    if event.get(
    "type"
    )=="LOGIN":

        score+=25


    return {

    "score":
    score,

    "level":
    "CRITICAL"
    if score>=70
    else
    "LOW"

    }


