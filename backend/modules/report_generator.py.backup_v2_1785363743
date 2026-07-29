
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from pathlib import Path
import json


BASE_DIR = Path(__file__).resolve().parent.parent.parent

REPORT_DIR = BASE_DIR / "reports"

REPORT_DIR.mkdir(
    exist_ok=True
)



def create_report(target,data):


    filename = REPORT_DIR / f"{target}.pdf"


    doc = SimpleDocTemplate(
        str(filename)
    )


    styles=getSampleStyleSheet()


    story=[]


    story.append(
        Paragraph(
            "MUTEB SOC Enterprise Security Assessment Report",
            styles["Title"]
        )
    )


    story.append(
        Spacer(1,20)
    )


    content=json.dumps(
        data,
        indent=2,
        ensure_ascii=False
    )


    for line in content.split("\n"):

        story.append(
            Paragraph(
                line.replace("<","&lt;"),
                styles["Normal"]
            )
        )



    doc.build(story)


    return str(filename)

