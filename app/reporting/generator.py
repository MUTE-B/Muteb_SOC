

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

