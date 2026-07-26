#!/usr/bin/env bash

# ============================================================
# اسم الملف : report.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : إنشاء التقرير النهائي للمشروع
# ============================================================

# مسار التقرير

readonly REPORT_FILE="reports/Muteb_SOC_Report_$(date +%F).txt"

# إنشاء التقرير

create_report() {

    touch "$REPORT_FILE"

}

# كتابة عنوان داخل التقرير

write_title() {

    local TITLE="$1"

    echo "==================================================" >> "$REPORT_FILE"
    echo "$TITLE" >> "$REPORT_FILE"
    echo "==================================================" >> "$REPORT_FILE"

}

# كتابة سطر داخل التقرير

write_line() {

    local TEXT="$1"

    echo "$TEXT" >> "$REPORT_FILE"

}
