

from web_security_scanner import scan_domain

from report_generator import create_report



def run_scan(target):


    result=scan_domain(target)


    create_report(

    target,

    result

    )


    return result



