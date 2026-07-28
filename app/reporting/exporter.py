

import json



def export_json(data,path="security_report.json"):


    with open(path,"w") as f:


        json.dump(

            data,

            f,

            indent=4

        )


    return path




def export_html(data,path="security_report.html"):


    html=f"""

<html>

<head>

<title>MUTEB SOC Report</title>

</head>

<body>

<h1>MUTEB SOC Security Report</h1>

<pre>

{data}

</pre>

</body>

</html>

"""


    with open(path,"w") as f:


        f.write(html)


    return path

