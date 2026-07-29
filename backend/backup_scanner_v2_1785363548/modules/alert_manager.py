

import psycopg2


def save_alert(title,severity,description):


    db=psycopg2.connect(

    database="muteb_soc",

    user="postgres"

    )


    cur=db.cursor()


    cur.execute(

    """

    INSERT INTO security_events

    (source,event_type,severity,description,mitre)

    VALUES(%s,%s,%s,%s,%s)

    """,

    (

    "MUTEB_ENGINE",

    title,

    severity,

    description,

    "TA0001"

    )


    )


    db.commit()

    db.close()



