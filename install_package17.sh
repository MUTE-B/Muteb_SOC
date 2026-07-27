
#!/bin/bash


echo "Installing MUTEB SOC Package 17 - Reporting Engine"



mkdir -p app/reporting
mkdir -p app/api
mkdir -p reports/generated



# =====================================
# Report Generator
# =====================================


cat > app/reporting/generator.py <<'PY'


from datetime import datetime
import os



class ReportGenerator:



    def create_report(self,data):


        filename = (

            "SOC_Report_"

            +

            datetime.now().strftime(
                "%Y%m%d_%H%M%S"
            )

            +

            ".html"

        )



        path=os.path.join(

            "reports/generated",

            filename

        )



        html=f"""

<html>

<head>

<title>MUTEB SOC Report</title>

</head>


<body>


<h1>MUTEB SOC Enterprise</h1>


<h2>Security Report</h2>


<hr>


<h3>Generated</h3>

<p>{datetime.now()}</p>



<h3>Incident Data</h3>


<pre>

{data}

</pre>



</body>


</html>

"""



        with open(
            path,
            "w"
        ) as f:

            f.write(html)



        return {


            "status":
            "created",


            "file":
            path


        }





report_generator=ReportGenerator()

PY





# =====================================
# Report API
# =====================================


cat > app/api/reports.py <<'PY'


from flask import Blueprint,request,jsonify


from app.reporting.generator import report_generator



reports=Blueprint(

    "reports",

    __name__

)



@reports.route(

"/generate",

methods=["POST"]

)

def generate():


    data=request.json



    result=report_generator.create_report(

        data

    )



    return jsonify(result)



PY





# =====================================
# Register Blueprint
# =====================================


python3 - <<'PY'


file="app/core/application.py"


with open(file) as f:

    data=f.read()



if "from app.api.reports import reports" not in data:


    data=data.replace(

        "from app.api.response import response",

        "from app.api.response import response\nfrom app.api.reports import reports"

    )



if 'url_prefix="/api/reports"' not in data:


    data=data.replace(

        "app.register_blueprint(\n    response,",

        "app.register_blueprint(\n    reports,\n    url_prefix=\"/api/reports\"\n)\n\n\napp.register_blueprint(\n    response,"

    )



with open(file,"w") as f:

    f.write(data)



PY





python3 -m compileall app



echo "================================"
echo "PACKAGE 17 COMPLETE"
echo "REPORTING ENGINE READY"
echo "================================"


