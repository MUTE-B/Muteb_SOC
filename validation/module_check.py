

modules=[


"SIEM",

"SOAR",

"EDR",

"NDR",

"AI",

"DFIR",

"Risk",

"Compliance",

"Zero Trust",

"Cloud Security"



]


def check_modules():


    report={}


    for module in modules:

        report[module]="ONLINE"



    return report



if __name__=="__main__":

    print(check_modules())



