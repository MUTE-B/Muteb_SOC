

from reportlab.platypus import SimpleDocTemplate,Paragraph

from reportlab.lib.styles import getSampleStyleSheet

import os



def create_pdf(data):


    os.makedirs(
    "reports",
    exist_ok=True
    )


    path=f"reports/{data['target']}_report.pdf"


    doc=SimpleDocTemplate(path)


    styles=getSampleStyleSheet()


    content=[]


    content.append(
    Paragraph(
    "MUTEB SOC Scanner Enterprise Report",
    styles["Title"]
    )
    )


    content.append(
    Paragraph(
    f"Target: {data['target']}",
    styles["Normal"]
    )
    )


    content.append(
    Paragraph(
    f"Risk: {data['risk']}",
    styles["Normal"]
    )
    )


    for f in data["findings"]:

        content.append(
        Paragraph(
        f"{f['owasp']} - {f['title']} - {f['severity']}",
        styles["Normal"]
        )
        )


    doc.build(content)


    return path

