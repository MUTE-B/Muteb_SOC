
import psycopg2


def migrate():

    con=psycopg2.connect(
        database="muteb_soc",
        user="muteb_admin",
        password="MutebDB@2026",
        host="localhost"
    )

    cur=con.cursor()


    cur.execute("""

    CREATE TABLE IF NOT EXISTS scans(

    id SERIAL PRIMARY KEY,

    target TEXT,

    risk TEXT,

    created TIMESTAMP DEFAULT NOW()

    );


    CREATE TABLE IF NOT EXISTS findings(

    id SERIAL PRIMARY KEY,

    scan_id INTEGER,

    issue TEXT,

    severity TEXT

    );


    CREATE TABLE IF NOT EXISTS reports(

    id SERIAL PRIMARY KEY,

    scan_id INTEGER,

    format TEXT,

    path TEXT

    );


    CREATE INDEX IF NOT EXISTS idx_scan_target

    ON scans(target);


    """)


    con.commit()

    con.close()


if __name__=="__main__":

    migrate()

