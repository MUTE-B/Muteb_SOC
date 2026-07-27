
#!/bin/bash


echo "===================================="
echo " MUTEB SOC PACKAGE 8 DEPLOYMENT"
echo " LOG COLLECTION ENGINE"
echo "===================================="


mkdir -p app/collectors
mkdir -p app/normalization
mkdir -p app/api



# =================================
# Linux Log Collector
# =================================


cat > app/collectors/linux_collector.py <<'PY'


import os



class LinuxCollector:



    def read_file(
        self,
        path,
        lines=50
    ):


        events=[]


        if not os.path.exists(path):

            return events



        with open(
            path,
            "r",
            errors="ignore"
        ) as file:


            data=file.readlines()[-lines:]



        for line in data:

            events.append(
                line.strip()
            )


        return events




linux_collector=LinuxCollector()

PY




# =================================
# SSH Collector
# =================================


cat > app/collectors/ssh_collector.py <<'PY'


from app.collectors.linux_collector import linux_collector



class SSHCollector:



    def collect(self):


        return linux_collector.read_file(

            "/var/log/auth.log"

        )




ssh_collector=SSHCollector()

PY




# =================================
# Apache Collector
# =================================


cat > app/collectors/apache_collector.py <<'PY'


from app.collectors.linux_collector import linux_collector



class ApacheCollector:



    def collect(self):


        return linux_collector.read_file(

            "/var/log/apache2/access.log"

        )




apache_collector=ApacheCollector()

PY




# =================================
# Event Normalizer
# =================================


cat > app/normalization/event_normalizer.py <<'PY'


class EventNormalizer:



    def normalize(
        self,
        raw
    ):


        severity="LOW"



        if "failed" in raw.lower():

            severity="HIGH"



        if "error" in raw.lower():

            severity="MEDIUM"



        return {


            "event":raw,


            "severity":severity,


            "source":"linux"



        }




normalizer=EventNormalizer()

PY




# =================================
# Collector API
# =================================


cat > app/api/collector.py <<'PY'


from flask import Blueprint,jsonify


from app.auth.decorators import permission_required


from app.collectors.ssh_collector import ssh_collector


from app.normalization.event_normalizer import normalizer


from app.models.security_event import SecurityEvent


from app.database.database import db



collector=Blueprint(

    "collector",

    __name__

)




@collector.route(

"/ssh",

methods=["GET"]

)


@permission_required("detection")

def ssh_logs():


    logs=ssh_collector.collect()


    saved=[]



    for item in logs:


        event=normalizer.normalize(
            item
        )


        row=SecurityEvent(

            event_type="SSH",

            source="Linux",

            severity=event["severity"],

            raw_data=item

        )


        db.session.add(row)

        saved.append(item)



    db.session.commit()



    return jsonify({

        "status":"collected",

        "events":

        len(saved)

    })



PY





# =================================
# Register Blueprint
# =================================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:

    data=f.read()



if "from app.api.collector import collector" not in data:


    data=data.replace(

        "from app.api.incidents import incident",

        "from app.api.incidents import incident\nfrom app.api.collector import collector"

    )



if 'url_prefix="/api/collector"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        incident,",

        "app.register_blueprint(\n        collector,\n        url_prefix=\"/api/collector\"\n    )\n\n\n    app.register_blueprint(\n        incident,"

    )



with open(path,"w") as f:

    f.write(data)



PY





echo "Running validation..."

python3 -m compileall app



echo "===================================="
echo " PACKAGE 8 INSTALLED SUCCESSFULLY"
echo " LOG COLLECTOR ONLINE"
echo "===================================="



