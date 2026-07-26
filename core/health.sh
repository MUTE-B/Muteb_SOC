#!/usr/bin/env bash

# ============================================================
# اسم الملف : health.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : عرض نتائج فحص جاهزية المشروع
# ============================================================

health_ok() {

    printf "[  OK  ] %s\n" "$1"

}

health_fail() {

    printf "[ FAIL ] %s\n" "$1"

}

run_health_check() {

    echo

    print_separator

    echo "Project Health Check"

    print_separator

    if directory_exists "$LOG_DIR"; then
        health_ok "Logs Directory"
    else
        health_fail "Logs Directory"
    fi

    if directory_exists "$REPORT_DIR"; then
        health_ok "Reports Directory"
    else
        health_fail "Reports Directory"
    fi

    if file_exists "$VERSION_FILE"; then
        health_ok "Version File"
    else
        health_fail "Version File"
    fi

    if command_exists bash; then
        health_ok "Bash"
    else
        health_fail "Bash"
    fi

    if command_exists grep; then
        health_ok "grep"
    else
        health_fail "grep"
    fi

    if command_exists awk; then
        health_ok "awk"
    else
        health_fail "awk"
    fi

    if [[ -w "$REPORT_DIR" ]]; then
        health_ok "Report Permission"
    else
        health_fail "Report Permission"
    fi

    echo

}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : health.sh
# الوصف        : فحص سلامة الـ Framework.
# ============================================================

framework_health_check() {

    validate_environment || return 1

    return 0

}
