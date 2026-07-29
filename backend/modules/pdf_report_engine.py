

from reportlab.platypus import (

SimpleDocTemplate,

Paragraph,

Spacer,

Table,

TableStyle

)


from reportlab.lib.styles import getSampleStyleSheet


import os





REPORT_DIR="reports"


os.makedirs(

REPORT_DIR,

exist_ok=True

)





def create_pdf_report(

scan_id,

data

):


    path=f"{REPORT_DIR}/{scan_id}_report.pdf"



    doc=SimpleDocTemplate(

    path

    )



    styles=getSampleStyleSheet()



    content=[]




    content.append(

    Paragraph(

    "MUTEB SOC Enterprise Security Scanner Report",

    styles["Title"]

    )

    )



    content.append(

    Spacer(1,20)

    )





    info=[


    ["Target",data.get("target","")],


    ["Risk",data.get("risk","")],


    ["Date",data.get("date","")]


    ]





    table=Table(info)



    table.setStyle(

    TableStyle(

    [

    ("GRID",(0,0),(-1,-1),1,None)

    ]

    )

    )



    content.append(table)



    content.append(

    Spacer(1,20)

    )





    content.append(

    Paragraph(

    "OWASP Findings",

    styles["Heading2"]

    )

    )




    rows=[

    [

    "OWASP",

    "Severity",

    "Title"

    ]

    ]



    for f in data.get(

    "findings",

    []

    ):


        rows.append(

        [

        f.get("owasp",""),

        f.get("severity",""),

        f.get("title","")

        ]

        )





    findings_table=Table(rows)



    findings_table.setStyle(

    TableStyle(

    [

    ("GRID",(0,0),(-1,-1),1,None)

    ]

    )

    )



    content.append(

    findings_table

    )




    doc.build(

    content

    )



    return path




