

def register_enterprise_modules(app):


    modules = []


    try:

        from app.sentinel_x.register import register_sentinel

        register_sentinel(app)

        modules.append("Sentinel X")


    except Exception as e:

        print("Sentinel:",e)



    try:

        from app.governance.register import register_governance

        register_governance(app)

        modules.append("Governance")


    except Exception as e:

        print("Governance:",e)



    try:

        from app.executive_center.register import register_executive

        register_executive(app)

        modules.append("Executive")


    except Exception as e:

        print("Executive:",e)



    try:

        from app.cyber_command_center.register import register_command_center

        register_command_center(app)

        modules.append("Command Center")


    except Exception as e:

        print("Command:",e)



    try:

        from app.advanced_soc.register import register_advanced_soc

        register_advanced_soc(app)

        modules.append("Advanced SOC")


    except Exception as e:

        print("Advanced SOC:",e)



    try:

        from app.security_layer.register import register_security_layer

        register_security_layer(app)

        modules.append("Security Layer")


    except Exception as e:

        print("Security:",e)



    print("==============================")

    print("MUTEB ENTERPRISE MODULES")

    print(modules)

    print("==============================")



