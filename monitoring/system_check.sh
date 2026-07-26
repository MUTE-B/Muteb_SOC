#!/usr/bin/env bash

# ============================================================
# اسم الملف : system_check.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : جمع معلومات النظام الأساسية
# ============================================================

# ============================================================
# دالة فحص معلومات النظام
# ============================================================

system_check() {

    log_info "Collecting system information"

    echo
    echo "========== SYSTEM INFORMATION =========="

    echo "Current User : $(whoami)"

    echo "Hostname     : $(hostname)"

    echo "Operating System : $(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')"

    echo "Kernel       : $(uname -r)"

    echo "Architecture : $(uname -m)"

    echo "Uptime       : $(uptime -p)"

    echo "Load Average : $(uptime | awk -F'load average:' '{print $2}')"

    echo

}
