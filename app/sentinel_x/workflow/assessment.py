

from app.sentinel_x.engine.asset_engine import AssetEngine

from app.sentinel_x.engine.risk_engine import RiskEngine

from app.sentinel_x.intelligence.findings import FindingManager

from app.sentinel_x.intelligence.ai_director import AISecurityDirector




class AssessmentWorkflow:



    def run(self,target):


        asset_engine=AssetEngine()

        risk_engine=RiskEngine()

        finding_manager=FindingManager()

        ai=AISecurityDirector()



        asset=asset_engine.register_asset(
            target
        )



        findings=[


        finding_manager.create(

        "Security Configuration Review",

        "LOW",

        "No immediate impact"

        )


        ]



        risk=risk_engine.calculate(
            findings
        )


        advice=ai.advise(
            risk
        )



        return {


        "asset":
        asset,


        "risk":
        risk,


        "ai":
        advice,


        "findings":
        findings



        }



