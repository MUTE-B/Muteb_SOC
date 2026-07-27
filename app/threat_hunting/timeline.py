
def create_timeline(events):

    timeline = []


    for event in events:

        timeline.append({

            "time":
            event.get("time"),

            "type":
            event.get("event_type"),

            "severity":
            event.get("severity"),

            "message":
            event.get("message")

        })


    return timeline
