
from app.models.alert import Alert

def latest_alerts(limit=20):

    try:

        rows=Alert.query.order_by(
            Alert.id.desc()
        ).limit(limit).all()

    except:

        rows=[]

    return [

        {

            "id":x.id,

            "severity":x.severity,

            "source":x.source,

            "title":x.title,

            "status":x.status

        }

        for x in rows

    ]
