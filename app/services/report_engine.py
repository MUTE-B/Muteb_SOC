

import json



class ReportEngine:


    def generate(
        self,
        case
    ):


        report={

            "case_id":
            case.id,

            "status":
            case.status,

            "priority":
            case.priority,

            "analyst":
            case.analyst

        }


        with open(
            f"reports/case_{case.id}.json",
            "w"
        ) as file:

            json.dump(
                report,
                file,
                indent=4
            )


        return report



report_engine=ReportEngine()

